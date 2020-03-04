unit Data;

interface

uses
  System.SysUtils, System.Classes, Data.DbxSqlite, Data.FMTBcd, Data.DB,
  Data.SqlExpr;

type
  TDataModule1 = class(TDataModule)
    SQLConnection1: TSQLConnection;
    qrySettings: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
