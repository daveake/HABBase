unit Modal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothButton, Vcl.ExtCtrls, AdvPanel;

type
  TfrmModal = class(TForm)
    pnlStatus: TAdvPanel;
    pnlHidden: TPanel;
    pnlMain: TPanel;
    AdvSmoothButton1: TAdvSmoothButton;
    AdvSmoothButton2: TAdvSmoothButton;
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure AdvSmoothButton1Click(Sender: TObject);
  private
    { Private declarations }
  protected
    function SaveChanges: Boolean; virtual;
    procedure UpdateMainForm; virtual;
    procedure CancelChanges; virtual;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmModal.AdvSmoothButton1Click(Sender: TObject);
begin
    CancelChanges;
    ModalResult := mrCancel;    // Close;
end;

procedure TfrmModal.AdvSmoothButton2Click(Sender: TObject);
begin
    if SaveChanges then begin
        UpdateMainForm;
        ModalResult := mrOK;    // Close;
    end;
end;

function TfrmModal.SaveChanges: Boolean;
begin
    Result := True;
end;


procedure TfrmModal.CancelChanges;
begin
    // virtual
end;

procedure TfrmModal.UpdateMainForm;
begin
    // virtual
end;


end.
