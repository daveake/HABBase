unit LoRaSerialSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel, Registry;

type
  TfrmLoRaSerialSettings = class(TfrmSettings)
    Label2: TLabel;
    Label3: TLabel;
    edtFrequency1: TEdit;
    Label4: TLabel;
    edtMode1: TEdit;
    chkUpload: TAdvOfficeCheckBox;
    cmbPort: TComboBox;
    procedure edtPortChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

    SetSettingString(Group, 'Port', cmbPort.Text);

    SetSettingString(Group, 'Frequency', edtFrequency1.Text);
    SetSettingInteger(Group, 'Mode', StrToIntDef(edtMode1.Text, 0));

    // Tell source things have changed
    inherited;
end;

procedure TfrmLoRaSerialSettings.edtPortChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmLoRaSerialSettings.FormCreate(Sender: TObject);
var
    reg: TRegistry;
    i: Integer;
    st: TStringList;
begin
    cmbPort.Items.Clear;

    reg := TRegistry.Create;
    try
        reg.RootKey := HKEY_LOCAL_MACHINE;
        reg.OpenKeyReadOnly('hardware\devicemap\serialcomm');
        st := TstringList.Create;
        try
            reg.GetValueNames(st);
            for i := 0 to st.Count - 1 do begin
                cmbPort.Items.Add(reg.Readstring(st.strings[i]));
            end;
        finally
            st.Free;
        end;
        reg.CloseKey;
    finally
        reg.Free;
    end;
end;

procedure TfrmLoRaSerialSettings.LoadFields;
var
    Settings: String;
begin
    inherited;

    with DataModule1.tblSources do begin
        if cmbPort.Items.IndexOf(FieldByName('Port').AsString) < 0 then begin
            cmbPort.Items.Append(FieldByName('Port').AsString);
        end;

        cmbPort.ItemIndex := cmbPort.Items.IndexOf(FieldByName('Port').AsString);

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
        FieldByName('Port').AsString := cmbPort.Text;
        FieldByName('Settings').AsString := 'Frequency=' + edtFrequency1.Text + ';' +
                                            'Mode=' + edtMode1.Text + ';' +
                                            'Upload=' + BoolToStr(chkUpload.Checked, True);
    end;
end;

end.
