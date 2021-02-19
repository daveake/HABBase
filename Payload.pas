unit Payload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Math,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Miscellaneous, Source, Vcl.StdCtrls, Vcl.ComCtrls,
  AdvSmoothButton, AdvPanel, AdvProgr, AdvGauge, VclTee.TeeGDIPlus, Map,
  VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, Vcl.Menus;

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
    AltitudeChart: TChart;
    Series1: TLineSeries;
    pnlTSS: TPanel;
    btnDown: TButton;
    btnUp: TButton;
    btnSettings: TButton;
    PopupMenu1: TPopupMenu;
    ClearHistory1: TMenuItem;
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearHistory1Click(Sender: TObject);
    procedure pnlTitleClick(Sender: TObject);
  private
    { Private declarations }
    ItemIndex: Integer;
    procedure Down;
    procedure Up;
    procedure AddItem(Title, Value: String);
  public
    { Public declarations }
    procedure AddPosition(Position: THABPosition; Sources: String);
    procedure UpdateSources(Position: THABPosition; Sources: String);
    procedure ShowPacketRSSI(PacketRSSI: Integer);
    procedure ShowCurrentRSSI(CurrentRSSI: Integer);
    procedure ShowFrequencyError(FrequencyError: Double);
    procedure ShowDetails(Show: Boolean);
  end;


implementation

{$R *.dfm}

uses Payloads;

procedure TfrmPayload.AddItem(Title, Value: String);
begin
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
        AddItem('Elevation', MyFormatFloat('0.0', Elevation) + ' deg');

        if ContainsPrediction then begin
            AddItem('Pred. Lat', MyFormatFloat('0.0000', Latitude));
            AddItem('Pred. Lon', MyFormatFloat('0.0000', Longitude));
        end;

        if Device <> '' then begin
            AddItem('Device', Device);
        end;

        if CurrentFrequency > 0 then begin
            AddItem('Frequency', MyFormatFloat('0.000', CurrentFrequency) + 'MHz');
        end;

        // Charts
        AltitudeChart.Series[0].AddXY(Now, Altitude);
    end;
end;

procedure TfrmPayload.btnDownClick(Sender: TObject);
begin
    Down;
    frmPayloads.HighlightPayload(pnlTitle.Caption, False, True);
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
    pnlMain.Height := 350;
    btnDown.Visible := False;
    btnUp.Visible := True;
end;

procedure TfrmPayload.Up;
begin
    pnlMain.Height := pnlTop.Top + pnlTop.Height + pnlTop.Margins.Top + 1;
    btnUp.Visible := False;
    btnDown.Visible := True;
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

end.
