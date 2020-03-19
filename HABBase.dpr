program HABBase;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Data in 'Data.pas' {DataModule1: TDataModule},
  Base in 'Base.pas' {frmBase},
  HABTypes in '..\HABRx\HABTypes.pas',
  Miscellaneous in '..\HABRx\Miscellaneous.pas',
  SerialSource in '..\HABRx\SerialSource.pas',
  SocketSource in '..\HABRx\SocketSource.pas',
  Source in '..\HABRx\Source.pas',
  BaseTypes in 'BaseTypes.pas',
  SourceForm in 'SourceForm.pas' {frmSource},
  Logtail in 'Logtail.pas' {frmLogtail},
  Modal in 'Modal.pas' {frmModal},
  Normal in 'Normal.pas' {frmNormal},
  Tool in 'Tool.pas' {frmTool},
  ToolLivePayload in 'ToolLivePayload.pas' {frmLivePayloads};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLivePayloads, frmLivePayloads);
  Application.Run;
end.
