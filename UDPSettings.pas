unit UDPSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SettingsForm, AdvSmoothButton,
  AdvOfficeButtons, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel, Miscellaneous;

type
  TfrmUDPSettings = class(TfrmSettings)
    Label2: TLabel;
    edtPortList: TEdit;
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

procedure TfrmUDPSettings.ApplyChanges;
begin
    // Send settings to source

    SetSettingString(Group, 'Port', edtPortList.Text);

    // Tell source things have changed
    inherited;
end;

procedure TfrmUDPSettings.edtHostChange(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmUDPSettings.LoadFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        edtPortList.Text := FieldByName('Port').AsString;
    end;
end;

procedure TfrmUDPSettings.SaveFields;
begin
    inherited;

    with DataModule1.tblSources do begin
        FieldByName('Port').AsString := edtPortList.Text;
    end;
end;

end.
