unit LogtailSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel;

type
  TfrmLogtailSettings = class(TfrmSettings)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogtailSettings: TfrmLogtailSettings;

implementation

{$R *.dfm}

end.
