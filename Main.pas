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
  SourceForm,
  Source, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid;

type
//    THABPosition = record
//        PayloadID:      String;
//        PayloadDocID:   String;
//        TimeStamp:      TDateTime;
//        Latitude:       Double;
//        Longitude:      Double;
//        Altitude:       Double;
//        Distance:       Double;
//    end;

//    TFlightMode = (fmIdle, fmLaunched, fmDescending, fmHoming, fmDirect, fmDownwind, fmUpwind, fmLanding, fmLanded);

    THABSource = class
        public
            ID:                 Integer;
            Enabled:            Boolean;
            Connected:          Boolean;
            Description:        String;
            Code:               String;
            // SectionName:     String;
            // Index:           Integer;
            SourceType:         TSourceType;
            Form:               TfrmSource;
            Indicator:          TAdvSmoothStatusIndicator;
            LatestPosition:     THABPosition;
    end;

    TPayloadMasks = record
        Masks:      Array[1..32] of TPayloadMask;
        Count:      Integer;
    end;

type
  TfrmMain = class(TForm)
    AdvSplitter1: TAdvSplitter;
    pnlLeft: TPanel;
    AdvSplitter2: TAdvSplitter;
    plMiddleLeft: TPanel;
    AdvSplitter3: TAdvSplitter;
    pnlWhiteList: TPanel;
    pnlSources: TPanel;
    pnlMain: TPanel;
    AdvSplitter4: TAdvSplitter;
    AdvSplitter5: TAdvSplitter;
    pnlMiddle: TPanel;
    pnlTop: TPanel;
    pnlBottom: TPanel;
    pnlStatus: TAdvPanel;
    pnlHidden: TPanel;
    lstLog: TListBox;
    DBAdvGrid1: TDBAdvGrid;
    pnlPayloads: TPanel;
    AdvSplitter6: TAdvSplitter;
    DBAdvGrid2: TDBAdvGrid;
    DBAdvGrid3: TDBAdvGrid;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    HABSources: Array[1..32] of THABSource;
    PayloadMasks: TPayloadMasks;
    procedure LoadData;
    procedure LoadForms;
    procedure LoadSources;
    function AddPayloadToFullTable(Position: THABPosition): Boolean;
    function AddPayloadToLiveTable(Position: THABPosition): Boolean;
    function AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
    procedure LoadSource(SourceIndex, pID: Integer; pCode: String; pSourceType: TSourceType);
    procedure LoadPayloadMasks;
    function PayloadInWhiteList(Position: THABPosition): Boolean;
  public
    { Public declarations }
    procedure ShowConnected(SourceIndex: Integer; IsConnected: Boolean);
    procedure NewPosition(SourceIndex: Integer; Position: THABPosition);
  end;

var
  frmMain: TfrmMain;

implementation

uses Data, Sources, Payloads, Logtail;

{$R *.dfm}

procedure TfrmMain.FormActivate(Sender: TObject);
const
    FirstTime: Boolean = True;
begin
    if FirstTime then begin
        FirstTime := False;
        LoadData;
        LoadPayloadMasks;
        LoadForms;
        LoadSources;
    end;
end;

procedure TfrmMain.LoadData;
begin
    DataModule1 := TDataModule1.Create(nil);
end;

procedure TfrmMain.LoadForms;
begin
//    frmSources.pnlMain.Parent := pnlSources;
//    frmPayloads.pnlMain.Parent := pnlPayloads;
end;

procedure TfrmMain.LoadSources;
var
    Index: Integer;
begin
    with DataModule1.tblSources do begin
        First;
        Index := 0;
        while not EOF do begin
            Inc(Index);
            LoadSource(Index, FieldByName('ID').AsInteger, FieldByName('Code').AsString, TSourceType(FieldByName('Type').AsInteger));
            Next;
        end;
    end;
end;

function TfrmMain.AddPayloadToFullTable(Position: THABPosition): Boolean;
begin
    Result := AddPayloadToTable(Position, DataModule1.tblAllPayloads);
end;

function TfrmMain.AddPayloadToLiveTable(Position: THABPosition): Boolean;
begin
    Result := AddPayloadToTable(Position, DataModule1.tblLivePayloads);
end;

function TfrmMain.AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
var
    Bookmark: TBookmark;
begin
    Result := False;

    with Table do begin
        Bookmark := GetBookmark;
        DisableControls;
        if FindKey([Position.PayloadID]) then begin
            Edit;
        end else begin
            Append;
            FieldByName('PayloadID').AsString := Position.PayloadID;
            Result := True;
        end;

        FieldByName('PayloadID').AsString := Position.PayloadID;
        // FieldByName('DocID').AsString := Position.PayloadDocID;
        FieldByName('Counter').AsInteger := Position.Counter;
        FieldByName('TimeStamp').AsDateTime := Position.TimeStamp;
        FieldByName('Latitude').AsFloat := Position.Latitude;
        FieldByName('Longitude').AsFloat := Position.Longitude;
        FieldByName('Altitude').AsFloat := Position.Altitude;
        FieldByName('Distance').AsFloat := Position.Distance;
        FieldByName('ReceivedLocally').AsBoolean := False;

        Post;

        GotoBookmark(Bookmark);

        EnableControls;
    end;
end;


procedure TfrmMain.LoadSource(SourceIndex, pID: Integer; pCode: String; pSourceType: TSourceType);
begin
    HABSources[SourceIndex] := THABSource.Create;

    with HABSources[SourceIndex] do begin
        ID := pID;
        Code := pCode;
        SourceType := pSourceType;

        // Index := SourceIndex;
        // SectionName := Section;

        // Enabled := INI.ReadBool(Section, 'Enabled', True);
//        Description := INI.ReadString(Section, 'Description', 'Source ' + IntToStr(SourceIndex));
//        Code := INI.ReadString(Section, 'Code', IntToStr(SourceIndex));

//        SourceTypeText := INI.ReadString(Section, 'Type', '');

    // TSourceType = (stLogtail, stGateway, stTCP, stUDP, stSerial);       // stDLFLDigi, stSerial, stHabitat, stUDP);
        if SourceType = stLogtail then begin
            Form := TfrmLogtail.Create(nil);
            Form.pnlMain.Parent := pnlHidden;
//        end else if SourceTypeText = 'DLFLDigi' then begin
//            SourceType := stDLFLDigi;
//            Form := TfrmDLFLDigiSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'Serial' then begin
//            SourceType := stSerial;
//            Form := TfrmLoRaSerialSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'Habitat' then begin
//            SourceType := stHabitat;
//            Form := TfrmHabitatSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'UDP' then begin
//            SourceType := stUDP;
//            Form := TfrmUDPSource.Create(nil, HABDB, HabitatThread, SourceIndex);
        end else begin
            Form := nil;
        end;

        if Form <> nil then begin
            Form.SourceIndex := SourceIndex;
//            Form.HideYourself;

//            Form.Caption := Form.Caption + ' - ' + Description;

//            Form.LoadSettings;

            // Status bar button
        end;

        Indicator := TAdvSmoothStatusIndicator.Create(Self);
        with Indicator do begin
            Parent := pnlStatus;
            Align := alRight;
            AlignWithMargins := True;
            BorderWidth := 1;
            Appearance.Fill.Color := clGray;
            Appearance.Fill.ColorMirror := clNone;
            Appearance.Fill.ColorMirrorTo := clNone;
            Appearance.Fill.GradientType := TAdvGradientType.gtSolid;
            Appearance.Fill.BorderColor := 3355443;
            Appearance.Fill.Rounding := 18;
            Appearance.Fill.ShadowOffset := 0;
            Appearance.Font.Height := -24;
            Appearance.Font.Color := clWhite;
            AutoSize := True;
            Caption := Code;
            Tag := SourceIndex;
            // PopupMenu := menuSource;
            // OnClick := DataSourceClick;
        end;
    end;
end;

procedure TfrmMain.NewPosition(SourceIndex: Integer; Position: THABPosition);
var
    Index: Integer;
    PositionString: String;
begin
    HABSources[SourceIndex].LatestPosition := Position;

    if Position.PayloadID <> '' then begin
//            if Position.PayloadDocID = '' then begin
//                PositionString := Position.PayloadID + ' ** NO PAYLOAD DOC **';
//            end else begin
//                PositionString := Position.PayloadID + ' ' + Position.PayloadDocID + ':' +
//                                  FormatDateTime('hh:nn:ss', Position.TimeStamp) + ', ' +
//                                  FormatFloat('0.00000', Position.Latitude) + ', ' +
//                                  FormatFloat('0.00000', Position.Longitude) + ', ' +
//                                  FormatFloat('0', Position.Altitude) + ', ' +
//                                  FormatFloat('0', Position.Distance) + 'km';
//            end;

        AddPayloadToFullTable(Position);

        if PayloadInWhiteList(Position) then begin
            if AddPayloadToLiveTable(Position) then begin
                lstLog.ItemIndex := lstLog.Items.Add('Added ' + Position.PayloadID);
            end;
        end;

       // Update indicator
        HABSources[SourceIndex].Indicator.Appearance.Fill.Color := clGreen;
    end;
end;


procedure TfrmMain.ShowConnected(SourceIndex: Integer; IsConnected: Boolean);
begin
    with HABSources[SourceIndex] do begin
        Connected := IsConnected;
        if IsConnected then begin
            Indicator.Appearance.Fill.Color := clOlive;
        end else begin
            Indicator.Appearance.Fill.Color := clRed;
        end;
    end;
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
                Masks[Count].Local := FieldByName('Local').AsBoolean;
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
                // Locally received
                OK := True;

                if Local then begin
                    OK := Position.ReceivedLocally;
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


end.
