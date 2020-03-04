unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvSplitter;

type
  TfrmMain = class(TForm)
    AdvSplitter1: TAdvSplitter;
    Panel1: TPanel;
    AdvSplitter2: TAdvSplitter;
    Panel3: TPanel;
    AdvSplitter3: TAdvSplitter;
    Panel4: TPanel;
    pnlSources: TPanel;
    Panel2: TPanel;
    AdvSplitter4: TAdvSplitter;
    AdvSplitter5: TAdvSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadForms;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses Sources;

{$R *.dfm}

procedure TfrmMain.FormActivate(Sender: TObject);
const
    FirstTime: Boolean = True;
begin
    if FirstTime then begin
        FirstTime := False;
        LoadForms;
    end;
end;

procedure TfrmMain.LoadForms;
begin
    frmSources.pnlMain.Parent := pnlSources;
end;

end.
