unit SourcesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls, Vcl.ExtCtrls, BaseTypes,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, AdvSmoothStatusIndicator, AdvGDIP,
  Data.FMTBcd, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, AdvSmoothButton,
  Source, SourceForm,
  GatewaySource, AdvPanel; // HabitatSource, UDPSource, SerialSource, BluetoothSource,


type
    THABSource = record
        InUse:              Boolean;
        ID:                 Integer;
        Enabled:            Boolean;
        Connected:          Boolean;
        Description:        String;
        Code:               String;
        SourceType:         TSourceType;
        SourceForm:         TfrmSource;
        Indicator:          TAdvSmoothStatusIndicator;
        Source:             TSource;
//        ValueLabel:   TLabel;
//        RSSILabel:    TLabel;
//        CurrentRSSI:  String;
//        PacketRSSI:   String;
//        FreqError:    String;
        LatestPosition:     THABPosition;
    end;

type
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
  TfrmSources = class(TfrmNormal)
    DBAdvGrid1: TDBAdvGrid;
    pnlStatus: TAdvPanel;
  private
    { Private declarations }
    HABSources: Array[1..32] of THABSource;
    HABPayloads: Array[1..32] of TPayload;
    procedure LoadSource(SourceIndex, pID: Integer; pCode: String; pSourceType: TSourceType);
    function AddPayloadToFullTable(Position: THABPosition): Boolean;
    function AddPayloadToLiveTable(Position: THABPosition): Boolean;
    function AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
    function AddPayloadToOurList(Position: THABPosition): Integer;
    function FindOrAddPayload(PayloadID: String): Integer;
    procedure HABCallback(ID: Integer; Connected: Boolean; Line: String; Position: THABPosition);
    procedure DataSourceClick(Sender: TObject);
  public
    { Public declarations }
    procedure LoadSources;
    procedure NewPosition(SourceIndex: Integer; Position: THABPosition);
    procedure ShowConnected(SourceIndex: Integer; IsConnected: Boolean);
  end;

var
  frmSources: TfrmSources;

implementation

{$R *.dfm}

uses Data, Logtail, Main, ToolLog, Map, Miscellaneous, SettingsForm, GatewaySettings;

procedure TfrmSources.LoadSources;
var
    Index: Integer;
begin
    InitialiseSettings;

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

procedure TfrmSources.LoadSource(SourceIndex, pID: Integer; pCode: String; pSourceType: TSourceType);
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
            SourceForm := TfrmLogtail.Create(nil);
            SourceForm.pnlMain.Parent := frmMain.pnlHidden;
        end else if SourceType = stGateway then begin
            Source := TGatewaySource.Create(SourceIndex, '', HABCallback);


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
            SourceForm := nil;
        end;

        if SourceForm <> nil then begin
            SourceForm.SourceIndex := SourceIndex;
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
            OnClick := DataSourceClick;
        end;
    end;
end;


procedure TfrmSources.NewPosition(SourceIndex: Integer; Position: THABPosition);
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

        if frmMain.PayloadInWhiteList(Position) then begin
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

function TfrmSources.AddPayloadToFullTable(Position: THABPosition): Boolean;
begin
    Result := AddPayloadToTable(Position, DataModule1.tblAllPayloads);
end;

function TfrmSources.AddPayloadToLiveTable(Position: THABPosition): Boolean;
begin
    Result := AddPayloadToTable(Position, DataModule1.tblLivePayloads);
end;

function TfrmSources.AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
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


function TfrmSources.AddPayloadToOurList(Position: THABPosition): Integer;
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
                Parent := frmMain.pnlButtons;   // pnlStatus;
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

function TfrmSources.FindOrAddPayload(PayloadID: String): Integer;
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

procedure TfrmSources.ShowConnected(SourceIndex: Integer; IsConnected: Boolean);
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

procedure TfrmSources.HABCallback(ID: Integer; Connected: Boolean; Line: String; Position: THABPosition);
var
    Callsign: String;
begin
    // New Position
    if Position.InUse then begin
        NewPosition(ID, Position);

//        if ID = SERIAL_SOURCE then begin
//            if GetSettingBoolean('LoRaSerial', 'Habitat', False) then begin
//                Callsign := GetSettingString('General', 'Callsign', '');
//                if Callsign <> '' then begin
//                    HabitatUploader.SaveTelemetryToHabitat(ID, Position.Line, Callsign);
//                end;
//            end;
//        end else if ID = BLUETOOTH_SOURCE then begin
//            if GetSettingBoolean('LoRaBluetooth', 'Habitat', False) then begin
//                Callsign := GetSettingString('General', 'Callsign', '');
//                if Callsign <> '' then begin
//                    HabitatUploader.SaveTelemetryToHabitat(ID, Position.Line, Callsign);
//                end;
//            end;
//        end;

//        Sources[ID].ValueLabel.Text := Copy(Position.Line, 1, 100);
    end else if Line <> '' then begin
//        Sources[ID].ValueLabel.Text := Line;
    end;

    // SSDV Packet
//    if Position.IsSSDV then begin
//        if GetSettingBoolean('LoRaSerial', 'SSDV', False) then begin
//            Callsign := GetSettingString('LoRaSerial', 'Callsign', '');
//            if Callsign <> '' then begin
//                HabitatUploader.SaveSSDVToHabitat(Position.Line, Callsign);
//            end;
//        end;
//    end;

//    if Position.HasCurrentRSSI then begin
//        Sources[ID].CurrentRSSI := 'Current RSSI ' + IntToStr(Position.CurrentRSSI)
//    end;

//    if Position.HasPacketRSSI then begin
//        Sources[ID].PacketRSSI := ',    Packet RSSI ' + IntToStr(Position.PacketRSSI);
//    end;

//    if Position.HasFrequency then begin
//        Sources[ID].FreqError := ',    Frequency Offset = ' + FormatFloat('0', Position.FrequencyError*1000) + ' Hz';
//    end;

//    if Sources[ID].RSSILabel <> nil then begin
//        Sources[ID].RSSILabel.Text := Sources[ID].CurrentRSSI + Sources[ID].PacketRSSI + Sources[ID].FreqError;
//    end;
end;

procedure TfrmSources.DataSourceClick(Sender: TObject);
var
    SourceIndex: Integer;
    SettingsForm: TfrmSettings;
begin
    // Which source?
    SourceIndex := TComponent(Sender).Tag;
    SettingsForm := nil;

    case HABSources[SourceIndex].SourceType of
        stLogtail:  SettingsForm := nil;
        stGateway:  SettingsForm := TfrmGatewaySettings.Create(nil);
        stTCP:      SettingsForm := nil;
        stUDP:      SettingsForm := nil;
        stSerial:   SettingsForm := nil;
        // stDLFLDigi, stSerial, stHabitat, stUDP);
    end;

    if SettingsForm <> nil then begin
        SettingsForm.ShowModal;
        SettingsForm.Free;
    end;
end;

end.
