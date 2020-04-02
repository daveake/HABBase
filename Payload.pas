unit Payload;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, AdvObj,
  BaseGrid, AdvGrid, DBAdvGrid, Source;

type
  TfrmPayload = class(TfrmBase)
    pnlTitle: TPanel;
    DBAdvGrid3: TDBAdvGrid;
    tblPositions: TFDMemTable;
    tblLivePayloadsCounter: TIntegerField;
    tblLivePayloadsTimestamp: TDateTimeField;
    tblLivePayloadsLatitude: TFloatField;
    tblLivePayloadsLongitude: TFloatField;
    tblLivePayloadsAltitude: TFloatField;
    tblLivePayloadsDistance: TFloatField;
    srcPositions: TDataSource;
    tblPositionsSources: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddPosition(Position: THABPosition; Sources: String);
    procedure UpdatePosition(Position: THABPosition; Sources: String);
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


end.
