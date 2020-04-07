unit Payload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Source, Vcl.StdCtrls, Vcl.ComCtrls,
  AdvSmoothButton, AdvPanel;

type
  TfrmPayload = class(TfrmBase)
    tblPositions: TFDMemTable;
    tblLivePayloadsCounter: TIntegerField;
    tblLivePayloadsTimestamp: TDateTimeField;
    tblLivePayloadsLatitude: TFloatField;
    tblLivePayloadsLongitude: TFloatField;
    tblLivePayloadsAltitude: TFloatField;
    tblLivePayloadsDistance: TFloatField;
    srcPositions: TDataSource;
    tblPositionsSources: TStringField;
    pnlTop: TPanel;
    btnSettings: TButton;
    btnUp: TButton;
    btnDown: TButton;
    pnlTitle: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBAdvGrid3: TDBAdvGrid;
    pnlCommon: TAdvPanel;
    Label9: TLabel;
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    edtCurrentRSSI: TEdit;
    Label1: TLabel;
    edtPacketRSSI: TEdit;
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Down;
    procedure Up;
  public
    { Public declarations }
    procedure AddPosition(Position: THABPosition; Sources: String);
    procedure UpdatePosition(Position: THABPosition; Sources: String);
    procedure ShowPacketRSSI(PacketRSSI: Integer);
    procedure ShowCurrentRSSI(CurrentRSSI: Integer);
  end;


implementation

{$R *.dfm}

procedure TfrmPayload.AddPosition(Position: THABPosition; Sources: String);
var
    MyBookmark: TBookmark;
begin
    with tblPositions, Position do begin
        MyBookmark := GetBookmark;
        if RecordCount > 10 then begin
            Last;
            Delete;
        end;
        First;
        Insert;
        FieldByName('Counter').AsInteger := Counter;
        FieldByName('TimeStamp').AsDateTime := TimeStamp;
        FieldByName('Latitude').AsFloat := Latitude;
        FieldByName('Longitude').AsFloat := Longitude;
        FieldByName('Altitude').AsFloat := Altitude;
        FieldByName('Distance').AsFloat := Distance;
        FieldByName('Sources').AsString := Sources;
        Post;
        try
            GotoBookmark(MyBookmark);
            Prior;
        except
            Last;
        end;
    end;
end;

procedure TfrmPayload.btnDownClick(Sender: TObject);
begin
    Down;
end;

procedure TfrmPayload.btnUpClick(Sender: TObject);
begin
    Up;
end;

procedure TfrmPayload.FormCreate(Sender: TObject);
begin
    Up;
end;

procedure TfrmPayload.UpdatePosition(Position: THABPosition; Sources: String);
var
    MyBookmark: TBookmark;
begin
    with tblPositions, Position do begin
        MyBookmark := GetBookmark;
        First;
        Edit;
        FieldByName('Sources').AsString := Sources;
        Post;
        GotoBookmark(MyBookmark);
    end;
end;

procedure TfrmPayload.Down;
begin
    pnlMain.Height := 350;
    btnDown.Visible := False;
    btnUp.Visible := True;
end;

procedure TfrmPayload.Up;
begin
    pnlMain.Height := pnlTop.Top + pnlTop.Height + pnlTop.Margins.Top + 1;
    btnUp.Visible := False;
    btnDown.Visible := True;
end;

procedure TfrmPayload.ShowPacketRSSI(PacketRSSI: Integer);
begin
    TabSheet2.TabVisible := True;
    edtPacketRSSI.Text := PacketRSSI.ToString;
end;

procedure TfrmPayload.ShowCurrentRSSI(CurrentRSSI: Integer);
begin
    TabSheet2.TabVisible := True;
    edtCurrentRSSI.Text := CurrentRSSI.ToString;
end;

end.
