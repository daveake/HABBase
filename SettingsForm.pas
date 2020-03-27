unit SettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Base, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, AdvPanel;

type
  TfrmSettings = class(TForm)
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    Label10: TLabel;
    edtCode: TEdit;
    edtName: TEdit;
    chKEnabled: TAdvOfficeCheckBox;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
