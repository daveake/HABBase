program HABBase;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Data in 'Data.pas' {DataModule1: TDataModule},
  Base in 'Base.pas' {frmBase},
  DataBase in 'DataBase.pas' {frmDataBase},
  Masks in 'Masks.pas' {frmMasks},
  DataGrid in 'DataGrid.pas' {frmDataGrid},
  Sources in 'Sources.pas' {frmSources};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmMasks, frmMasks);
  Application.CreateForm(TfrmDataGrid, frmDataGrid);
  Application.CreateForm(TfrmSources, frmSources);
  Application.Run;
end.
