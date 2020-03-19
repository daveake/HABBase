unit Tool;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmTool = class(TfrmBase)
    Panel1: TPanel;
    Button1: TButton;
    lblTitle: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
