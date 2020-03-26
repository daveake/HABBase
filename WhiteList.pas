unit WhiteList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Modal, AdvSmoothButton, Vcl.ExtCtrls,
  AdvPanel, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid;

type
  TfrmWhiteList = class(TfrmModal)
    DBAdvGrid2: TDBAdvGrid;
  private
    { Private declarations }
  protected
    function SaveChanges: Boolean; override;
    procedure UpdateMainForm; override;
  public
    { Public declarations }
  end;

var
  frmWhiteList: TfrmWhiteList;

implementation

uses Main;

{$R *.dfm}

function TfrmWhiteList.SaveChanges: Boolean;
begin
    Result := True;
end;

procedure TfrmWhiteList.UpdateMainForm;
begin
    // virtual
end;


end.
