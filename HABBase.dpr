program HABBase;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Data in 'Data.pas' {DataModule1: TDataModule},
  Base in 'Base.pas' {frmBase},
  Miscellaneous in '..\HABRx\Miscellaneous.pas',
  SerialSource in '..\HABRx\SerialSource.pas',
  SocketSource in '..\HABRx\SocketSource.pas',
  Source in '..\HABRx\Source.pas',
  BaseTypes in 'BaseTypes.pas',
  Logtail in 'Logtail.pas' {frmLogtail},
  Modal in 'Modal.pas' {frmModal},
  Normal in 'Normal.pas' {frmNormal},
  Tool in 'Tool.pas' {frmTool},
  ToolWhiteList in 'ToolWhiteList.pas' {frmToolWhiteList},
  WhiteList in 'WhiteList.pas' {frmWhiteList},
  Map in 'Map.pas' {frmMap},
  Payloads in 'Payloads.pas' {frmPayloads},
  SourcesForm in 'SourcesForm.pas' {frmSources},
  SourceForm in 'SourceForm.pas' {frmSource},
  GatewaySource in '..\HABRx\GatewaySource.pas',
  SettingsForm in 'SettingsForm.pas' {frmSettings},
  GatewaySettings in 'GatewaySettings.pas' {frmGatewaySettings},
  NewSource in 'NewSource.pas' {frmNewSource},
  LoRaSerialSettings in 'LoRaSerialSettings.pas' {frmLoRaSerialSettings},
  Misc in 'Misc.pas',
  Habitat in '..\HABRx\Habitat.pas',
  SystemSettings in 'SystemSettings.pas' {frmSystemSettings},
  LogtailSettings in 'LogtailSettings.pas' {frmLogtailSettings},
  Payload in 'Payload.pas' {frmPayload},
  LoRaGatewaySource in 'LoRaGatewaySource.pas' {frmLoRaGatewaySource},
  UDPSource in '..\HABRx\UDPSource.pas',
  UDPSettings in 'UDPSettings.pas' {frmUDPSettings},
  TCPSettings in 'TCPSettings.pas' {frmTCPSettings},
  LoRaSerialSource in 'LoRaSerialSource.pas' {frmLoRaSerialSource},
  ToolSettings in 'ToolSettings.pas' {frmToolSettings},
  SSDV in '..\HABRx\SSDV.pas',
  HABLink in '..\HABRx\HABLink.pas',
  APRSSource in '..\HABRx\APRSSource.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
