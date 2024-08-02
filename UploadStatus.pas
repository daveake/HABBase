unit UploadStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, Vcl.StdCtrls, Misc;

type
  TfrmUploadStatus = class(TfrmBase)
    lstLog: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
    Section, LastMessage: String;
    procedure AddStatusToLog(Status: String);
  end;


implementation

{$R *.dfm}

procedure TfrmUploadStatus.AddStatusToLog(Status: String);
begin
    if (Status <> '') and (Status <> LastMessage) then begin
        LastMessage := Status;

        with lstLog do begin
            if Items.Count > 30 then begin
                Items.Delete(30);
            end;

            Items.Insert(0, FormatDateTime('hh:nn:ss', Now) + ' - ' + Status);
            ItemIndex := 0;

            WriteToLogFile('UPLOADS', Section, Status);
        end;
    end;
end;

end.
