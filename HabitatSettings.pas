unit HabitatSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel, Miscellaneous;

type
  TfrmHabitatSettings = class(TfrmSettings)
    Label1: TLabel;
    edtWhiteList: TEdit;
    procedure edtWhiteListChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ApplyChanges; override;
    procedure LoadFields; override;
    procedure SaveFields; override;
  end;

var
  frmHabitatSettings: TfrmHabitatSettings;

implementation

{$R *.dfm}

uses Data, Misc;

procedure TfrmHabitatSettings.ApplyChanges;
begin
    // Send settings to source

    SetSettingString(Group, 'WhiteList', edtWhiteList.Text);

    // Tell source things have changed
    inherited;
end;

procedure TfrmHabitatSettings.LoadFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        edtWhiteList.Text := FieldByName('WhiteList').AsString;
    end;
end;

procedure TfrmHabitatSettings.SaveFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        FieldByName('WhiteList').AsString := edtWhiteList.Text;
    end;
end;

procedure TfrmHabitatSettings.edtWhiteListChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

end.
