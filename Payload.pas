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
  VCL.TMSFNCGraphicsTypes, VCL.TMSFNCChart, HTMLabel;

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
    AltitudeChart: TTMSFNCChart;
    lblHABHUB: THTMLabel;
    lblSondeHub: THTMLabel;
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearHistory1Click(Sender: TObject);
    procedure pnlTitleClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure RemovePayloadClick(Sender: TObject);
    procedure RemoveAndBlockClick(Sender: TObject);
    procedure btnSetBurstClick(Sender: TObject);
  private
    { Private declarations }
    ItemIndex: Integer;
    procedure Down;
    procedure Up;
    procedure AddItem(Title, Value: String);
    procedure AddOrUpdateItem(Title, Value: String);
  public
    { Public declarations }
    PayloadIndex: Integer;
    procedure SetPayloadID(PayloadID: String);
    procedure AddPosition(Position: THABPosition; Sources: String);
    procedure UpdateSources(Position: THABPosition; Sources: String);
    procedure ShowSNR(SNR: Double);
    procedure ShowPacketRSSI(PacketRSSI: Integer);
    procedure ShowCurrentRSSI(CurrentRSSI: Integer);
    procedure ShowFrequencyError(FrequencyError: Double);
    procedure ShowDetails(Show: Boolean);
    procedure UpdatePrediction(Position: THABPosition);
  end;


implementation

{$R *.dfm}

uses Payloads;

procedure TfrmPayload.AddItem(Title, Value: String);
begin
    while ItemIndex >= lstTelemetry.Items.Count do begin
        lstTelemetry.Items.Add('');
    end;

    lstTelemetry.Items[ItemIndex] := Title.PadLeft(11) + ': ' + Value;
    Inc(ItemIndex);
end;

procedure TfrmPayload.AddPosition(Position: THABPosition; Sources: String);
var
    MyBookmark: TBookmark;
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
        ItemIndex := 0;
        AddItem('PayloadID', PayloadID);

        if Counter > 0 then begin
            AddItem('Counter', IntToStr(Counter));
        end;

        AddItem('Timestamp', FormatDateTime('hh:nn:ss', TimeStamp));
        AddItem('Latitude', MyFormatFloat('0.0000', Latitude));
        AddItem('Longitude', MyFormatFloat('0.0000', Longitude));
        AddItem('Altitude', FormatFloat('0', Altitude) + ' m');

        if HaveAscentRate then begin
            AddItem('Ascent Rate', MyFormatFloat('0.0', AscentRate) + ' m/s');
        end;

        if (Satellites > 0) or (SatelliteFieldIndex > 0) then begin
            AddItem('Satellites', IntToStr(Satellites));
        end;

        if HaveExternalTemperature then begin
            AddItem('Ext. Temp.', MyFormatFloat('0.0', ExternalTemperature) + '°C');
        end;

        if HaveHumidity then begin
            AddItem('Humidity', MyFormatFloat('0.0', Humidity) + '%');
        end;

        if BatteryVoltage > 0 then begin
            AddItem('Battery', MyFormatFloat('0.0#', BatteryVoltage) + 'V');
        end;


        if HaveSpeed then begin
            AddItem('Speed', MyFormatFloat('0.0', Speed) + 'kph');
        end;

        AddItem('Distance', MyFormatFloat('0.0', Distance) + ' km');
        AddItem('Direction', MyFormatFloat('0.0', Direction * 180 / Pi) + '°');
        AddItem('Elevation', MyFormatFloat('0.0', Elevation) + '°');

        if ContainsPrediction then begin
            AddItem('Pred. Lat', MyFormatFloat('0.0000', PredictedLatitude));
            AddItem('Pred. Lon', MyFormatFloat('0.0000', PredictedLongitude));
        end;

        if Device <> '' then begin
            AddItem('Device', Device);
        end;

        if CurrentFrequency > 0 then begin
            AddItem('Frequency', MyFormatFloat('0.000', CurrentFrequency) + 'MHz');
        end;

        // Charts
        AltitudeChart.Series[0].AddXYPoint(Now, Altitude);
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

    // lstTelemetry.Items[7] := '   Sources: ' + Sources;
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

procedure TfrmPayload.ShowSNR(SNR: Double);
begin
    TabSheet2.TabVisible := True;
    edtSNR.Text := SNR.ToString;
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

procedure TfrmPayload.AddOrUpdateItem(Title, Value: String);
var
    i: Integer;
begin
    for i := 0 to lstTelemetry.Items.Count-1 do begin
        if Pos(Title, lstTelemetry.Items[i]) > 0 then begin
            lstTelemetry.Items[i] := Title.PadLeft(11) + ': ' + Value;
            Exit;
        end;
    end;

    AddItem(Title, Value);
end;

procedure TfrmPayload.UpdatePrediction(Position: THABPosition);
var
    MyBookmark: TBookmark;
begin
    with Position do begin
        if ContainsPrediction then begin
            AddOrUpdateItem('Pred. Lat', MyFormatFloat('0.0000', PredictedLatitude));
            AddOrUpdateItem('Pred. Lon', MyFormatFloat('0.0000', PredictedLongitude));
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
