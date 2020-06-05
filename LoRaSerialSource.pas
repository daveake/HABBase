unit LoRaSerialSource;

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
  TfrmLoRaSerialSource = class(TfrmSource)
    tabSignal: TTabSheet;
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    Label1: TLabel;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    edtCurrentRSSI: TEdit;
    edtPacketRSSI: TEdit;
    AdvGauge1: TAdvGauge;
    edtFrequencyError: TEdit;
    Label2: TLabel;
    VrMediaButton1: TVrMediaButton;
    VrMediaButton2: TVrMediaButton;
    VrMediaButton3: TVrMediaButton;
    VrMediaButton4: TVrMediaButton;
    edtFrequency: TEdit;
    Label3: TLabel;
    chkAFC: TAdvOfficeCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure VrMediaButton1Click(Sender: TObject);
    procedure VrMediaButton4Click(Sender: TObject);
    procedure VrMediaButton3Click(Sender: TObject);
    procedure VrMediaButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetFrequency(Frequency: Double);
    procedure OffsetFrequency(Offset: Double);
  public
    { Public declarations }
    procedure ShowCurrentRSSI(Channel, CurrentRSSI: Integer); override;
    procedure ShowPacketRSSI(Channel, PacketRSSI: Integer); override;
    procedure ShowFrequencyError(Channel: Integer; FrequencyError: Double); override;
    procedure ShowFrequency(Channel: Integer; Frequency: Double); override;
    procedure ShowSetting(Setting, Value: String); override;
    procedure DoAFC(Channel: Integer; FrequencyError: Double); override;
  end;


implementation

{$R *.dfm}

uses Miscellaneous;

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
    edtFrequencyError.Text := FormatFloat('0.0', FrequencyError) + ' kHz';
end;

procedure TfrmLoRaSerialSource.ShowFrequency(Channel: Integer; Frequency: Double);
begin
    edtFrequency.Text := FormatFloat('0.000', Frequency);
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
    edtFrequency.Text := FormatFloat('0.0000', Frequency);
    SetSettingString(Group, 'Frequency', edtFrequency.Text);
    SetGroupChangedFlag(Group, True);
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

procedure TfrmLoRaSerialSource.DoAFC(Channel: Integer; FrequencyError: Double);
begin
    if chkAFC.Checked and (abs(FrequencyError) > 0.001) then begin
        OffsetFrequency(FrequencyError);
    end;
end;

end.
