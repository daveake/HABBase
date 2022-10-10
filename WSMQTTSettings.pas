unit WSMQTTSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel, Miscellaneous;

type
  TfrmWSMQTTSettings = class(TfrmSettings)
    Label1: TLabel;
    edtHost: TEdit;
    Label2: TLabel;
    edtTopic: TEdit;
    Label3: TLabel;
    edtUserName: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    AdvSmoothButton1: TAdvSmoothButton;
    Label5: TLabel;
    edtPort: TEdit;
    procedure edtHostChange(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
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
  frmWSMQTTSettings: TfrmWSMQTTSettings;

implementation

{$R *.dfm}

uses Data, Misc;

procedure TfrmWSMQTTSettings.AdvSmoothButton1Click(Sender: TObject);
begin
    edtHost.Text := 'ws-reader.v2.sondehub.org';
    edtPort.Text := '443';
    edtTopic.Text := 'amateur/#';
    edtUserName.Text := '';
    edtPassword.Text := '';
end;

procedure TfrmWSMQTTSettings.ApplyChanges;
begin
    // Send settings to source

    SetSettingString(Group, 'Host', edtHost.Text);
    SetSettingString(Group, 'Port', edtPort.Text);
    SetSettingString(Group, 'Topic', edtTopic.Text);
    SetSettingString(Group, 'UserName', edtUserName.Text);
    SetSettingString(Group, 'Password', edtPassword.Text);

    // Tell source things have changed
    inherited;
end;

procedure TfrmWSMQTTSettings.edtHostChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmWSMQTTSettings.LoadFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        edtHost.Text := FieldByName('Host').AsString;
        edtPort.Text := FieldByName('Port').AsString;
        edtTopic.Text := FieldByName('Topic').AsString;
        edtUserName.Text := FieldByName('UserName').AsString;
        edtPassword.Text := FieldByName('Password').AsString;
    end;
end;

procedure TfrmWSMQTTSettings.SaveFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        FieldByName('Host').AsString := edtHost.Text;
        FieldByName('Port').AsString := edtPort.Text;
        FieldByName('Topic').AsString := edtTopic.Text;
        FieldByName('UserName').AsString := edtUserName.Text;
        FieldByName('Password').AsString := edtPassword.Text;
    end;
end;

end.
