unit UploadStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmUploadStatus = class(TfrmBase)
    lstLog: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddStatusToLog(Status: String);
  end;


implementation

{$R *.dfm}

procedure TfrmUploadStatus.AddStatusToLog(Status: String);
begin
    if Status <> '' then begin
        with lstLog do begin
            if Items.Count > 30 then begin
                Items.Delete(30);
            end;

            Items.Insert(0, Status);
            ItemIndex := 0;
        end;
    end;
end;

end.
