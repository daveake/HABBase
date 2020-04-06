unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvSplitter, Math,
  AdvCustomControl, Vcl.StdCtrls, ActiveX, MSHTML,
  Data.FMTBcd, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DateUtils, AdvSmoothStatusIndicator, AdvGDIP, AdvPanel, BaseTypes,
  Source, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  AdvSmoothButton;

type
    TPayloadMasks = record
        Masks:      Array[1..32] of TPayloadMask;
        Count:      Integer;
    end;

type
  TfrmMain = class(TForm)
    AdvSplitter1: TAdvSplitter;
    pnlLeft: TPanel;
    pnlLog: TPanel;
    AdvSplitter3: TAdvSplitter;
    pnlWhiteList: TPanel;
    pnlSources: TPanel;
    pnlMain: TPanel;
    pnlMiddle: TPanel;
    AdvSplitter2: TAdvSplitter;
    AdvSmoothButton2: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSplitter10: TAdvSplitter;
    pnlRight: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
  private
    { Private declarations }
    PayloadMasks: TPayloadMasks;
    procedure LoadData;
    procedure LoadForms;
    procedure LoadPayloadMasks;
    procedure LoadFormPositions;
    procedure SaveFormPositions;
  public
    { Public declarations }
    function PayloadInWhiteList(Position: THABPosition): Boolean;
    procedure UpdatedWhiteList;
  end;

var
  frmMain: TfrmMain;

implementation

uses Data,
     // Tools
     ToolWhiteList, ToolLog,
     // Main Forms
     Map, Payloads,
     // Sources
     SourcesForm,
     SystemSettings;

{$R *.dfm}

procedure TfrmMain.AdvSmoothButton1Click(Sender: TObject);
var
    frmSystemSettings: TfrmSystemSettings;
begin
    frmSystemSettings := TfrmSystemSettings.Create(nil);
    frmSystemSettings.ShowModal;
    frmSystemSettings.Free;
end;

procedure TfrmMain.AdvSmoothButton2Click(Sender: TObject);
begin
    frmSources.AddNewSource;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
const
    FirstTime: Boolean = True;
begin
    if FirstTime then begin
        FirstTime := False;

        LoadData;
        LoadFormPositions;
        LoadPayloadMasks;
        LoadForms;
    end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    SaveFormPositions;
end;

procedure TfrmMain.LoadData;
begin
    DataModule1 := TDataModule1.Create(nil);
end;

procedure TfrmMain.LoadForms;
begin
    // Map
    frmMap := TfrmMap.Create(nil);
    frmMap.pnlMain.Parent := pnlMiddle;

    // Live Payloads
    frmPayloads := TfrmPayloads.Create(nil);
    frmPayloads.pnlMain.Parent := pnlRight;

    // Log
    frmToolLog := TfrmToolLog.Create(nil);
    frmToolLog.pnlMain.Parent := pnlLog;

    // White List
    frmToolWhiteList := TfrmToolWhiteList.Create(nil);
    frmToolWhiteList.pnlMain.Parent := pnlWhiteList;

    // Sources
    frmSources := TfrmSources.Create(nil);
    frmSources.pnlMain.Parent := pnlSources;
    frmSources.LoadSources;
end;


procedure TfrmMain.LoadPayloadMasks;
begin
    with PayloadMasks, DataModule1.tblWhiteList do begin
        Count := 0;
        First;
        while not EOF do begin
            if FieldByName('Enabled').AsBoolean then begin
                Inc(Count);
                Masks[Count].HAB := FieldByName('HAB').AsBoolean;
                Masks[Count].Sonde := FieldByName('Sonde').AsBoolean;
                Masks[Count].Remote := FieldByName('Remote').AsBoolean;
                Masks[Count].Mask := FieldByName('Mask').AsString;
                Masks[Count].Distance := FieldByName('Distance').AsFloat;
            end;
            Next;
        end;
    end;
end;

function WildComp(const mask: String; const target: String): Boolean;

    // '*' matches greedy & ungreedy
    // simple recursive descent parser - not fast but easy to understand
    function WComp(const maskI: Integer; const targetI: Integer): Boolean;
    begin

        if maskI > Length(mask) then begin
            Result := targetI = Length(target) + 1;
            Exit;
        end;
        if targetI > Length(target) then begin
            // unread chars in filter or would have read '#0'
            Result := False;
            Exit;
        end;

        case mask[maskI] of
            '*':
                // '*' doesnt match '.'
                if target[targetI] <> '.' then
                    // try with and without ending match - but always matches at least one char
                    Result := WComp(succ(maskI), Succ(targetI)) or WComp(maskI, Succ(targetI))
                else
                    Result := False;
            '?':
                // ? doesnt match '.'
                if target[targetI] <> '.' then
                    Result := WComp(succ(maskI), Succ(targetI))
                else
                    Result := False;

            else     // includes '.' which only matches itself
                if mask[maskI] = target[targetI] then
                    Result := WComp(succ(maskI), Succ(targetI))
                else
                    Result := False;
        end;// case

    end;

begin
    WildComp := WComp(1, 1);
end;

function PassFilter(PayloadID, Mask: String): Boolean;
begin
    if Mask = '' then begin
        Result := True;
    end else if Copy(Mask, 1, 1) = '!' then begin
        Result := not WildComp(Copy(Mask, 2, Length(Mask)), PayloadID);
    end else begin
        Result := WildComp(Mask, PayloadID);
    end;
end;

function TfrmMain.PayloadInWhiteList(Position: THABPosition): Boolean;
var
    i: Integer;
    OK: Boolean;
begin
    with PayloadMasks do begin
        for i := 1 to Count do begin
            with Masks[i] do begin
                // Locally received ?
                OK := True;

                if not Remote then begin
                    OK := not Position.ReceivedRemotely;
                end;

                // Distance
                if OK then begin
                    if Distance > 1 then begin
                        OK := Position.Distance < Distance;
                    end;

                    // Balloon type
                    if OK then begin
                        if HAB and Sonde then begin
                            OK := True;
                        end else if HAB and not Sonde then begin
                            OK := PassFilter(Position.PayloadID, '!RS_*');
                        end else if Sonde and not HAB then begin
                            OK := PassFilter(Position.PayloadID, 'RS_*');
                        end else begin
                            OK := False;
                        end;

                        // Mask
                        if OK then begin
                            OK := PassFilter(Position.PayloadID, Mask);
                        end;

                        if OK then begin
                            Result := True;
                            Exit;
                        end;
                    end;
                end;
            end;
            Next;
        end;
    end;

    Result := False;
end;

procedure TfrmMain.UpdatedWhiteList;
begin

end;

procedure TfrmMain.LoadFormPositions;
begin
    with DataModule1.tblSettings do begin
        if RecordCount = 0 then begin
            Append;
            FieldByName('Callsign').AsString := 'M0RPI';
            FieldByName('Latitude').AsFloat := 51.95023;
            FieldByName('Longitude').AsFloat := -2.54445;
            Post;
        end else begin
            // Form
            Left := FieldByName('FormLeft').AsInteger;
            Top := FieldByName('FormTop').AsInteger;
            Height := FieldByName('FormHeight').AsInteger;
            Width := FieldByName('FormWidth').AsInteger;

            // Side Panels
            pnlLeft.Width := FieldByName('LeftWidth').AsInteger;
            pnlRight.Width := FieldByName('RightWidth').AsInteger;

            // Panels
            pnlWhiteList.Height := FieldByName('TopMiddleHeight').AsInteger;
            pnlSources.Height := FieldByName('BottomLeftHeight').AsInteger;
        end;
    end;
end;

procedure TfrmMain.SaveFormPositions;
begin
    with DataModule1.tblSettings do begin
        Edit;
        // Form
        FieldByName('FormLeft').AsInteger := Left;
        FieldByName('FormTop').AsInteger := Top;
        FieldByName('FormHeight').AsInteger := Height;
        FieldByName('FormWidth').AsInteger := Width;

        // Side Panels
        FieldByName('LeftWidth').AsInteger := pnlLeft.Width;
        FieldByName('RightWidth').AsInteger := pnlRight.Width;

        // Panels
        FieldByName('TopMiddleHeight').AsInteger := pnlWhiteList.Height;
        FieldByName('BottomLeftHeight').AsInteger := pnlSources.Height;

        Post;
        SaveToFile(ExtractFilePath(Application.ExeName) + 'settings.json');
    end;
end;


end.
