unit LoRaSerialSource;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SourceForm, AdvUtil, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.Menus, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, AdvSmoothButton,
  AdvOfficeButtons, AdvPanel;

type
  TfrmLoRaSerialSource = class(TfrmSource)
    TabSheet2: TTabSheet;
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    edtCurrentRSSI: TEdit;
    edtPacketRSSI: TEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowCurrentRSSI(Channel, CurrentRSSI: Integer); override;
    procedure ShowPacketRSSI(Channel, PacketRSSI: Integer); override;
  end;


implementation

{$R *.dfm}

procedure TfrmLoRaSerialSource.FormCreate(Sender: TObject);
begin
    inherited;
    PageControl1.ActivePageIndex := 0;
end;

procedure TfrmLoRaSerialSource.ShowCurrentRSSI(Channel, CurrentRSSI: Integer);
begin
    edtCurrentRSSI.Text := CurrentRSSI.ToString;
end;

procedure TfrmLoRaSerialSource.ShowPacketRSSI(Channel, PacketRSSI: Integer);
begin
    edtPacketRSSI.Text := PacketRSSI.ToString;
end;

end.
