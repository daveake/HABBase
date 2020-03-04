unit Masks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataBase, Data.FMTBcd,
  Datasnap.DBClient, Data.DB, Datasnap.Provider, Data.SqlExpr, Vcl.ExtCtrls;

type
  TfrmMasks = class(TfrmDataBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMasks: TfrmMasks;

implementation

{$R *.dfm}

end.
