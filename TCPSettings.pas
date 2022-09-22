unit TCPSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel, Miscellaneous;

type
  TfrmTCPSettings = class(TfrmSettings)
    Label1: TLabel;
    edtHost: TEdit;
    Label2: TLabel;
    edtPort: TEdit;
    chkUpload: TAdvOfficeCheckBox;
    procedure edtHostChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyChanges; override;
    procedure LoadFields; override;
    procedure SaveFields; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses Data, Misc;

procedure TfrmTCPSettings.ApplyChanges;
begin
    // Send settings to source

    SetSettingString(Group, 'Host', edtHost.Text);
    SetSettingInteger(Group, 'Port', StrToIntDef(edtPort.Text, 0));

    // Tell source things have changed
    inherited;
end;

procedure TfrmTCPSettings.edtHostChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmTCPSettings.LoadFields;
var
    Settings: String;
begin
    inherited;

    with DataModule1.tblSources do begin
        edtHost.Text := FieldByName('Host').AsString;
        edtPort.Text := FieldByName('Port').AsString;

        Settings := ';' + FieldByName('Settings').AsString;
        chkUpload.Checked  := GetBooleanSetting('Upload', Settings);
    end;
end;

procedure TfrmTCPSettings.SaveFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        FieldByName('Host').AsString := edtHost.Text;
        FieldByName('Port').AsString := edtPort.Text;
        FieldByName('Settings').AsString := 'Upload=' + BoolToStr(chkUpload.Checked, True);
    end;
end;

end.
