unit GatewaySettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel, Miscellaneous;

type
  TfrmGatewaySettings = class(TfrmSettings)
    Label1: TLabel;
    edtHost: TEdit;
    Label2: TLabel;
    edtPort: TEdit;
    Label3: TLabel;
    edtFrequency1: TEdit;
    Label4: TLabel;
    edtMode1: TEdit;
    Label5: TLabel;
    edtFrequency2: TEdit;
    Label6: TLabel;
    edtMode2: TEdit;
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
  frmGatewaySettings: TfrmGatewaySettings;

implementation

{$R *.dfm}

uses Data;

procedure TfrmGatewaySettings.ApplyChanges;
begin
    // Send settings to source

    SetSettingString(Group, 'Host', edtHost.Text);
    SetSettingInteger(Group, 'Port', StrToIntDef(edtPort.Text, 0));

    SetSettingString(Group, 'Frequency_0', edtFrequency1.Text);
    SetSettingInteger(Group, 'Mode_0', StrToIntDef(edtMode1.Text, 0));

    SetSettingString(Group, 'Frequency_1', edtFrequency2.Text);
    SetSettingInteger(Group, 'Mode_1', StrToIntDef(edtMode2.Text, 0));

    // Tell source things have changed
    inherited;
end;

procedure TfrmGatewaySettings.edtHostChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmGatewaySettings.LoadFields;
var
    Settings: String;
begin
    inherited;

    with DataModule1.tblSources do begin
        edtHost.Text := FieldByName('Host').AsString;
        edtPort.Text := FieldByName('Port').AsString;

        Settings := ';' + FieldByName('Settings').AsString;

        edtFrequency1.Text := GetSetting('Frequency_0', Settings);
        edtMode1.Text      := GetSetting('Mode_0', Settings);
        edtFrequency2.Text := GetSetting('Frequency_1', Settings);
        edtMode2.Text      := GetSetting('Mode_1', Settings);
    end;
end;

procedure TfrmGatewaySettings.SaveFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        FieldByName('Host').AsString := edtHost.Text;
        FieldByName('Port').AsString := edtPort.Text;
        FieldByName('Settings').AsString := 'Frequency_0=' + edtFrequency1.Text + ';' +
                                            'Mode_0=' + edtMode1.Text + ';' +
                                            'Frequency_1=' + edtFrequency2.Text + ';' +
                                            'Mode_1=' + edtMode2.Text;
    end;
end;

end.
