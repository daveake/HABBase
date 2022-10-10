unit Payload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Math,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Miscellaneous, Source, Vcl.StdCtrls, Vcl.ComCtrls,
  AdvSmoothButton, AdvPanel, AdvProgr, AdvGauge, Map, Vcl.Menus,
  VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCChart, HTMLabel, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series;

type
  TfrmPayload = class(TfrmBase)
    tblPositions: TFDMemTable;
    tblLivePayloadsCounter: TIntegerField;
    tblLivePayloadsTimestamp: TDateTimeField;
    tblLivePayloadsLatitude: TFloatField;
    tblLivePayloadsLongitude: TFloatField;
    tblLivePayloadsAltitude: TFloatField;
    tblLivePayloadsDistance: TFloatField;
    srcPositions: TDataSource;
    tblPositionsSources: TStringField;
    pnlTop: TPanel;
    pnlTitle: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBAdvGrid3: TDBAdvGrid;
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    edtCurrentRSSI: TEdit;
    Label1: TLabel;
    edtPacketRSSI: TEdit;
    TabSheet3: TTabSheet;
    lstTelemetry: TListBox;
    AdvGauge1: TAdvGauge;
    Label2: TLabel;
    edtFrequencyError: TEdit;
    tabCharts: TTabSheet;
    pnlTSS: TPanel;
    btnDown: TButton;
    btnUp: TButton;
    btnSettings: TButton;
    PopupMenu1: TPopupMenu;
    ClearHistory1: TMenuItem;
    Label3: TLabel;
    edtSNR: TEdit;
    menuPayload: TPopupMenu;
    RemovePayload: TMenuItem;
    RemoveAndBlock: TMenuItem;
    TabSheet4: TTabSheet;
    AdvPanel1: TAdvPanel;
    Label4: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    edtBurstAltitude: TEdit;
    btnSetBurst: TButton;
    lblHABHUB: THTMLabel;
    lblSondeHub: THTMLabel;
    pnlUpdated: TPanel;
    tmrUpdated: TTimer;
    lstTemp: TListBox;
    Chart1: TChart;
    Series1: TFastLineSeries;
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearHistory1Click(Sender: TObject);
    procedure pnlTitleClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure RemovePayloadClick(Sender: TObject);
    procedure RemoveAndBlockClick(Sender: TObject);
    procedure btnSetBurstClick(Sender: TObject);
    procedure tmrUpdatedTimer(Sender: TObject);
  private
    { Private declarations }
    procedure Down;
    procedure Up;
    procedure AddItem(Position: Integer; Title, Value: String);
    procedure UpdateTelemetryList;
  public
    { Public declarations }
    PayloadIndex: Integer;
    procedure SetPayloadID(PayloadID: String);
    procedure AddPosition(Position: THABPosition; Sources: String);
    procedure UpdateSources(Position: THABPosition; Sources: String);
    procedure ShowSNR(SNR: Integer);
    procedure ShowPacketRSSI(PacketRSSI: Integer);
    procedure ShowCurrentRSSI(CurrentRSSI: Integer);
    procedure ShowFrequencyError(FrequencyError: Double);
    procedure ShowDetails(Show: Boolean);
    procedure UpdatePrediction(Position: THABPosition);
  end;


implementation

{$R *.dfm}

uses Payloads;

const
    POSN_PAYLOADID              = 0;
    POSN_COUNTER                = 1;
    POSN_TIMESTAMP              = 2;
    POSN_LATITUDE               = 3;
    POSN_LONGITUDE              = 4;
    POSN_ALTITUDE               = 5;
    POSN_SATELLITES             = 6;
    POSN_INTERNAL_TEMPERATURE   = 7;
    POSN_EXTERNAL_TEMPERATURE   = 8;
    POSN_PRESSURE               = 9;
    POSN_HUMIDITY               = 10;
    POSN_BATTERY_VOLTAGE        = 11;
    POSN_BATTERY_CURRENT        = 12;
    POSN_SPEED                  = 13;
    POSN_HEADING                = 14;

    POSN_CUTDOWN                = 15;

    POSN_PRED_LAT               = 16;
    POSN_PRED_LON               = 17;
    POSN_PRED_CDA               = 18;
    POSN_PRED_LANDING           = 19;
    POSN_PRED_TTL               = 20;

    POSN_UPLINK_SNR             = 21;
    POSN_UPLINK_RSSI            = 22;
    POSN_UPLINK_COUNT           = 23;
    POSN_LAST_COMMAND           = 24;

    POSN_ASCENTRATE             = 25;

    POSN_DISTANCE               = 26;
    POSN_DIRECTION              = 27;
    POSN_ELEVATION              = 28;

    POSN_FREQUENCY              = 29;
    POSN_DEVICE                 = 30;
    POSN_LISTENERS              = 31;

procedure TfrmPayload.AddItem(Position: Integer; Title, Value: String);
begin
    while lstTemp.Items.Count < (Position+1) do begin
        lstTemp.Items.Add('');
    end;

    lstTemp.Items[Position] := Title.PadLeft(18) + ': ' + Value;
end;

procedure TfrmPayload.AddPosition(Position: THABPosition; Sources: String);
const
    CutdownStatii: Array[0..4] of String = ('Idle', 'Armed', 'Triggered (Alt)', 'Triggered (Man)', 'Triggered');
var
    MyBookmark: TBookmark;
    Prefix: String;
begin
    with Position do begin
        // Table
        with tblPositions do begin
            DisableControls;
            MyBookmark := GetBookmark;
            if RecordCount > 10 then begin
                Last;
                Delete;
            end;
            First;
            Insert;
            FieldByName('Counter').AsInteger := Counter;
            FieldByName('TimeStamp').AsDateTime := TimeStamp;
            FieldByName('Latitude').AsFloat := Latitude;
            FieldByName('Longitude').AsFloat := Longitude;
            FieldByName('Altitude').AsFloat := Altitude;
            FieldByName('Distance').AsFloat := Distance;
            FieldByName('Sources').AsString := Sources;
            Post;
            try
                GotoBookmark(MyBookmark);
                Prior;
            except
                Last;
            end;
            EnableControls;
        end;

        // Position tab
        // AddItem(POSN_PAYLOADID, 'PayloadID', PayloadID);

        if Counter > 0 then begin
            AddItem(POSN_COUNTER, 'Counter', IntToStr(Counter));
        end;

        AddItem(POSN_TIMESTAMP, 'Timestamp', FormatDateTime('hh:nn:ss', TimeStamp));
        AddItem(POSN_LATITUDE, 'Latitude', MyFormatFloat('0.0000', Latitude));
        AddItem(POSN_LONGITUDE, 'Longitude', MyFormatFloat('0.0000', Longitude));
        AddItem(POSN_ALTITUDE, 'Altitude', FormatFloat('0', Altitude) + ' m');

        if HaveAscentRate then begin
            AddItem(POSN_ASCENTRATE, 'Ascent Rate', MyFormatFloat('0.0', AscentRate) + ' m/s');
        end;

        if (Satellites > 0) or HasSatelliteCount then begin
            AddItem(POSN_SATELLITES, 'Satellites', IntToStr(Satellites));
        end;

        if HaveInternalTemperature then begin
            AddItem(POSN_INTERNAL_TEMPERATURE, 'Int. Temp.', MyFormatFloat('0.0', InternalTemperature) + ' °C');
        end;

        if HaveExternalTemperature then begin
            AddItem(POSN_EXTERNAL_TEMPERATURE, 'Ext. Temp.', MyFormatFloat('0.0', ExternalTemperature) + ' °C');
        end;

        if HavePressure then begin
            AddItem(POSN_HUMIDITY, 'Pressure', MyFormatFloat('0', Pressure) + '%');
        end;

        if HaveHumidity then begin
            AddItem(POSN_HUMIDITY, 'Humidity', MyFormatFloat('0', Humidity) + '%');
        end;

        if HasBatteryVoltage then begin
            AddItem(POSN_BATTERY_VOLTAGE, 'Batt Voltage', MyFormatFloat('0.0#', BatteryVoltage) + ' V');
        end;

        if HasBatteryCurrent then begin
            AddItem(POSN_BATTERY_CURRENT, 'Batt Current', MyFormatFloat('0', BatteryCurrent) + ' mA');
        end;

        if HaveSpeed then begin
            AddItem(POSN_SPEED, 'Speed', MyFormatFloat('0.0', Speed) + 'kph');
        end;

        if HaveHeading then begin
            AddItem(POSN_HEADING, 'Heading', MyFormatFloat('0.0', Heading) + ' °');
        end;

        if HaveCutdownStatus then begin
            if (CutdownStatus >= Low(CutdownStatii)) and (CutdownStatus <= High(CutdownStatii)) then begin
                AddItem(POSN_CUTDOWN, 'Cutdown', CutdownStatii[CutdownStatus]);
            end else begin
                AddItem(POSN_CUTDOWN, 'Cutdown', IntToStr(CutdownStatus));
            end;
        end;

        AddItem(POSN_DISTANCE, 'Distance', MyFormatFloat('0.0', Distance) + ' km');
        AddItem(POSN_DIRECTION, 'Direction', MyFormatFloat('0.0', Direction * 180 / Pi) + ' °');
        AddItem(POSN_ELEVATION, 'Elevation', MyFormatFloat('0.0', Elevation) + ' °');

        if PredictionType <> TPredictionType.ptNone then begin
            if PredictionType = TPredictionType.ptTawhiri then Prefix := 'Tawhiri' else Prefix := 'On-board';

            AddItem(POSN_PRED_LAT, Prefix + ' Pred. Lat', MyFormatFloat('0.0000', PredictedLatitude));
            AddItem(POSN_PRED_LON, 'Pred. Lon', MyFormatFloat('0.0000', PredictedLongitude));

            if CDA > 0 then begin
                AddItem(POSN_PRED_CDA, 'CDA', MyFormatFloat('0.00', CDA));
            end;

            if HaveLandingSpeed then begin
                AddItem(POSN_PRED_LANDING, 'Landing Speed', MyFormatFloat('0.0', LandingSpeed) + ' m/s');
            end;

            if HaveTTL then begin
                AddItem(POSN_PRED_TTL, 'Time Till Landing', IntToStr(TTL) + ' s');
            end;

            if LastCommand <> '' then begin
                AddItem(POSN_LAST_COMMAND, 'Last Command', LastCommand);
            end;
        end;

        if HaveUplinkSNR then begin
            AddItem(POSN_UPLINK_SNR, 'Uplink SNR', IntToStr(UplinkSNR) + 'dB');
        end;

        if HaveUplinkRSSI then begin
            AddItem(POSN_UPLINK_RSSI, 'Uplink RSSI', IntToStr(UplinkSNR) + 'dBm');
        end;

        if HaveUplinkSNR then begin
            AddItem(POSN_UPLINK_COUNT, 'Uplink Count', IntToStr(UplinkSNR));
        end;

        if Device <> '' then begin
            AddItem(POSN_DEVICE, 'Device', Device);
        end;

        if CurrentFrequency > 0 then begin
            AddItem(POSN_FREQUENCY, 'Frequency', MyFormatFloat('0.000', CurrentFrequency + FrequencyError / 1000.0) + ' MHz');
        end;


        if Sources <> '' then begin
            AddItem(POSN_LISTENERS, 'Sources', Sources);
        end;

        // Charts
        // AltitudeChart.Series[0].AddXYPoint(Now, Altitude);
        Chart1.Series[0].AddXY(Now, Altitude);
    end;

    UpdateTelemetryList;

    pnlUpdated.Color := clLime;
    tmrUpdated.Enabled := True;
end;

procedure TfrmPayload.UpdateTelemetryList;
var
    i, j: Integer;
begin
    j := 0;
    for i := 0 to lstTemp.Items.Count-1 do begin
        if lstTemp.Items[i] <> '' then begin
            if j >= lstTelemetry.Items.Count then begin
                lstTelemetry.Items.Add(lstTemp.Items[i]);
            end else begin
                if lstTelemetry.Items[j] <> lstTemp.Items[i] then begin
                    lstTelemetry.Items[j] := lstTemp.Items[i];
                end;
            end;

            Inc(j);
        end;

    end;
end;

procedure TfrmPayload.btnDownClick(Sender: TObject);
begin
    Down;
    frmPayloads.HighlightPayload(pnlTitle.Caption, False, True);
end;

procedure TfrmPayload.btnSetBurstClick(Sender: TObject);
var
    Altitude: Integer;
begin
    Altitude := StrToIntDef(edtBurstAltitude.Text, 0);

    frmPayloads.UpdateBurstAltitude(PayloadIndex, Altitude);
end;

procedure TfrmPayload.btnSettingsClick(Sender: TObject);
var
    pnt: TPoint;
begin
    if GetCursorPos(pnt) then begin
        menuPayload.Popup(pnt.X, pnt.Y);
    end;
end;

procedure TfrmPayload.btnUpClick(Sender: TObject);
begin
    Up;
    frmMap.CentrePayloadOnMap(-1);
end;

procedure TfrmPayload.ClearHistory1Click(Sender: TObject);
begin
    with tblPositions do begin
        while RecordCount > 0 do begin
            Delete;
        end;
    end;
end;

procedure TfrmPayload.FormCreate(Sender: TObject);
begin
    PageControl1.ActivePageIndex := 0;
    TabSheet2.TabVisible := False;
    Up;
end;

procedure TfrmPayload.pnlTitleClick(Sender: TObject);
begin
    frmPayloads.HighlightPayload(pnlTitle.Caption, False, True);
end;

procedure TfrmPayload.RemoveAndBlockClick(Sender: TObject);
begin
    frmPayloads.RemovePayload(PayloadIndex, True);
end;

procedure TfrmPayload.RemovePayloadClick(Sender: TObject);
begin
    frmPayloads.RemovePayload(PayloadIndex);
end;

procedure TfrmPayload.UpdateSources(Position: THABPosition; Sources: String);
var
    MyBookmark: TBookmark;
begin
    with tblPositions, Position do begin
        DisableControls;
        MyBookmark := GetBookmark;
        First;
        Edit;
        FieldByName('Sources').AsString := Sources;
        Post;
        GotoBookmark(MyBookmark);
        EnableControls;
    end;

    AddItem(POSN_LISTENERS, 'Sources', Sources);
end;

procedure TfrmPayload.Down;
begin
    pnlMain.Height := Round(350 * ScaleFactor);
    btnDown.Visible := False;
    btnUp.Visible := True;
end;

procedure TfrmPayload.Up;
begin
    pnlMain.Height := pnlTop.Top + pnlTop.Height + pnlTop.Margins.Top + 1;
    btnUp.Visible := False;
    btnDown.Visible := True;
end;

procedure TfrmPayload.ShowSNR(SNR: Integer);
begin
    TabSheet2.TabVisible := True;
    edtSNR.Text := SNR.ToString;
end;

procedure TfrmPayload.tmrUpdatedTimer(Sender: TObject);
begin
    tmrUpdated.Enabled := False;
    pnlUpdated.Color := clSilver;
end;

procedure TfrmPayload.ShowPacketRSSI(PacketRSSI: Integer);
begin
    TabSheet2.TabVisible := True;
    edtPacketRSSI.Text := PacketRSSI.ToString;
end;

procedure TfrmPayload.ShowCurrentRSSI(CurrentRSSI: Integer);
begin
    TabSheet2.TabVisible := True;
    edtCurrentRSSI.Text := CurrentRSSI.ToString;
    AdvGauge1.Position := min(AdvGauge1.Maximum, CurrentRSSI);
end;

procedure TfrmPayload.ShowFrequencyError(FrequencyError: Double);
begin
    TabSheet2.TabVisible := True;
    edtFrequencyError.Text := FormatFloat('0.0', FrequencyError) + ' kHz';
end;


procedure TfrmPayload.ShowDetails(Show: Boolean);
begin
    if Show then begin
        Down;
    end else begin
        Up;
    end;
end;

procedure TfrmPayload.UpdatePrediction(Position: THABPosition);
var
    MyBookmark: TBookmark;
begin
    with Position do begin
        if PredictionType <> TPredictionType.ptNone then begin
            AddItem(POSN_PRED_LAT, 'Pred. Lat', MyFormatFloat('0.0000', PredictedLatitude));
            AddItem(POSN_PRED_LON, 'Pred. Lon', MyFormatFloat('0.0000', PredictedLongitude));
        end;
    end;
end;

procedure TfrmPayload.SetPayloadID(PayloadID: String);
begin
    pnlTitle.Caption := PayloadID;

    lblHABHUB.HtmlText.Text := '<a href="https://tracker.habhub.org/#!qm=All&q=' + PayloadID + '">Open in HABHUB Map</a>';

    lblSondeHub.HtmlText.Text := '<a href="https://amateur.sondehub.org/#!mt=Mapnik&mz=11&qm=12h&f=' + PayloadID + '&q=' + PayloadID + '">Open in Sondehub Map</a>';
end;

end.
