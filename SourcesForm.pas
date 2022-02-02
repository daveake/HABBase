unit SourcesForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls, Vcl.ExtCtrls, BaseTypes, SSDV,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, AdvSmoothStatusIndicator, AdvGDIP,
  Data.FMTBcd, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, Math,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, AdvSmoothButton, AdvPanel, Miscellaneous, Vcl.Menus,
  Source, SourceForm, Habitat, HABLink, SocketSource, UDPSource, APRSSource,
  GatewaySource, SerialSource, TCPSettings, UDPSettings, APRSSettings;


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
        Source:             TSource;
        Upload:             Boolean;
        Status:             String;
        LastPacketAt:       TDateTime;
        FreqError:          Array[0..1] of Double;
        MultipleChannels:   Boolean;
        LatestPosition:     THABPosition;
        HaveReceivedSSDV:   Boolean;
        SSDVCount:          Integer;
    end;

type
  TfrmSources = class(TfrmNormal)
    scrollMain: TScrollBox;
    btnAddSource: TAdvSmoothButton;
    tmrSSDV: TTimer;
    procedure btnAddSourceClick(Sender: TObject);
    procedure tmrSSDVTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    HABSources: Array[1..32] of THABSource;
    HabitatUploader: THabitatThread;
    HabLinkUploader: THABLinkThread;
    SSDVUploader: TSSDVThread;
    procedure ShowSourceStatus(SourceIndex: Integer);
    procedure LoadSource(SourceIndex: Integer);
    procedure ReloadSourceSettings(SourceIndex: Integer);
    procedure LoadSourceSettings(SourceIndex: Integer);
    procedure DataSourceClick(Sender: TObject);
    function ShowSettingsForm(SourceIndex: Integer): Boolean;
    function FindFreeSource: Integer;
    procedure HabitatStatusCallback(SourceID: Integer; Active, OK: Boolean);
    procedure HabLinkStatusCallback(SourceID: Integer; Active, OK: Boolean);
    function NewPosition(SourceIndex: Integer; Position: THABPosition): Boolean;
    procedure AddStatusToLog(SourceIndex: Integer);
    function APRSFilter: String;
    procedure CloseThread(Thread: TThread);
    procedure WaitForThread(Thread: TThread);
  public
    { Public declarations }
    procedure LoadSources;
    procedure HABCallback(SourceIndex: Integer; Connected: Boolean; Line: String; Position: THABPosition);
    function StorePosition(SourceIndex: Integer; Connected: Boolean; Line: String; Position: THABPosition): Boolean;
    procedure AddNewSource;
    procedure ModifySource(SourceIndex: Integer);
    procedure DeleteSource(SourceIndex: Integer);
    function SourceIsEnabled(SourceIndex: Integer): Boolean;
    procedure EnableSource(SourceIndex: Integer; EnableSource: Boolean);
    procedure SendUplink(SourceIndex: Integer; When: TUplinkWhen; WhenValue, Channel: Integer; Prefix, Msg, Password: String);
    procedure UpdateSourceFilters;
  end;

var
    frmSources: TfrmSources;

implementation

{$R *.dfm}

uses Data, Logtail, Main, Map, SettingsForm, NewSource, Payloads, Misc,
     LogtailSettings, GatewaySettings, LoRaSerialSettings,
     LoRaSerialSource, LoRaGatewaySource;

procedure TfrmSources.LoadSources;
var
    SourceIndex: Integer;
    Dummy: String;
begin
    InitialiseSettings;

    // Habitat uploader
    HabitatUploader := THabitatThread.Create(HabitatStatusCallback);

    // SSDV Uploader
    SSDVUploader := TSSDVThread.Create(nil);

    // HabLink uploader
    if GetCommandLineParameter('HABLink', Dummy) then begin
        HabLinkUploader := THABLinkThread.Create(HabLinkStatusCallback);
        HabLinkUploader.SetListener('HAB Base', 'V1.3', DataModule1.tblSettings.FieldByName('Callsign').AsString);
    end;

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
    btnAddSource.Visible := False;

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
            SourceForm := TfrmLoRaGatewaySource.Create(nil);
            Source := TGatewaySource.Create(SourceIndex, Group, HABCallback);
            MultipleChannels := True;
        end else if SourceType = stSerial then begin
            SourceForm := TfrmLoRaSerialSource.Create(nil);
            Source := TSerialSource.Create(SourceIndex, Group, HABCallback);
        end else if SourceType = stTCP then begin
            SourceForm := TfrmSource.Create(nil);
            Source := TSocketSource.Create(SourceIndex, Group, HABCallback);
        end else if SourceType = stUDP then begin
            SourceForm := TfrmSource.Create(nil);
            Source := TUDPSource.Create(SourceIndex, Group, HABCallback);
        end else if SourceType = stAPRS then begin
            SourceForm := TfrmSource.Create(nil);
            Source := TAPRSSource.Create(SourceIndex, Group, HABCallback);
            Source.SetFilter(APRSFilter);
//        end else if SourceTypeText = 'DLFLDigi' then begin
//            SourceType := stDLFLDigi;
//            Form := TfrmDLFLDigiSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'Serial' then begin
//            SourceType := stSerial;
//            Form := TfrmLoRaSerialSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'Habitat' then begin
//            SourceType := stHabitat;
//            Form := TfrmHabitatSource.Create(nil, HABDB, HabitatThread, SourceIndex);
        end else begin
            SourceForm := nil;
        end;

        if SourceForm <> nil then begin
            SourceForm.SourceIndex := SourceIndex;
            SourceForm.Group := Group;
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
            if SourceForm <> nil then begin
                SourceForm.ShowSetting(Setting, Value);
            end;
        end;

        if SourceForm <> nil then begin
            SourceForm.Enabled := FieldByName('Enabled').AsBoolean;
        end;

//        Indicator.Caption := Code;

        if SourceForm <> nil then begin
            SourceForm.lblTitle.Caption := Code + ': ' + Description;
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


function TfrmSources.NewPosition(SourceIndex: Integer; Position: THABPosition): Boolean;
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

    if (not DataModule1.tblSettings.FieldByName('Latitude').IsNull) and (not DataModule1.tblSettings.FieldByName('Longitude').IsNull) then begin
        // Calculate distance
        Position.Distance := CalculateDistance(Position.Latitude, Position.Longitude,
                                               DataModule1.tblSettings.FieldByName('Latitude').Asfloat,
                                               DataModule1.tblSettings.FieldByName('Longitude').AsFloat) / 1000.0;

        // Calculate direction
        Position.Direction := CalculateDirection(Position.Latitude, Position.Longitude,
                                                 DataModule1.tblSettings.FieldByName('Latitude').Asfloat,
                                                 DataModule1.tblSettings.FieldByName('Longitude').AsFloat);

        // Calculate elevation
        Position.Elevation := CalculateElevation(DataModule1.tblSettings.FieldByName('Latitude').Asfloat,
                                                 DataModule1.tblSettings.FieldByName('Longitude').AsFloat,
                                                 DataModule1.tblSettings.FieldByName('Altitude').AsFloat,
                                                 Position.Latitude, Position.Longitude, Position.Altitude);
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

    if HabLinkUploader <> nil then begin
        if HABSources[SourceIndex].Upload then begin
            HabLinkUploader.SendTelemetry(Position.Line);
        end;
    end;


    ShowSourceStatus(SourceIndex);

    // Add to source history
    if PositionIsNew or not Position.ReceivedRemotely then begin
        HABSources[SourceIndex].SourceForm.AddPosition(Position);
    end;

    Result := PositionIsNew;
end;

procedure TfrmSources.ShowSourceStatus(SourceIndex: Integer);
begin
    with HABSources[SourceIndex] do begin
        // Colours
        if SourceEnabled then begin
            if Connected then begin
                if (Now - LastPacketAt) < 60/86400 then begin
                    SourceForm.pnlTitle.Color := clLime;
                    SourceForm.pnlTitle.Font.Color := clBlack;
                end else begin
                    SourceForm.pnlTitle.Color := clGreen;
                    SourceForm.pnlTitle.Font.Color := clWhite;
                end;
            end else if Started then begin
                SourceForm.pnlTitle.Color := clRed;
                SourceForm.pnlTitle.Font.Color := clWhite;
            end else begin
                SourceForm.pnlTitle.Color := clSilver;
                SourceForm.pnlTitle.Font.Color := clBlack;
            end;
        end else begin
            SourceForm.pnlTitle.Color := clGray;
            SourceForm.pnlTitle.Font.Color := clWhite;
        end;
    end;
end;

procedure TfrmSources.AddStatusToLog(SourceIndex: Integer);
begin
    if HABSources[SourceIndex].SourceForm <> nil then begin
        HABSources[SourceIndex].SourceForm.AddStatusToLog(HABSources[SourceIndex].Status);
    end;
end;


procedure TfrmSources.btnAddSourceClick(Sender: TObject);
begin
    AddNewSource;
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

procedure TfrmSources.CloseThread(Thread: TThread);
begin
    if Thread <> nil then begin
        Thread.Terminate;
    end;
end;


procedure TfrmSources.WaitForThread(Thread: TThread);
begin
    if Thread <> nil then begin
        Thread.WaitFor;
    end;
end;

procedure TfrmSources.FormDestroy(Sender: TObject);
var
    Index: Integer;
begin
    // Close and wait for threads

    for Index := Low(HABSources) to High(HABSources) do begin
        CloseThread(HABSources[Index].Source);
    end;

    CloseThread(HabitatUploader);
    CloseThread(SSDVUploader);
    CloseThread(HabLinkUploader);


    WaitForThread(HabitatUploader);
    WaitForThread(SSDVUploader);
    WaitForThread(HabLinkUploader);

    for Index := Low(HABSources) to High(HABSources) do begin
        WaitForThread(HABSources[Index].Source);
    end;
end;

procedure TfrmSources.AddNewSource;
var
    SourceIndex: Integer;
    frmNewSource: TfrmNewSource;
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
begin
    StorePosition(SourceIndex, Connected, Line, Position);
end;

function TfrmSources.StorePosition(SourceIndex: Integer; Connected: Boolean; Line: String; Position: THABPosition): Boolean;
var
    Status, Callsign: String;
    MyBookmark: TBookmark;
begin
    Result := False;

    // Mark connected
    if Connected <> HABSources[SourceIndex].Connected then begin
        HABSources[SourceIndex].Connected := Connected;
        ShowSourceStatus(SourceIndex);
    end else if not HABSources[SourceIndex].Started then begin
        HABSources[SourceIndex].Started := True;
        ShowSourceStatus(SourceIndex);
    end;

    // New Position
    if Position.InUse then begin
        if Position.PayloadID <> '' then begin
            Result := NewPosition(SourceIndex, Position);
        end;
        if HABSources[SourceIndex].MultipleChannels then begin
            Status := IntToStr(Position.Channel) + ': ' + Position.Line;
        end else begin
            Status := Position.Line;
        end;
        HABSources[SourceIndex].LatestPosition := Position;
        if HABSources[SourceIndex].SourceForm <> nil then begin
            HABSources[SourceIndex].SourceForm.DoAFC(Position.Channel, HABSources[SourceIndex].FreqError[Position.Channel]);
        end;
    end else if Position.CallingModeMessage then begin
        Status := 'Calling Mode: ' + Position.PayloadID + ',' + FormatFloat('0.000', Position.CallingModeFrequency) + 'MHz';
    end else if Line <> '' then begin
        Status := Line;
    end;

    // Update status
    if (Status <> '') and (Status <> HABSources[SourceIndex].Status) then begin
        HABSources[SourceIndex].Status := Status;
        AddStatusToLog(SourceIndex);
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
    end;


    // SSDV Packet
    if Position.IsSSDV then begin
        if HABSources[SourceIndex].Upload then begin
            Callsign := DataModule1.tblSettings.FieldByName('Callsign').AsString;
            if Callsign <> '' then begin
                SSDVUploader.SaveSSDVToHabitat(Position.Line, Callsign);
            end;
        end;

        if not HABSources[SourceIndex].HaveReceivedSSDV then begin
            if HABSources[SourceIndex].SourceForm <> nil then begin
                HABSources[SourceIndex].SourceForm.AddStatusToLog('Receiving SSDV');
            end;
            HABSources[SourceIndex].HaveReceivedSSDV := True;
        end;

        Inc(HABSources[SourceIndex].SSDVCount);
    end;

    if Position.HasCurrentRSSI then begin
        HABSources[SourceIndex].SourceForm.ShowCurrentRSSI(Position.Channel, Position.CurrentRSSI);

        if HABSources[SourceIndex].LatestPosition.InUse then begin
            // We have a position so we know what payload we last received
            frmPayloads.ShowCurrentRSSI(HABSources[SourceIndex].LatestPosition.PayloadID, Position.CurrentRSSI);
        end;
    end;

    if Position.HasSNR then begin
        if HABSources[SourceIndex].LatestPosition.InUse then begin
            // We have a position so we know what payload we last received
            frmPayloads.ShowSNR(HABSources[SourceIndex].LatestPosition.PayloadID, Position.SNR);
        end;
    end;

    if Position.HasPacketRSSI then begin
        HABSources[SourceIndex].SourceForm.ShowPacketRSSI(Position.Channel, Position.PacketRSSI);

        if HABSources[SourceIndex].LatestPosition.InUse then begin
            // We have a position so we know what payload we last received
            frmPayloads.ShowPacketRSSI(HABSources[SourceIndex].LatestPosition.PayloadID, Position.PacketRSSI);
        end;
    end;

    if Position.HasFrequency then begin
        HABSources[SourceIndex].FreqError[Position.Channel] := Position.FrequencyError / 1000.0;

        HABSources[SourceIndex].SourceForm.ShowFrequencyError(Position.Channel, Position.FrequencyError);

        if HABSources[SourceIndex].LatestPosition.InUse then begin
            // We have a position so we know what payload we last received
            frmPayloads.ShowFrequencyError(HABSources[SourceIndex].LatestPosition.PayloadID, Position.FrequencyError);
        end;
    end;

    if Position.Device <> '' then begin
        HABSources[SourceIndex].SourceForm.AddStatusToLog('Device = ' + Position.Device);
    end;

    if Position.Version <> '' then begin
        HABSources[SourceIndex].SourceForm.AddStatusToLog('Version = ' + Position.Version);
        HABSources[SourceIndex].SourceForm.SetDeviceVersion(MyStrToFloat(Position.Version));
    end;

    if Position.CallingModeMessage then begin
        HABSources[SourceIndex].SourceForm.SetFromCallingMode(Position.CallingModeFrequency, Position.CallingModeImplicit, Position.CallingModeError, Position.CallingModeBandwidth, Position.CallingModeSpreading, Position.CallingModeOptimize);
    end;
end;

procedure TfrmSources.tmrSSDVTimer(Sender: TObject);
var
    i: Integer;
begin
    for i := Low(HABSources) to High(HABSources) do begin
        if HABSources[i].InUse and
           HABSources[i].HaveReceivedSSDV and
           (HABSources[i].SSDVCount > 0) then begin
            if HABSources[i].SourceForm <> nil then begin
                HABSources[i].SourceForm.AddStatusToLog('Receiving ' + HABSources[i].SSDVCount.ToString + ' SSDV packets/min');
            end;
            HABSources[i].SSDVCount := 0;
        end;
    end;
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
        stUDP:      SettingsForm := TfrmUDPSettings.Create(nil);
        stAPRS:     SettingsForm := TfrmAPRSSettings.Create(nil);
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

procedure TfrmSources.HabLinkStatusCallback(SourceID: Integer; Active, OK: Boolean);
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
    // Tell source form
    SetSettingBoolean(HABSources[SourceIndex].Group, 'Enabled', EnableSource);
    if HABSources[SourceIndex].SourceForm <> nil then begin
        HABSources[SourceIndex].SourceForm.Enabled := EnableSource;
    end;

    // Tell source thread
    HABSources[SourceIndex].SourceEnabled := EnableSource;
    SetGroupChangedFlag(HABSources[SourceIndex].Group, True);

    // Show status
    ShowSourceStatus(SourceIndex);

    // Save in table / file
    with DataModule1.tblSources do begin
        if FindKey([HABSources[SourceIndex].SourceID]) then begin
            Edit;
            FieldByName('Enabled').AsBoolean := EnableSource;
            Post;

            SaveToFile(ExtractFilePath(Application.ExeName) + 'sources.json');
        end;
    end;
end;

procedure TfrmSources.SendUplink(SourceIndex: Integer; When: TUplinkWhen; WhenValue, Channel: Integer; Prefix, Msg, Password: String);
begin
    HABSources[SourceIndex].Source.SendUplink(When, WhenValue, Channel, Prefix, Msg, Password);
end;

procedure TfrmSources.UpdateSourceFilters;
var
    i: Integer;
begin
    for i := Low(HABSources) to High(HABSources) do begin
        if HABSources[i].InUse then begin
            if HABSources[i].SourceType = stAPRS then begin
                // Update APRS source filter

                HABSources[i].Source.SetFilter(APRSFilter);
            end;
        end;
    end;
end;


function TfrmSources.APRSFilter: String;
var
    Latitude, Longitude, Distance: Double;
begin
    // r/51.9/-2.5/50000

    Latitude := DataModule1.tblSettings.FieldByName('Latitude').AsFloat;
    Longitude := DataModule1.tblSettings.FieldByName('Longitude').AsFloat;

    Distance := 0;
    with DataModule1.tblWhiteList do begin
        First;
        while not EOF do begin
            if FieldByName('Distance').AsFloat > Distance then begin
                Distance := FieldByName('Distance').AsFloat;
            end;

            Next;
        end;
    end;

    Result := ' r/' +
              MyFormatFloat('0.00000', Latitude) + '/' +
              MyFormatFloat('0.00000', Longitude) + '/' +
              MyFormatFloat('0', Distance);
end;


end.
