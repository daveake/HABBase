unit ToolWhiteList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tool, AdvUtil, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmToolWhiteList = class(TfrmTool)
    DBAdvGrid2: TDBAdvGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmToolWhiteList: TfrmToolWhiteList;

implementation

uses WhiteList;

{$R *.dfm}

procedure TfrmToolWhiteList.Button1Click(Sender: TObject);
var
    frmWhiteList: TfrmWhiteList;
begin
    frmWhiteList := TfrmWhiteList.Create(nil);
    frmWhiteList.ShowModal;
    frmWhiteList.Free;
end;

end.
