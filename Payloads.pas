unit Payloads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid;

type
  TfrmPayloads = class(TfrmNormal)
    DBAdvGrid3: TDBAdvGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayloads: TfrmPayloads;

implementation

{$R *.dfm}

end.
