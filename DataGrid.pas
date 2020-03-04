unit DataGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataBase, Data.FMTBcd, AdvUtil,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Datasnap.DBClient, Data.DB,
  Datasnap.Provider, Data.SqlExpr, Vcl.ExtCtrls;

type
  TfrmDataGrid = class(TfrmDataBase)
    DBAdvGrid1: TDBAdvGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDataGrid: TfrmDataGrid;

implementation

{$R *.dfm}

end.
