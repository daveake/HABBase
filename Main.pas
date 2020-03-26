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
  Source, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  AdvSmoothButton;

type
    THABSource = record
        InUse:              Boolean;
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

    TPayload = record
        InUse:              Boolean;
        Position:           THABPosition;
        Button:             TAdvSmoothButton;
//        PayloadID:      String;
//        Form:           TfrmPayload;
//        // Indicator:      TAdvSmoothStatusIndicator;
//        Position:       THABPosition;
//        GotGPS:         Boolean;
//        Count:          Integer;
//        AscentRate:     Double;
        BalloonColour:  String;
//        FlightMode:     TFlightMode;
//        LastUpdate:     TDateTime;
    end;

type
  TfrmMain = class(TForm)
    AdvSplitter1: TAdvSplitter;
    pnlLeft: TPanel;
    AdvSplitter2: TAdvSplitter;
    pnlLog: TPanel;
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
    pnlPayloads: TPanel;
    AdvSplitter6: TAdvSplitter;
    pnlButtons: TAdvPanel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    HABSources: Array[1..32] of THABSource;
    HABPayloads: Array[1..32] of TPayload;
    PayloadMasks: TPayloadMasks;
    procedure LoadData;
    procedure LoadTools;
    procedure LoadForms;
    procedure LoadSources;
    function AddPayloadToFullTable(Position: THABPosition): Boolean;
    function AddPayloadToLiveTable(Position: THABPosition): Boolean;
    function AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
    procedure LoadSource(SourceIndex, pID: Integer; pCode: String; pSourceType: TSourceType);
    procedure LoadPayloadMasks;
    function PayloadInWhiteList(Position: THABPosition): Boolean;
    function FindOrAddPayload(PayloadID: String): Integer;
    function AddPayloadToOurList(Position: THABPosition): Integer;
  public
    { Public declarations }
    procedure ShowConnected(SourceIndex: Integer; IsConnected: Boolean);
    procedure NewPosition(SourceIndex: Integer; Position: THABPosition);
    procedure UpdatedWhiteList;
  end;

var
  frmMain: TfrmMain;

implementation

uses Data,
     // Tools
     ToolLivePayload, ToolWhiteList, ToolLog, ToolSources,
     // Main Forms
     Map, Payloads,
     // Sources
     Logtail;

{$R *.dfm}

procedure TfrmMain.FormActivate(Sender: TObject);
const
    FirstTime: Boolean = True;
begin
    if FirstTime then begin
        FirstTime := False;
        LoadData;
        LoadPayloadMasks;
        LoadTools;
        LoadForms;
        LoadSources;
    end;
end;

procedure TfrmMain.LoadData;
begin
    DataModule1 := TDataModule1.Create(nil);
end;

procedure TfrmMain.LoadTools;
begin
    // Live payloads
    frmToolLivePayloads := TfrmToolLivePayloads.Create(nil);
    frmToolLivePayloads.pnlMain.Parent := pnlPayloads;

    // Log
    frmToolLog := TfrmToolLog.Create(nil);
    frmToolLog.pnlMain.Parent := pnlLog;

    // White List
    frmToolWhiteList := TfrmToolWhiteList.Create(nil);
    frmToolWhiteList.pnlMain.Parent := pnlWhiteList;

    // Sources
    frmToolSources := TfrmToolSources.Create(nil);
    frmToolSources.pnlMain.Parent := pnlSources;
end;

procedure TfrmMain.LoadForms;
begin
    // Map
    frmMap := TfrmMap.Create(nil);
    frmMap.pnlMain.Parent := pnlMiddle;

    // Live Payloads
    frmPayloads := TfrmPayloads.Create(nil);
    frmPayloads.pnlMain.Parent := pnlTop;
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
    // HABSources[SourceIndex] := THABSource.Create;

    with HABSources[SourceIndex] do begin
        InUse := True;
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
                frmToolLog.lstLog.ItemIndex := frmToolLog.lstLog.Items.Add('Added ' + Position.PayloadID);
                Index := AddPayloadToOurList(Position);

                if Index > 0 then begin
                    // Update Map
                    frmMap.ProcessNewPosition(Position, HABPayloads[Index].BalloonColour);
                end;
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

procedure TfrmMain.UpdatedWhiteList;
begin

end;

function TfrmMain.FindOrAddPayload(PayloadID: String): Integer;
var
    i: Integer;
begin
    for i := Low(HABPayloads) to High(HABPayloads) do begin
        if HABPayloads[i].InUse then begin
            if HABPayloads[i].Position.PayloadID = PayloadID then begin
                Result := i;
                Exit;
            end;
        end;
    end;

    // Add new one
    for i := Low(HABPayloads) to High(HABPayloads) do begin
        if not HABPayloads[i].InUse then begin
            Result := i;
            Exit;
        end;
    end;

    Result := 0;
end;

function TfrmMain.AddPayloadToOurList(Position: THABPosition): Integer;
const
    ColourTexts: Array[0..3] of String = ('blue', 'red', 'green', 'yellow');
    BGColours: Array[0..3] of TColor = (clBlue, clRed, clGreen, clYellow);
    FGColours: Array[0..3] of TColor = (clWhite, clBlack, clWhite, clBlack);
var
    Index: Integer;
begin
    Index := FindOrAddPayload(Position.PayloadID);

    if Index > 0 then begin
        // Not full up yet
        if not HABPayloads[Index].InUse then begin
            HABPayloads[Index].InUse := True;
            HABPayloads[Index].BalloonColour := ColourTexts[Index mod (High(BGColours)+1)];

            // Add button
            HABPayloads[Index].Button := TAdvSmoothButton.Create(nil);
            with HABPayloads[Index].Button do begin
                Parent := pnlButtons;   // pnlStatus;
                Align := alLeft;
                AlignWithMargins := True;
                Margins.Left := 2;
                Margins.Top := 0;
                Margins.Right := 2;
                Margins.Bottom := 0;
                Shadow := True;
                Appearance.Font.Size := 12;
                Appearance.Rounding := 8;
                Appearance.WordWrapping := False;
                Status.Visible := True;
                Status.Caption := '0s';
                Status.Appearance.Fill.Color := clGreen;
                Status.Appearance.Font.Color := clWhite;
                Caption := Position.PayloadID;
                Width := Length(Position.PayloadID) * 8 + 32;
                Color := BGColours[Index mod (High(BGColours)+1)];
                Appearance.Font.Color := FGColours[Index mod (High(FGColours)+1)];
                Tag := Index;
                // OnClick := PayloadClick;
            end;
        end;
    end;

    Result := Index;
end;


end.
