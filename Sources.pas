unit Sources;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataGrid, AdvUtil, Data.FMTBcd,
  Datasnap.DBClient, Data.DB, Datasnap.Provider, Data.SqlExpr, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Vcl.ExtCtrls;

type
  TfrmSources = class(TfrmDataGrid)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSources: TfrmSources;

implementation

{$R *.dfm}

end.
