unit DataBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Data, Data.FMTBcd,
  Datasnap.DBClient, Data.DB, Datasnap.Provider, Data.SqlExpr, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmDataBase = class(TfrmBase)
    qryMain: TFDQuery;
    srcMain: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateTables;
  end;


implementation

{$R *.dfm}

procedure TfrmDataBase.UpdateTables;
begin
    qryMain.Refresh;
end;


end.
