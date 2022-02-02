unit LoRaGatewaySource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SourceForm, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.Menus, Data.DB, Math, Miscellaneous,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, AdvSmoothButton,
  AdvOfficeButtons, AdvPanel, AdvGauge, VrControls, VrNavigator, Source;

type
  TfrmLoRaGatewaySource = class(TfrmSource)
    tabSignal: TTabSheet;
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    Label1: TLabel;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    edtCurrentRSSI0: TEdit;
    edtPacketRSSI0: TEdit;
    AdvGauge0: TAdvGauge;
    edtFrequencyError0: TEdit;
    Label2: TLabel;
    VrMediaButton1: TVrMediaButton;
    VrMediaButton2: TVrMediaButton;
    VrMediaButton3: TVrMediaButton;
    VrMediaButton4: TVrMediaButton;
    edtFrequency0: TEdit;
    Label3: TLabel;
    chkAFC0: TAdvOfficeCheckBox;
    TabSheet1: TTabSheet;
    AdvPanel1: TAdvPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    edtCurrentRSSI1: TEdit;
    edtPacketRSSI1: TEdit;
    AdvGauge1: TAdvGauge;
    edtFrequencyError1: TEdit;
    VrMediaButton5: TVrMediaButton;
    VrMediaButton6: TVrMediaButton;
    VrMediaButton7: TVrMediaButton;
    VrMediaButton8: TVrMediaButton;
    edtFrequency1: TEdit;
    chkAFC1: TAdvOfficeCheckBox;
    lblUploadChannel: TLabel;
    cmbUploadChannel: TComboBox;
    ProgressBar1: TProgressBar;
    btnSearch2: TButton;
    ProgressBar0: TProgressBar;
    btnSearch1: TButton;
    tmrSearch: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure VrMediaButton1Click(Sender: TObject);
    procedure VrMediaButton4Click(Sender: TObject);
    procedure VrMediaButton3Click(Sender: TObject);
    procedure VrMediaButton2Click(Sender: TObject);
    procedure chkAFC0Click(Sender: TObject);
    procedure edtFrequency0Exit(Sender: TObject);
    procedure btnSearch1Click(Sender: TObject);
    procedure tmrSearchTimer(Sender: TObject);
  private
    { Private declarations }
    Searching: Boolean;
    SearchCentreFrequency, SearchFrequencyError: Double;
    SearchChannel, SearchPacketCount, SearchStep: Integer;
    procedure SetFrequency(Channel: Integer; Frequency: Double);
    procedure OffsetFrequency(Channel: Integer; Offset: Double);
    procedure SetAFC(Channel: Integer; Enabled: Boolean);
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
  end;


implementation

{$R *.dfm}

uses SourcesForm;

procedure TfrmLoRaGatewaySource.btnSearch1Click(Sender: TObject);
begin
    SearchChannel := TButton(Sender).Tag;

    if SearchChannel = 1 then begin
        SearchCentreFrequency := MyStrToFloat(edtFrequency1.Text);
    end else begin
        SearchCentreFrequency := MyStrToFloat(edtFrequency0.Text);
    end;

    SearchStep := -6;
    Searching := True;
    NextSearch;
end;

procedure TfrmLoRaGatewaySource.chkAFC0Click(Sender: TObject);
begin
    SetAFC(TAdvOfficeCheckBox(Sender).Tag, TAdvOfficeCheckBox(Sender).Checked);
end;

procedure TfrmLoRaGatewaySource.FormCreate(Sender: TObject);
begin
    inherited;
    PageControl1.ActivePageIndex := 0;
end;

procedure TfrmLoRaGatewaySource.ShowCurrentRSSI(Channel, CurrentRSSI: Integer);
begin
    if Channel = 0 then begin
        edtCurrentRSSI0.Text := CurrentRSSI.ToString;
        AdvGauge0.Position := min(AdvGauge0.Maximum, CurrentRSSI);
    end else begin
        edtCurrentRSSI1.Text := CurrentRSSI.ToString;
        AdvGauge1.Position := min(AdvGauge1.Maximum, CurrentRSSI);
    end;
end;

procedure TfrmLoRaGatewaySource.ShowPacketRSSI(Channel, PacketRSSI: Integer);
begin
    if Channel = 0 then begin
        edtPacketRSSI0.Text := PacketRSSI.ToString;
    end else begin
        edtPacketRSSI1.Text := PacketRSSI.ToString;
    end;
end;

procedure TfrmLoRaGatewaySource.ShowFrequencyError(Channel: Integer; FrequencyError: Double);
begin
    if Channel = 0 then begin
        edtFrequencyError0.Text := MyFormatFloat('0.0', FrequencyError) + ' kHz';
    end else begin
        edtFrequencyError1.Text := MyFormatFloat('0.0', FrequencyError) + ' kHz';
    end;

    if Searching and (Channel = SearchChannel) then begin
        SearchFrequencyError := FrequencyError;
    end;
end;

procedure TfrmLoRaGatewaySource.ShowFrequency(Channel: Integer; Frequency: Double);
begin
    if Channel = 0 then begin
        edtFrequency0.Text := MyFormatFloat('0.0000', Frequency);
    end else begin
        edtFrequency1.Text := MyFormatFloat('0.0000', Frequency);
    end;
end;


procedure TfrmLoRaGatewaySource.ShowSetting(Setting, Value: String);
begin
    if Setting = 'Frequency_0' then begin
        edtFrequency0.Text := Value;
    end else if Setting = 'Frequency_1' then begin
        edtFrequency1.Text := Value;
    end else if Setting = 'AFC_0' then begin
        chkAFC0.Checked := Value = 'True';
    end else if Setting = 'AFC_1' then begin
        chkAFC1.Checked := Value = 'True';
    end;
end;

procedure TfrmLoRaGatewaySource.VrMediaButton1Click(Sender: TObject);
begin
    OffsetFrequency(TVrMediaButton(Sender).Tag, 0.0001);
end;

procedure TfrmLoRaGatewaySource.VrMediaButton2Click(Sender: TObject);
begin
    OffsetFrequency(TVrMediaButton(Sender).Tag, -0.001);
end;

procedure TfrmLoRaGatewaySource.VrMediaButton3Click(Sender: TObject);
begin
    OffsetFrequency(TVrMediaButton(Sender).Tag, -0.0001);
end;

procedure TfrmLoRaGatewaySource.VrMediaButton4Click(Sender: TObject);
begin
    OffsetFrequency(TVrMediaButton(Sender).Tag, 0.001);
end;

procedure TfrmLoRaGatewaySource.SetFrequency(Channel: Integer; Frequency: Double);
begin
    if Channel = 0 then begin
        edtFrequency0.Text := MyFormatFloat('0.0000', Frequency);
        SetSettingString(Group, 'Frequency_0', edtFrequency0.Text);
    end else begin
        edtFrequency1.Text := MyFormatFloat('0.0000', Frequency);
        SetSettingString(Group, 'Frequency_1', edtFrequency1.Text);
    end;

    AddStatusToLog('Set Ch' + Channel.ToString + ' to ' + MyFormatFloat('0.0000', Frequency));

    SetGroupChangedFlag(Group, True);
end;

procedure TfrmLoRaGatewaySource.SetAFC(Channel: Integer; Enabled: Boolean);
begin
    if Channel = 0 then begin
        SetSettingString(Group, 'AFC_0', BoolToStr(chkAFC0.Checked, True));
    end else begin
        SetSettingString(Group, 'AFC_1', BoolToStr(chkAFC1.Checked, True));
    end;

    SetGroupChangedFlag(Group, True);
end;

procedure TfrmLoRaGatewaySource.OffsetFrequency(Channel: Integer; Offset: Double);
var
    Frequency: Double;
begin
    try
        if Channel = 0 then begin
            Frequency := MyStrToFloat(edtFrequency0.Text);
        end else begin
            Frequency := MyStrToFloat(edtFrequency1.Text);
        end;

        SetFrequency(Channel, Frequency + Offset);
    except

    end;
end;

procedure TfrmLoRaGatewaySource.edtFrequency0Exit(Sender: TObject);
begin
    OffsetFrequency(TVrMediaButton(Sender).Tag, 0);
end;

procedure TfrmLoRaGatewaySource.SendUploadCommand;
begin
//    Command := 'send:' + cmbUploadChannel.Text + edtUploadPayload.Text + '/' + CommandCode + 'N' + edtCutdownPeriod.Text;

//    frmSources.SendToSource(SourceIndex, Command);

    frmSources.SendUplink(SourceIndex, uwNow, 0, cmbUploadChannel.ItemIndex, 'send:', '*' + BuildUplinkCommand, '');
end;

procedure TfrmLoRaGatewaySource.NextSearch;
begin
    Inc(SearchStep);

    if SearchStep > 5 then begin
        if SearchChannel = 1 then begin
            ProgressBar1.Position := 0;
            edtFrequency0Exit(edtFrequency1);
        end else begin
            ProgressBar1.Position := 0;
            edtFrequency0Exit(edtFrequency0);
        end;
        Searching := False;
    end else begin
        ProgressBar1.Position := SearchStep + 6;

        SetFrequency(SearchChannel, SearchCentreFrequency + SearchStep * 0.002);

        SearchPacketCount := 0;
        tmrSearch.Enabled := True;
    end;
end;

procedure TfrmLoRaGatewaySource.StopSearch;
begin
    if SearchChannel = 1 then begin
        edtFrequency1.Text := MyFormatFloat('0.000#', MyStrToFloat(edtFrequency1.Text) + SearchFrequencyError / 1000);
        edtFrequency0Exit(edtFrequency1);
    end else begin
        edtFrequency0.Text := MyFormatFloat('0.000#', MyStrToFloat(edtFrequency0.Text) + SearchFrequencyError / 1000);
        edtFrequency0Exit(edtFrequency0);
    end;

    ProgressBar0.Position := 0;
    ProgressBar1.Position := 0;

    // pnlSearchFrequency.Caption := '';

    Searching := False;
end;

procedure TfrmLoRaGatewaySource.tmrSearchTimer(Sender: TObject);
begin
    tmrSearch.Enabled := False;

    if SearchPacketCount > 1 then begin
        StopSearch;
    end else begin
        NextSearch;
    end;
end;

procedure TfrmLoRaGatewaySource.AddPosition(Position: THABPosition);
begin
    inherited;

    if Searching and (Position.Channel = SearchChannel) then begin
        Inc(SearchPacketCount);
    end;
end;


end.
