unit ToolLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tool, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmToolLog = class(TfrmTool)
    lstLog: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmToolLog: TfrmToolLog;

implementation

{$R *.dfm}

end.
