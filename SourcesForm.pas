unit SourcesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls, Vcl.ExtCtrls, BaseTypes,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, AdvSmoothStatusIndicator, AdvGDIP,
  Data.FMTBcd, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, AdvSmoothButton, AdvPanel,
  Source, SourceForm, Vcl.Menus, Habitat,
  GatewaySource, SerialSource; // HabitatSource, UDPSource, SerialSource, BluetoothSource,


type
    THABSource = record
        InUse:              Boolean;
        SourceID:           Integer;
        Group:              String;
        // Enabled:            Boolean;
        Connected:          Boolean;
        Code:               String;
        Description:        String;
        SourceType:         TSourceType;
        SourceForm:         TfrmSource;
        Indicator:          TAdvSmoothStatusIndicator;
        Source:             TSource;
        Upload:             Boolean;
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
    menuSource: TPopupMenu;
    View1: TMenuItem;
    ModifySource: TMenuItem;
    DeleteSource: TMenuItem;
    AddNewSource: TMenuItem;
    procedure ModifySourceClick(Sender: TObject);
    procedure DeleteSourceClick(Sender: TObject);
    procedure AddNewSourceClick(Sender: TObject);
  private
    { Private declarations }
    HABSources: Array[1..32] of THABSource;
    HABPayloads: Array[1..32] of TPayload;
    HabitatUploader: THabitatThread;
    procedure LoadSource(SourceIndex: Integer);
    procedure ReloadSourceSettings(SourceIndex: Integer);
    procedure LoadSourceSettings(SourceIndex: Integer);
    function AddPayloadToFullTable(Position: THABPosition): Boolean;
    function AddPayloadToLiveTable(Position: THABPosition): Boolean;
    function AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
    function AddPayloadToOurList(Position: THABPosition): Integer;
    function FindOrAddPayload(PayloadID: String): Integer;
    procedure HABCallback(SourceIndex: Integer; Connected: Boolean; Line: String; Position: THABPosition);
    procedure DataSourceClick(Sender: TObject);
    function ShowSettingsForm(SourceIndex: Integer): Boolean;
    function FindFreeSource: Integer;
    procedure HabitatStatusCallback(SourceID: Integer; Active, OK: Boolean);
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

uses Data, Logtail, Main, ToolLog, Map, Miscellaneous, SettingsForm, NewSource, Misc,
     GatewaySettings, LoRaSerialSettings;

procedure TfrmSources.LoadSources;
var
    SourceIndex: Integer;
begin
    InitialiseSettings;

    // Habitat uploader
    HabitatUploader := THabitatThread.Create(HabitatStatusCallback);


    with DataModule1.tblSources do begin
        First;
        SourceIndex := 0;
        while not EOF do begin
            Inc(SourceIndex);
            LoadSource(SourceIndex);
            Next;
        end;
    end;
end;

procedure TfrmSources.ModifySourceClick(Sender: TObject);
var
    SourceIndex: Integer;
begin
    // Find source
    SourceIndex := menuSource.PopupComponent.Tag;

    if ShowSettingsForm(SourceIndex) then begin
        ReloadSourceSettings(SourceIndex);
    end;
end;

function GetSettingName(var Settings: String): String;
begin
    Result := GetString(Settings, '=');
end;

function GetSettingValue(var Settings: String): String;
begin
    Result := GetString(Settings, ';');
end;

procedure TfrmSources.LoadSource(SourceIndex: Integer);
begin
    with HABSources[SourceIndex], DataModule1.tblSources do begin
        InUse := True;
        SourceID := FieldByName('ID').AsInteger;
        Group := SourceID.ToString;

        SourceType := TSourceType(FieldByName('Type').AsInteger);

        if SourceType = stLogtail then begin
            SourceForm := TfrmLogtail.Create(nil);
            SourceForm.pnlMain.Parent := frmMain.pnlHidden;
        end else if SourceType = stGateway then begin
            Source := TGatewaySource.Create(SourceIndex, Group, HABCallback);
        end else if SourceType = stSerial then begin
            Source := TSerialSource.Create(SourceIndex, Group, HABCallback);
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
            Tag := SourceIndex;
            PopupMenu := menuSource;
            OnClick := DataSourceClick;
        end;

        LoadSourceSettings(SourceIndex);
    end;
end;

procedure TfrmSources.LoadSourceSettings(SourceIndex: Integer);
var
    Settings, Setting, Value: String;
begin
    with HABSources[SourceIndex], DataModule1.tblSources do begin
        Code := FieldByName('Code').AsString;
        Description := FieldByName('Name').AsString;

        Settings := FieldByName('Settings').AsString;

        Upload := GetBooleanSetting('Upload', Settings);

        // Add to source settings
        SetSettingBoolean(Group, 'Enabled', FieldByName('Enabled').AsBoolean);
        SetSettingString(Group, 'Host', FieldByName('Host').AsString);
        SetSettingString(Group, 'Port', FieldByName('Port').AsString);

        while Settings <> '' do begin
            Setting := GetSettingName(Settings);
            Value := GetSettingValue(Settings);
            if (Setting <> '') and (Value <> '') then begin
                SetSettingString(Group, Setting, Value);
            end;
        end;

        if SourceForm <> nil then begin
            SourceForm.Enabled := FieldByName('Enabled').AsBoolean;
        end;

        Indicator.Caption := Code;
    end;
end;

procedure TfrmSources.ReloadSourceSettings(SourceIndex: Integer);
begin
    with HABSources[SourceIndex] do begin
        with DataModule1.tblSources do begin
            if FindKey([SourceID]) then begin
                LoadSourceSettings(SourceIndex);
            end;
        end;
    end;
end;


procedure TfrmSources.NewPosition(SourceIndex: Integer; Position: THABPosition);
var
    Index: Integer;
    Callsign: String;
begin
    HABSources[SourceIndex].LatestPosition := Position;

    if Position.PayloadID <> '' then begin
        if HABSources[SourceIndex].Upload then begin
            Callsign := 'M0RPI';            // !!!!
            if Callsign <> '' then begin
                HabitatUploader.SaveTelemetryToHabitat(SourceIndex, Position.Line, Callsign);
            end;
        end;

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


function TfrmSources.FindFreeSource: Integer;
var
    i: Integer;
begin
    for i := Low(HABSources) to High(HABSources) do begin
        if not HABSources[i].InUse then begin
            Result := i;
            Exit;
        end;
    end;

    Result := 0;
end;


procedure TfrmSources.AddNewSourceClick(Sender: TObject);
var
    SourceIndex: Integer;
begin
    SourceIndex := FindFreeSource;

    if SourceIndex > 0 then begin
        // We can add a new source
        frmNewSource := TfrmNewSource.Create(nil);

        if frmNewSource.ShowModal = mrOK then begin

            // Add to table
            with DataModule1.tblSources do begin
                Append;
                FieldByName('Enabled').AsBoolean := True;
                FieldByName('Type').AsInteger := frmNewSource.ComboBox1.ItemIndex;
                Post;
                Last;

                // Fill in settings
                if ShowSettingsForm(SourceIndex) then begin
                    // Load source
                    LoadSource(SourceIndex);
                end else begin
                    // Delete from table
                    Delete;
                end;

                SaveToFile(ExtractFilePath(Application.ExeName) + 'sources.json');
            end;
        end;

        frmNewSource.Free;
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
    MyBookmark: TBookmark;
begin
    Result := False;

    with Table do begin
        MyBookmark := GetBookmark;
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

        GotoBookmark(MyBookmark);

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
            HABPayloads[Index].BalloonColour := ColourTexts[(Index-1) mod (High(BGColours)+1)];

            // Add button
            HABPayloads[Index].Button := TAdvSmoothButton.Create(nil);
            with HABPayloads[Index].Button do begin
                Parent := frmMain.pnlButtons;   // pnlStatus;
                Align := alLeft;
                AlignWithMargins := True;
                Margins.Left := 2;
                Margins.Top := 3;
                Margins.Right := 2;
                Margins.Bottom := 0;
                Shadow := False;    // True;
                Appearance.Font.Size := 12;
                Appearance.Rounding := 8;
                Appearance.WordWrapping := False;
                Status.Visible := True;
                Status.Caption := '0s';
                Status.Appearance.Fill.Color := clGreen;
                Status.Appearance.Font.Color := clWhite;
                Caption := Position.PayloadID;
                Width := Length(Position.PayloadID) * 8 + 32;
                Color := BGColours[(Index-1) mod (High(BGColours)+1)];
                Appearance.Font.Color := FGColours[(Index-1) mod (High(FGColours)+1)];
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

procedure TfrmSources.HABCallback(SourceIndex: Integer; Connected: Boolean; Line: String; Position: THABPosition);
var
    Callsign: String;
begin
    // New Position
    if Position.InUse then begin
        NewPosition(SourceIndex, Position);

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
begin
    // Which source?
    SourceIndex := TComponent(Sender).Tag;

    if ShowSettingsForm(SourceIndex) then begin
        ReloadSourceSettings(SourceIndex);
    end;
end;

procedure TfrmSources.DeleteSourceClick(Sender: TObject);
var
    SourceIndex: Integer;
begin
    SourceIndex := menuSource.PopupComponent.Tag;

    with HABSources[SourceIndex] do begin
        if MessageDlg('Are you sure you want to permanently remove ' + Code + ': ' + Description + ' ?',
                  mtWarning, mbOKCancel, 0) = mrOK then begin

            // Delete from table
            with DataModule1.tblSources do begin
                if FindKey([SourceID]) then begin
                    Delete;
                end;
            end;

            // Delete from list
            if SourceForm <> nil then begin
                SourceForm.Free;
                SourceForm := nil;
            end;

            Indicator.Free;
            InUse := False;
            SourceID := 0;
        end;
    end;
end;

function TfrmSources.ShowSettingsForm(SourceIndex: Integer): Boolean;
var
    SettingsForm: TfrmSettings;
begin
    Result := False;

    case HABSources[SourceIndex].SourceType of
        stLogtail:  SettingsForm := nil;
        stGateway:  SettingsForm := TfrmGatewaySettings.Create(nil);
        stSerial:   SettingsForm := TfrmLoRaSerialSettings.Create(nil);
        stTCP:      SettingsForm := nil;
        stUDP:      SettingsForm := nil;
        stHabitat:  SettingsForm := nil;
        else        SettingsForm := nil;
    end;

    if SettingsForm <> nil then begin
        Result := SettingsForm.LoadForm(HABSources[SourceIndex].SourceID);
        SettingsForm.Free;
    end;
end;

procedure TfrmSources.HabitatStatusCallback(SourceID: Integer; Active, OK: Boolean);
begin
    // frmMain.UploadStatus(SourceID, Active, OK);
end;


end.
