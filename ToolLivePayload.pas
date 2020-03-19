unit ToolLivePayload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tool, Vcl.ExtCtrls, Vcl.StdCtrls,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid;

type
  TfrmLivePayloads = class(TfrmTool)
    DBAdvGrid3: TDBAdvGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLivePayloads: TfrmLivePayloads;

implementation

{$R *.dfm}

end.
