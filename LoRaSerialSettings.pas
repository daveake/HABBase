unit LoRaSerialSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel;

type
  TfrmLoRaSerialSettings = class(TfrmSettings)
    Label2: TLabel;
    edtPort: TEdit;
    Label3: TLabel;
    edtFrequency1: TEdit;
    Label4: TLabel;
    edtMode1: TEdit;
    chkUpload: TAdvOfficeCheckBox;
    procedure edtPortChange(Sender: TObject);
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

uses Data, Miscellaneous, Misc;

procedure TfrmLoRaSerialSettings.ApplyChanges;
begin
    // Send settings to source

    SetSettingString(Group, 'Port', edtPort.Text);

    SetSettingString(Group, 'Frequency', edtFrequency1.Text);
    SetSettingInteger(Group, 'Mode', StrToIntDef(edtMode1.Text, 0));

    // Tell source things have changed
    inherited;
end;

procedure TfrmLoRaSerialSettings.edtPortChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmLoRaSerialSettings.LoadFields;
var
    Settings: String;
begin
    inherited;

    with DataModule1.tblSources do begin
        edtPort.Text := FieldByName('Port').AsString;

        Settings := ';' + FieldByName('Settings').AsString;

        edtFrequency1.Text := GetSetting('Frequency', Settings);
        edtMode1.Text      := GetSetting('Mode', Settings);
        chkUpload.Checked  := GetBooleanSetting('Upload', Settings);
    end;
end;

procedure TfrmLoRaSerialSettings.SaveFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        FieldByName('Port').AsString := edtPort.Text;
        FieldByName('Settings').AsString := 'Frequency=' + edtFrequency1.Text + ';' +
                                            'Mode=' + edtMode1.Text + ';' +
                                            'Upload=' + BoolToStr(chkUpload.Checked, True);
    end;
end;

end.
