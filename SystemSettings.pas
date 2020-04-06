unit SystemSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, AdvSmoothButton, Vcl.ExtCtrls, AdvPanel;

type
  TfrmSystemSettings = class(TForm)
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label2: TLabel;
    DBEdit4: TDBEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSystemSettings: TfrmSystemSettings;

implementation

{$R *.dfm}

procedure TfrmSystemSettings.btnCancelClick(Sender: TObject);
begin
    DataModule1.tblSettings.Cancel;
    Close;
end;

procedure TfrmSystemSettings.btnSaveClick(Sender: TObject);
begin
    DataModule1.tblSettings.Post;
    DataModule1.tblSettings.SaveToFile(ExtractFilePath(Application.ExeName) + 'settings.json');
    Close;
end;

procedure TfrmSystemSettings.DBEdit1Change(Sender: TObject);
begin
    btnSave.Enabled := True;
end;

procedure TfrmSystemSettings.FormCreate(Sender: TObject);
begin
    DataModule1.tblSettings.Edit;
end;

end.