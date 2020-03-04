unit DataBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Data, Data.FMTBcd,
  Datasnap.DBClient, Data.DB, Datasnap.Provider, Data.SqlExpr, Vcl.ExtCtrls;

type
  TfrmDataBase = class(TfrmBase)
    qryMain: TSQLQuery;
    dspMain: TDataSetProvider;
    srcMain: TDataSource;
    cdsMain: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
