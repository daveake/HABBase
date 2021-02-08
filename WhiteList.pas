unit WhiteList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Modal, AdvSmoothButton, Vcl.ExtCtrls,
  AdvPanel, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  Vcl.DBCtrls, Data, Data.DB, Vcl.StdCtrls, Vcl.Mask;

type
  TfrmWhiteList = class(TfrmModal)
    DBAdvGrid2: TDBAdvGrid;
    btnAppend: TAdvSmoothButton;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    btnDelete: TAdvSmoothButton;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    tmrInit: TTimer;
    Label3: TLabel;
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure tmrInitTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    Loading: Boolean;
    procedure ShowEditing(Editing: Boolean);
  public
    { Public declarations }
  end;

implementation

uses Main, Payloads, SourcesForm;

{$R *.dfm}

procedure TfrmWhiteList.btnAppendClick(Sender: TObject);
begin
    DataModule1.tblWhiteList.Append;
    ShowEditing(True);
end;

procedure TfrmWhiteList.btnCancelClick(Sender: TObject);
begin
    DataModule1.tblWhiteList.Cancel;
    ShowEditing(True);
end;

procedure TfrmWhiteList.btnDeleteClick(Sender: TObject);
begin
    if MessageDlg('Are you sure you want to permanently remove this entry ?', mtWarning, mbOKCancel, 0) = mrOK then begin
        DataModule1.tblWhiteList.Delete;
    end;
end;

procedure TfrmWhiteList.btnSaveClick(Sender: TObject);
begin
    DataModule1.tblWhiteList.Post;
    DataModule1.tblWhiteList.SaveToFile(ExtractFilePath(Application.ExeName) + 'whitelist.json');
    frmPayloads.UpdateActivePayloads;
    frmSources.UpdateSourceFilters;
    ShowEditing(False);
end;

procedure TfrmWhiteList.DBCheckBox1Click(Sender: TObject);
begin
    ShowEditing(True);
end;

procedure TfrmWhiteList.DBEdit1Change(Sender: TObject);
begin
    ShowEditing(True);
end;

procedure TfrmWhiteList.FormActivate(Sender: TObject);
begin
    tmrInit.Enabled := True;
end;

procedure TfrmWhiteList.FormCreate(Sender: TObject);
begin
    Loading := True;
end;

procedure TfrmWhiteList.ShowEditing(Editing: Boolean);
begin
    Editing := Editing and not Loading;

    btnAppend.Enabled := not Editing;
    btnDelete.Enabled := not Editing;
    AdvSmoothButton1.Enabled := not Editing;
    btnSave.Enabled := Editing;
    btnCancel.Enabled := Editing;
end;

procedure TfrmWhiteList.tmrInitTimer(Sender: TObject);
begin
    Loading := False;
    tmrInit.Enabled := False;
    ShowEditing(False);
end;

end.
