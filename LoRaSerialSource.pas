unit LoRaSerialSource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SourceForm, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.Menus, Data.DB, Math, Source,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, AdvSmoothButton,
  AdvOfficeButtons, AdvPanel, AdvGauge, VrControls, VrNavigator, Miscellaneous;

type
  TfrmLoRaSerialSource = class(TfrmSource)
    tabSignal: TTabSheet;
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    Label1: TLabel;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    edtCurrentRSSI: TEdit;
    edtPacketRSSI: TEdit;
    edtFrequencyError: TEdit;
    Label2: TLabel;
    VrMediaButton1: TVrMediaButton;
    VrMediaButton2: TVrMediaButton;
    VrMediaButton3: TVrMediaButton;
    VrMediaButton4: TVrMediaButton;
    edtFrequency: TEdit;
    Label3: TLabel;
    chkAFC: TAdvOfficeCheckBox;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    tmrSearch: TTimer;
    Label4: TLabel;
    edtPassword: TEdit;
    lblWhenType: TLabel;
    lblWhenSeconds: TLabel;
    cmbUploadWhen: TComboBox;
    edtWhenSeconds: TEdit;
    lblVersionInfo: TLabel;
    AdvGauge1: TAdvGauge;
    procedure FormCreate(Sender: TObject);
    procedure VrMediaButton1Click(Sender: TObject);
    procedure VrMediaButton4Click(Sender: TObject);
    procedure VrMediaButton3Click(Sender: TObject);
    procedure VrMediaButton2Click(Sender: TObject);
    procedure edtFrequencyExit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure tmrSearchTimer(Sender: TObject);
    procedure cmbUploadWhenCloseUp(Sender: TObject);
  private
    { Private declarations }
    Searching: Boolean;
    SearchCentreFrequency, SearchFrequencyError: Double;
    SearchPacketCount, SearchStep: Integer;
    procedure SetFrequency(Frequency: Double);
    procedure OffsetFrequency(Offset: Double);
    procedure NextSearch;
    procedure StopSearch;
  protected
    procedure SendUploadCommand; override;
  public
    { Public declarations }
    procedure AddPosition(Position: THABPosition); override;
    procedure ShowCurrentRSSI(Channel, CurrentRSSI: Integer); override;
    procedure ShowPacketRSSI(Channel, PacketRSSI: Integer); override;
    procedure ShowFrequencyError(Channel: Integer; FrequencyError: Double); override;
    procedure ShowFrequency(Channel: Integer; Frequency: Double); override;
    procedure ShowSetting(Setting, Value: String); override;
    procedure DoAFC(Channel: Integer; FrequencyError: Double); override;
    procedure SetDeviceVersion(Version: Double); override;
    procedure SetFromCallingMode(CallingModeFrequency:   Double; CallingModeImplicit, CallingModeError, CallingModeBandwidth, CallingModeSpreading, CallingModeOptimize: Integer); override;
  end;


implementation

{$R *.dfm}

uses SourcesForm;

procedure TfrmLoRaSerialSource.edtFrequencyExit(Sender: TObject);
begin
    OffsetFrequency(0);
end;

procedure TfrmLoRaSerialSource.FormCreate(Sender: TObject);
begin
    inherited;
    PageControl1.ActivePageIndex := 0;
end;

procedure TfrmLoRaSerialSource.ShowCurrentRSSI(Channel, CurrentRSSI: Integer);
begin
    edtCurrentRSSI.Text := CurrentRSSI.ToString;
    AdvGauge1.Position := min(AdvGauge1.Maximum, CurrentRSSI);
end;

procedure TfrmLoRaSerialSource.ShowPacketRSSI(Channel, PacketRSSI: Integer);
begin
    edtPacketRSSI.Text := PacketRSSI.ToString;
end;

procedure TfrmLoRaSerialSource.ShowFrequencyError(Channel: Integer; FrequencyError: Double);
begin
    edtFrequencyError.Text := MyFormatFloat('0.0', FrequencyError) + ' kHz';
    SearchFrequencyError := FrequencyError;
end;

procedure TfrmLoRaSerialSource.ShowFrequency(Channel: Integer; Frequency: Double);
begin
    edtFrequency.Text := MyFormatFloat('0.000', Frequency);
end;


procedure TfrmLoRaSerialSource.ShowSetting(Setting, Value: String);
begin
    if Setting = 'Frequency' then begin
        edtFrequency.Text := Value;
    end;
end;

procedure TfrmLoRaSerialSource.VrMediaButton1Click(Sender: TObject);
begin
    OffsetFrequency(0.0001);
end;

procedure TfrmLoRaSerialSource.VrMediaButton2Click(Sender: TObject);
begin
    OffsetFrequency(-0.001);
end;

procedure TfrmLoRaSerialSource.VrMediaButton3Click(Sender: TObject);
begin
    OffsetFrequency(-0.0001);
end;

procedure TfrmLoRaSerialSource.VrMediaButton4Click(Sender: TObject);
begin
    OffsetFrequency(0.001);
end;

procedure TfrmLoRaSerialSource.SetFrequency(Frequency: Double);
begin
    edtFrequency.Text := MyFormatFloat('0.0000', Frequency);
    SetSettingString(Group, 'Frequency', edtFrequency.Text);
    SetGroupChangedFlag(Group, True);

    AddStatusToLog('Set frequency to ' + edtFrequency.Text);
end;

procedure TfrmLoRaSerialSource.OffsetFrequency(Offset: Double);
var
    Frequency: Double;
begin
    try
        Frequency := StrToFloat(edtFrequency.Text);

        SetFrequency(Frequency + Offset);
    except

    end;
end;

procedure TfrmLoRaSerialSource.Button2Click(Sender: TObject);
begin
    SearchCentreFrequency := StrToFloat(edtFrequency.Text);
    SearchStep := -6;
    Searching := True;
    NextSearch;
end;

procedure TfrmLoRaSerialSource.cmbUploadWhenCloseUp(Sender: TObject);
begin
    edtWhenSeconds.Visible := cmbUploadWhen.ItemIndex = 1;
    lblWhenSeconds.Visible := edtWhenSeconds.Visible;
end;

procedure TfrmLoRaSerialSource.DoAFC(Channel: Integer; FrequencyError: Double);
begin
    if chkAFC.Checked and (abs(FrequencyError) > 0.001) then begin
        OffsetFrequency(FrequencyError);
    end;
end;

procedure TfrmLoRaSerialSource.NextSearch;
begin
    Inc(SearchStep);

    if SearchStep > 5 then begin
        // pnlSearchFrequency.Caption := '';
        ProgressBar1.Position := 0;
        Searching := False;
        edtFrequencyExit(nil);
    end else begin
        ProgressBar1.Position := SearchStep + 6;

        SetFrequency(SearchCentreFrequency + SearchStep * 0.002);

        SearchPacketCount := 0;
        tmrSearch.Enabled := True;
    end;
end;

procedure TfrmLoRaSerialSource.StopSearch;
begin
    edtFrequency.Text := MyFormatFloat('0.000#', StrToFloat(edtFrequency.Text) + SearchFrequencyError / 1000);

    ProgressBar1.Position := 0;

    // pnlSearchFrequency.Caption := '';

    Searching := False;

    edtFrequencyExit(nil);
end;

procedure TfrmLoRaSerialSource.tmrSearchTimer(Sender: TObject);
begin
    tmrSearch.Enabled := False;

    if SearchPacketCount > 1 then begin
        StopSearch;
    end else begin
        NextSearch;
    end;
end;

procedure TfrmLoRaSerialSource.AddPosition(Position: THABPosition);
begin
    inherited;

    Inc(SearchPacketCount);
end;

procedure TfrmLoRaSerialSource.SendUploadCommand;
var
    When: TUplinkWhen;
    WhenSeconds: Integer;
begin
    case cmbUploadWhen.ItemIndex of
        0:  When := uwNow;
        1:  When := uwSecondsAfterMinute;
        2:  When := uwAfterRx;
    end;

    WhenSeconds := StrToIntDef(edtWhenSeconds.Text, 0);

    frmSources.SendUplink(SourceIndex, When, WhenSeconds, -1, '~T*', BuildUplinkCommand, edtPassword.Text);
end;

procedure TfrmLoRaSerialSource.SetDeviceVersion(Version: Double);
begin
    lblVersionInfo.Visible := Version < 2.0;
end;

procedure TfrmLoRaSerialSource.SetFromCallingMode(CallingModeFrequency: Double; CallingModeImplicit, CallingModeError, CallingModeBandwidth, CallingModeSpreading, CallingModeOptimize: Integer);
begin
    edtFrequency.Text := MyFormatFloat('0.0000', CallingModeFrequency);
    SetSettingString(Group, 'Frequency', edtFrequency.Text);
    SetSettingString(Group, 'Mode', '1');
    SetGroupChangedFlag(Group, True);

    AddStatusToLog('CALLING MODE');
    AddStatusToLog('Set frequency to ' + edtFrequency.Text);
    AddStatusToLog('Set mode to ' + '1');
end;


end.
