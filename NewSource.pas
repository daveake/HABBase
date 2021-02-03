unit NewSource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothButton, Vcl.StdCtrls;

type
  TfrmNewSource = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    btnOK: TAdvSmoothButton;
    AdvSmoothButton1: TAdvSmoothButton;
    procedure ComboBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmNewSource.ComboBox1Click(Sender: TObject);
begin
    btnOK.Enabled := ComboBox1.ItemIndex >= 0;
end;

end.
