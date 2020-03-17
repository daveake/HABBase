program HABBase;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Data in 'Data.pas' {DataModule1: TDataModule},
  Base in 'Base.pas' {frmBase},
  DataBase in 'DataBase.pas' {frmDataBase},
  Masks in 'Masks.pas' {frmMasks},
  DataGrid in 'DataGrid.pas' {frmDataGrid},
  Sources in 'Sources.pas' {frmSources},
  Payloads in 'Payloads.pas' {frmPayloads},
  HABTypes in '..\HABRx\HABTypes.pas',
  Miscellaneous in '..\HABRx\Miscellaneous.pas',
  SerialSource in '..\HABRx\SerialSource.pas',
  SocketSource in '..\HABRx\SocketSource.pas',
  Source in '..\HABRx\Source.pas',
  BaseTypes in 'BaseTypes.pas',
  SourceForm in 'SourceForm.pas' {frmSource},
  Logtail in 'Logtail.pas' {frmLogtail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
