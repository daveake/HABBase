unit LoRaGatewaySource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SourceForm, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.Menus, Data.DB, Math,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, AdvSmoothButton,
  AdvOfficeButtons, AdvPanel, AdvGauge, VrControls, VrNavigator;

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
    procedure FormCreate(Sender: TObject);
    procedure VrMediaButton1Click(Sender: TObject);
    procedure VrMediaButton4Click(Sender: TObject);
    procedure VrMediaButton3Click(Sender: TObject);
    procedure VrMediaButton2Click(Sender: TObject);
    procedure chkAFC0Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetFrequency(Channel: Integer; Frequency: Double);
    procedure OffsetFrequency(Channel: Integer; Offset: Double);
    procedure SetAFC(Channel: Integer; Enabled: Boolean);
  public
    { Public declarations }
    procedure ShowCurrentRSSI(Channel, CurrentRSSI: Integer); override;
    procedure ShowPacketRSSI(Channel, PacketRSSI: Integer); override;
    procedure ShowFrequencyError(Channel: Integer; FrequencyError: Double); override;
    procedure ShowFrequency(Channel: Integer; Frequency: Double); override;
    procedure ShowSetting(Setting, Value: String); override;
  end;


implementation

{$R *.dfm}

uses Miscellaneous;

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
        edtFrequencyError0.Text := FormatFloat('0.0', FrequencyError) + ' kHz';
    end else begin
        edtFrequencyError1.Text := FormatFloat('0.0', FrequencyError) + ' kHz';
    end;
end;

procedure TfrmLoRaGatewaySource.ShowFrequency(Channel: Integer; Frequency: Double);
begin
    if Channel = 0 then begin
        edtFrequency0.Text := FormatFloat('0.0000', Frequency);
    end else begin
        edtFrequency1.Text := FormatFloat('0.0000', Frequency);
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
        edtFrequency0.Text := FormatFloat('0.0000', Frequency);
        SetSettingString(Group, 'Frequency_0', edtFrequency0.Text);
    end else begin
        edtFrequency1.Text := FormatFloat('0.0000', Frequency);
        SetSettingString(Group, 'Frequency_1', edtFrequency1.Text);
    end;

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
            Frequency := StrToFloat(edtFrequency0.Text);
        end else begin
            Frequency := StrToFloat(edtFrequency1.Text);
        end;

        SetFrequency(Channel, Frequency + Offset);
    except

    end;
end;

end.
