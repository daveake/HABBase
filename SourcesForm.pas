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
  Source, SourceForm, Vcl.Menus, Habitat, SocketSource,
  GatewaySource, SerialSource, TCPSettings; // HabitatSource, UDPSource, SerialSource, BluetoothSource,


type
    THABSource = record
        InUse:              Boolean;
        SourceID:           Integer;
        Group:              String;
        SourceEnabled:      Boolean;
        Started:            Boolean;
        Connected:          Boolean;
        Code:               String;
        Description:        String;
        SourceType:         TSourceType;
        SourceForm:         TfrmSource;
//        Indicator:          TAdvSmoothStatusIndicator;
        Source:             TSource;
        Upload:             Boolean;
        Status:             String;
        LastPacketAt:       TDateTime;
//        ValueLabel:   TLabel;
//        RSSILabel:    TLabel;
        CurrentRSSI:  String;
//        PacketRSSI:   String;
//        FreqError:    String;
        LatestPosition:     THABPosition;
    end;

type
  TfrmSources = class(TfrmNormal)
    scrollMain: TScrollBox;
  private
    { Private declarations }
    HABSources: Array[1..32] of THABSource;
    HabitatUploader: THabitatThread;
    procedure ShowSourceStatus(SourceIndex: Integer);
    procedure LoadSource(SourceIndex: Integer);
    procedure ReloadSourceSettings(SourceIndex: Integer);
    procedure LoadSourceSettings(SourceIndex: Integer);
    procedure DataSourceClick(Sender: TObject);
    function ShowSettingsForm(SourceIndex: Integer): Boolean;
    function FindFreeSource: Integer;
    procedure HabitatStatusCallback(SourceID: Integer; Active, OK: Boolean);
    procedure NewPosition(SourceIndex: Integer; Position: THABPosition);
  public
    { Public declarations }
    procedure LoadSources;
    procedure HABCallback(SourceIndex: Integer; Connected: Boolean; Line: String; Position: THABPosition);
    procedure AddNewSource;
    procedure ModifySource(SourceIndex: Integer);
    procedure DeleteSource(SourceIndex: Integer);
    function SourceIsEnabled(SourceIndex: Integer): Boolean;
    procedure EnableSource(SourceIndex: Integer; EnableSource: Boolean);
  end;

var
    frmSources: TfrmSources;

implementation

{$R *.dfm}

uses Data, Logtail, Main, ToolLog, Map, Miscellaneous, SettingsForm, NewSource, Payloads, Misc,
     LogtailSettings, GatewaySettings, LoRaSerialSettings,
     LoRaSerialSource;

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

//        Indicator := TAdvSmoothStatusIndicator.Create(Self);
//        with Indicator do begin
//            Parent := pnlStatus;
//            Align := alRight;
//            AlignWithMargins := True;
//            BorderWidth := 1;
//            Appearance.Fill.Color := clGray;
//            Appearance.Fill.ColorMirror := clNone;
//            Appearance.Fill.ColorMirrorTo := clNone;
//            Appearance.Fill.GradientType := TAdvGradientType.gtSolid;
//            Appearance.Fill.BorderColor := 3355443;
//            Appearance.Fill.Rounding := 18;
//            Appearance.Fill.ShadowOffset := 0;
//            Appearance.Font.Height := -24;
//            Appearance.Font.Color := clWhite;
//            AutoSize := True;
//            Tag := SourceIndex;
//            PopupMenu := menuSource;
//            OnClick := DataSourceClick;
//        end;

        SourceType := TSourceType(FieldByName('Type').AsInteger);

        if SourceType = stLogtail then begin
            SourceForm := TfrmLogtail.Create(nil);
            // SourceForm.pnlMain.Parent := frmMain.pnlHidden;
        end else if SourceType = stGateway then begin
            SourceForm := TfrmSource.Create(nil);
            Source := TGatewaySource.Create(SourceIndex, Group, HABCallback);
        end else if SourceType = stSerial then begin
            SourceForm := TfrmLoRaSerialSource.Create(nil);
            Source := TSerialSource.Create(SourceIndex, Group, HABCallback);
        end else if SourceType = stTCP then begin
            SourceForm := TfrmSource.Create(nil);
            Source := TSocketSource.Create(SourceIndex, Group, HABCallback);
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
        SourceEnabled := FieldByName('Enabled').AsBoolean;

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

//        Indicator.Caption := Code;

        if SourceForm <> nil then begin
            SourceForm.pnlTitle.Caption := Code + ': ' + Description;
            SourceForm.pnlMain.Parent := scrollMain;
        end;

        ShowSourceStatus(SourceIndex);
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
    Callsign: String;
    PositionIsNew: Boolean;
begin
    // HABSources[SourceIndex].LatestPosition := Position;

    // Got a packet
    HABSources[SourceIndex].LastPacketAt := Now;

    // Add date if necessary
    if Trunc(Position.TimeStamp) < (Trunc(Now)-1) then begin
        if (Frac(Now) < 60/86400) and (Frac(Position.TimeStamp) > (1-120/86400)) then begin
            // It's now the start of the day, and payload seems to be from yesterday, so use yesterday's date
            Position.TimeStamp := Position.TimeStamp + Trunc(Now) - 1;
        end else begin
            Position.TimeStamp := Position.TimeStamp + Trunc(Now);
        end;
    end;

    // Calculate distance
    if (not DataModule1.tblSettings.FieldByName('Latitude').IsNull) and (not DataModule1.tblSettings.FieldByName('Longitude').IsNull) then begin
        Position.Distance := CalculateDistance(Position.Latitude, Position.Longitude,
                                               DataModule1.tblSettings.FieldByName('Latitude').Asfloat,
                                               DataModule1.tblSettings.FieldByName('Longitude').AsFloat) / 1000.0;
    end;

    // Add to our payload list
    PositionIsNew := frmPayloads.NewPosition(Position, HABSources[SourceIndex].Code, HABSources[SourceIndex].Description);

    // Upload to habitat
    if HABSources[SourceIndex].Upload then begin
        Callsign := DataModule1.tblSettings.FieldByName('Callsign').AsString;
        if Callsign <> '' then begin
            HabitatUploader.SaveTelemetryToHabitat(SourceIndex, Position.Line, Callsign);
        end;
    end;

    ShowSourceStatus(SourceIndex);

    // Add to source history
    if PositionIsNew or not Position.ReceivedRemotely then begin
        HABSources[SourceIndex].SourceForm.AddPosition(Position);
    end;
end;

procedure TfrmSources.ShowSourceStatus(SourceIndex: Integer);
begin
    with HABSources[SourceIndex] do begin
        // Colours
        if SourceEnabled then begin
            if Connected then begin
                if (Now - LastPacketAt) < 60/86400 then begin
                    SourceForm.pnlTitle.Color := clGreen;
                end else begin
                    SourceForm.pnlTitle.Color := clOlive;
                end;
            end else if Started then begin
                SourceForm.pnlTitle.Color := clRed;
            end else begin
                SourceForm.pnlTitle.Color := clGray;
            end;
        end else begin
            SourceForm.pnlTitle.Color := clSilver;
        end;
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

procedure TfrmSources.AddNewSource;
var
    SourceIndex: Integer;
begin
    SourceIndex := FindFreeSource;

    if SourceIndex > 0 then begin
        // We can add a new source
        frmNewSource := TfrmNewSource.Create(nil);

        if frmNewSource.ShowModal = mrOK then begin
            // Type of source
            HABSources[SourceIndex].SourceType := TSourceType(frmNewSource.ComboBox1.ItemIndex);

            // Add to table
            with DataModule1.tblSources do begin
                Append;
                FieldByName('Enabled').AsBoolean := True;
                FieldByName('Type').AsInteger := frmNewSource.ComboBox1.ItemIndex;
                Post;
                // Last;

                HABSources[SourceIndex].SourceID := FieldByName('ID').AsInteger;

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


procedure TfrmSources.HABCallback(SourceIndex: Integer; Connected: Boolean; Line: String; Position: THABPosition);
var
    Status: String;
    MyBookmark: TBookmark;
begin
    HABSources[SourceIndex].Started := True;
    // Mark connected
    if Connected <> HABSources[SourceIndex].Connected then begin
        HABSources[SourceIndex].Connected := Connected;
        ShowSourceStatus(SourceIndex);
    end;

    // New Position
    if Position.InUse then begin
        if Position.PayloadID <> '' then begin
            NewPosition(SourceIndex, Position);
        end;
        Status := Position.Line;
        HABSources[SourceIndex].LatestPosition := Position;
    end else if Line <> '' then begin
        Status := Line;
    end;

    // Update status
    if (Status <> '') and (Status <> HABSources[SourceIndex].Status) then begin
        HABSources[SourceIndex].Status := Status;
        with DataModule1.tblSources do begin
            MyBookmark := GetBookmark;
            if FindKey([HABSources[SourceIndex].SourceID]) then begin
                if Status <> FieldByName('Status').AsString then begin
                    Edit;
                    FieldByName('Status').AsString := Status;
                    Post;
                end;
                GotoBookmark(MyBookmark);
            end;
        end;

        if not Position.InUse then begin
            frmToolLog.AddToLog('Source ' + HABSources[SourceIndex].Code + ': ' + Status);
        end;
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

    if Position.HasCurrentRSSI then begin
        HABSources[SourceIndex].SourceForm.ShowCurrentRSSI(0, Position.CurrentRSSI);

        if HABSources[SourceIndex].LatestPosition.InUse then begin
            // We have a position so we know what payload we last received
            frmPayloads.ShowCurrentRSSI(HABSources[SourceIndex].LatestPosition.PayloadID, Position.CurrentRSSI);
        end;
    end;

    if Position.HasPacketRSSI then begin
        HABSources[SourceIndex].SourceForm.ShowPacketRSSI(0, Position.PacketRSSI);

        if HABSources[SourceIndex].LatestPosition.InUse then begin
            // We have a position so we know what payload we last received
            frmPayloads.ShowPacketRSSI(HABSources[SourceIndex].LatestPosition.PayloadID, Position.PacketRSSI);
        end;
    end;

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

procedure TfrmSources.DeleteSource(SourceIndex: Integer);
begin
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

            // Indicator.Free;

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
        stLogtail:  SettingsForm := TfrmLogtailSettings.Create(nil);
        stGateway:  SettingsForm := TfrmGatewaySettings.Create(nil);
        stSerial:   SettingsForm := TfrmLoRaSerialSettings.Create(nil);
        stTCP:      SettingsForm := TfrmTCPSettings.Create(nil);
        stUDP:      SettingsForm := nil;
        stHabitat:  SettingsForm := nil;
        else        SettingsForm := nil;
    end;

    if SettingsForm <> nil then begin
        Result := SettingsForm.LoadForm(HABSources[SourceIndex].SourceID);

        if HABSources[SourceIndex].SourceForm <> nil then begin
            HABSources[SourceIndex].SourceForm.Enabled := SettingsForm.chKEnabled.Checked;
        end;

        SettingsForm.Free;
    end;
end;

procedure TfrmSources.HabitatStatusCallback(SourceID: Integer; Active, OK: Boolean);
begin
    // frmMain.UploadStatus(SourceID, Active, OK);
end;

procedure TfrmSources.ModifySource(SourceIndex: Integer);
begin
    if ShowSettingsForm(SourceIndex) then begin
        ReloadSourceSettings(SourceIndex);
    end;
end;


function TfrmSources.SourceIsEnabled(SourceIndex: Integer): Boolean;
begin
    Result := HABSources[SourceIndex].SourceEnabled;
end;

procedure TfrmSources.EnableSource(SourceIndex: Integer; EnableSource: Boolean);
begin
    HABSources[SourceIndex].SourceEnabled := EnableSource;
    SetSettingBoolean(HABSources[SourceIndex].Group, 'Enabled', EnableSource);
    if HABSources[SourceIndex].SourceForm <> nil then begin
        HABSources[SourceIndex].SourceForm.Enabled := EnableSource;
    end;
    SetGroupChangedFlag(HABSources[SourceIndex].Group, True);
    ShowSourceStatus(SourceIndex);
end;


end.
