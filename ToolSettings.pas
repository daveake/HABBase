unit ToolSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tool, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvSmoothButton, SystemSettings;

type
  TfrmToolSettings = class(TfrmTool)
    btnSettings: TAdvSmoothButton;
    btnFilters: TAdvSmoothButton;
    procedure pnlMainResize(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnFiltersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmToolSettings: TfrmToolSettings;

implementation

{$R *.dfm}

uses Map, Payloads, WhiteList;

procedure TfrmToolSettings.btnFiltersClick(Sender: TObject);
var
    frmWhiteList: TfrmWhiteList;
begin
    frmWhiteList := TfrmWhiteList.Create(nil);
    frmWhiteList.ShowModal;
    frmWhiteList.Free;
end;

procedure TfrmToolSettings.btnSettingsClick(Sender: TObject);
var
    frmSystemSettings: TfrmSystemSettings;
begin
    frmSystemSettings := TfrmSystemSettings.Create(nil);
    if frmSystemSettings.ShowModal = mrOK then begin
        frmMap.SetHomePosition;
        frmPayloads.UpdateActivePayloads;
    end;
    frmPayloads.CheckForExpiredPayloads;
    frmSystemSettings.Free;
end;

procedure TfrmToolSettings.pnlMainResize(Sender: TObject);
begin
    btnSettings.Width := pnlMain.Width div 2;
end;

end.
