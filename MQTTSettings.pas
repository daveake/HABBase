unit MQTTSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel, Miscellaneous;

type
  TfrmMQTTSettings = class(TfrmSettings)
    Label1: TLabel;
    edtHost: TEdit;
    Label2: TLabel;
    edtTopic: TEdit;
    Label3: TLabel;
    edtUserName: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
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

var
  frmMQTTSettings: TfrmMQTTSettings;

implementation

{$R *.dfm}

uses Data, Misc;

procedure TfrmMQTTSettings.ApplyChanges;
begin
    // Send settings to source

    SetSettingString(Group, 'Host', edtHost.Text);
    SetSettingString(Group, 'Topic', edtTopic.Text);
    SetSettingString(Group, 'UserName', edtUserName.Text);
    SetSettingString(Group, 'Password', edtPassword.Text);

    // Tell source things have changed
    inherited;
end;

procedure TfrmMQTTSettings.edtHostChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmMQTTSettings.LoadFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        edtHost.Text := FieldByName('Host').AsString;
        edtTopic.Text := FieldByName('Topic').AsString;
        edtUserName.Text := FieldByName('UserName').AsString;
        edtPassword.Text := FieldByName('Password').AsString;
    end;
end;

procedure TfrmMQTTSettings.SaveFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        FieldByName('Host').AsString := edtHost.Text;
        FieldByName('Topic').AsString := edtTopic.Text;
        FieldByName('UserName').AsString := edtUserName.Text;
        FieldByName('Password').AsString := edtPassword.Text;
    end;
end;

end.
