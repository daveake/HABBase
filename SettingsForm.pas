unit SettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Base, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, AdvPanel, Miscellaneous;

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
    procedure btnSaveClick(Sender: TObject);
    procedure chKEnabledClick(Sender: TObject);
    procedure edtCodeChange(Sender: TObject);
  private
    { Private declarations }
  protected
    SettingsID: Integer;
    Group: String;
    procedure ApplyChanges; virtual;
    procedure SaveFields; virtual;
    procedure LoadFields; virtual;
    function GetSetting(FieldName, Settings: String): String;
  public
    { Public declarations }
    function LoadForm(ID: Integer): Boolean;
  end;


implementation

{$R *.dfm}

uses Data;

procedure TfrmSettings.btnSaveClick(Sender: TObject);
begin
    // Save settinbgs for source to pick up
    ApplyChanges;

    // Save settings in memory table and then json file
    with DataModule1.tblSources do begin
        if FindKey([SettingsID]) then begin
            Edit;

            SaveFields;

            Post;

            SaveToFile(ExtractFilePath(Application.ExeName) + 'sources.json');
        end;
    end;

    Close;
end;

procedure TfrmSettings.chKEnabledClick(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmSettings.edtCodeChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

function TfrmSettings.LoadForm(ID: Integer): Boolean;
begin
    SettingsID := ID;
    Group := ID.ToString;

    with DataModule1.tblSources do begin
        if FindKey([ID]) then begin
            LoadFields;
        end;
    end;

    Caption := Caption + ' - ' + Group + ': ' + edtCode.Text + ' (' + edtName.Text + ')';

    Result := ShowModal = mrOK;
end;

procedure TfrmSettings.ApplyChanges;
begin
    SetSettingBoolean(Group, 'Enabled', chkEnabled.Checked);
    SetGroupChangedFlag(Group, True);
end;

procedure TfrmSettings.LoadFields;
begin
    with DataModule1.tblSources do begin
        edtCode.Text := FieldByName('Code').AsString;
        edtName.Text := FieldByName('Name').AsString;
        chkEnabled.Checked := FieldByName('Enabled').AsBoolean;
    end;
end;

procedure TfrmSettings.SaveFields;
begin
    with DataModule1.tblSources do begin
        FieldByName('Code').AsString := edtCode.Text;
        FieldByName('Name').AsString := edtName.Text;
        FieldByName('Enabled').AsBoolean := chkEnabled.Checked;
    end;
end;

function TfrmSettings.GetSetting(FieldName, Settings: String): String;
var
    Position: Integer;
    Temp: String;
begin
    Position := Pos(';' + FieldName + '=', Settings);
    if Position > 0 then begin
        Temp := Copy(Settings, Position + Length(FieldName) + 2, 99);
        Position := Pos(';', Temp);
        if Position > 0 then begin
            Result := Copy(Temp, 1, Position-1);
        end else begin
            Result := Temp;
        end;
    end else begin
        Result := '';
    end;
end;


end.
