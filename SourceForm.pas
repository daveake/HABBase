unit SourceForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls;

type
  TfrmSource = class(TfrmBase)
  private
    { Private declarations }
  public
    SourceIndex: Integer;
    { Public declarations }
    Enabled: Boolean;
  end;


implementation

{$R *.dfm}

end.
