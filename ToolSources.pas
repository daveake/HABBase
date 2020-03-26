unit ToolSources;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tool, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid;

type
  TfrmToolSources = class(TfrmTool)
    DBAdvGrid1: TDBAdvGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmToolSources: TfrmToolSources;

implementation

{$R *.dfm}

end.
