unit SourceForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Menus, Vcl.StdCtrls, Source;

type
  TfrmSource = class(TfrmBase)
    pnlTitle: TPanel;
    tblPositions: TFDMemTable;
    tblLivePayloadsCounter: TIntegerField;
    tblLivePayloadsTimestamp: TDateTimeField;
    tblLivePayloadsLatitude: TFloatField;
    tblLivePayloadsLongitude: TFloatField;
    tblLivePayloadsAltitude: TFloatField;
    tblLivePayloadsDistance: TFloatField;
    srcPositions: TDataSource;
    tblPositionsPayloadID: TStringField;
    DBAdvGrid3: TDBAdvGrid;
    btnSettings: TButton;
    menuSource: TPopupMenu;
    ModifySource: TMenuItem;
    DeleteSource: TMenuItem;
    mnuAddNewSource: TMenuItem;
    procedure btnSettingsClick(Sender: TObject);
    procedure ModifySourceClick(Sender: TObject);
    procedure mnuAddNewSourceClick(Sender: TObject);
    procedure DeleteSourceClick(Sender: TObject);
    procedure AddPosition(Position: THABPosition);
  private
    { Private declarations }
  public
    SourceIndex: Integer;
    { Public declarations }
    Enabled: Boolean;
  end;


implementation

{$R *.dfm}

uses SourcesForm;

procedure TfrmSource.btnSettingsClick(Sender: TObject);
var
    pnt: TPoint;
begin
    if GetCursorPos(pnt) then begin
        menuSource.Popup(pnt.X, pnt.Y);
    end;
end;

procedure TfrmSource.DeleteSourceClick(Sender: TObject);
begin
    frmSources.DeleteSource(SourceIndex);
end;

procedure TfrmSource.mnuAddNewSourceClick(Sender: TObject);
begin
    frmSources.AddNewSource;
end;

procedure TfrmSource.ModifySourceClick(Sender: TObject);
begin
    frmSources.ModifySource(SourceIndex);
end;

procedure TfrmSource.AddPosition(Position: THABPosition);
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
        FieldByName('PayloadID').AsString := PayloadID;
        FieldByName('Counter').AsInteger := Counter;
        FieldByName('TimeStamp').AsDateTime := TimeStamp;
        FieldByName('Latitude').AsFloat := Latitude;
        FieldByName('Longitude').AsFloat := Longitude;
        FieldByName('Altitude').AsFloat := Altitude;
        FieldByName('Distance').AsFloat := Distance;
        Post;
        try
            GotoBookmark(MyBookmark);
            Prior;
        except
            Last;
        end;
    end;
end;

end.
