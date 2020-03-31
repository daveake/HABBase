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
    procedure AddToLog(Msg: String);
  end;

var
  frmToolLog: TfrmToolLog;

implementation

{$R *.dfm}

procedure TfrmToolLog.AddToLog(Msg: String);
begin
    if frmToolLog.lstLog.Items.Count > 100 then begin
        frmToolLog.lstLog.Items.Delete(0);
    end;

    frmToolLog.lstLog.ItemIndex := frmToolLog.lstLog.Items.Add(Msg);
end;

end.
