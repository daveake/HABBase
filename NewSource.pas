unit NewSource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothButton, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmNewSource = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    btnOK: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    pnlAbout: TPanel;
    lblAbout: TLabel;
    procedure ComboBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmNewSource.ComboBox1Click(Sender: TObject);
begin
    btnOK.Enabled := ComboBox1.ItemIndex >= 0;

    case ComboBox1.ItemIndex of
        -1: lblAbout.Caption := 'Please chooose type of source from the list';
        0:  lblAbout.Caption := 'This source listens to the HABHUB logtail, so it can find payloads even if they don''t have payload documents';
        1:  lblAbout.Caption := 'This connects via TCP/IP to the control port on a LoRa Gateway, to set the frequency etc and to receive telemetry';
        2:  lblAbout.Caption := 'This can be used with USB or Bluetooth LoRa receivers, via the associated COM port';
        3:  lblAbout.Caption := 'This connects via TCP/IP to any source that emits balloon telemetry';
        4:  lblAbout.Caption := 'This listens for telemetry broadcast on a UDP port.  It can listen to several ports at once';
        5:  lblAbout.Caption := 'This polls HABHUB for new or recent payload telemetry';
        6:  lblAbout.Caption := 'This connects to an APRS server (OGN - glidernet - uses its own APRS servers)';
        7:  lblAbout.Caption := 'This can be used with an MQTT broker e.g. HABLINK that publishes payload telemetry as UKHAS or JSON';
        8:  lblAbout.Caption := 'This can be used with an MQTT WEBSOCKETS broker e.g. SONDEHUB that publishes payload telemetry as UKHAS or JSON';
        9:  lblAbout.Caption := 'This source polls SONDEHUB AMATEUR for payloads within a set radius of your station position';
        else lblAbout.Caption := 'UNKNOWN SOURCE';
    end;
end;

procedure TfrmNewSource.FormCreate(Sender: TObject);
begin
    ComboBox1Click(nil);
end;

end.
