unit Data;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageJSON,
  VCL.Forms, FireDAC.Stan.StorageBin, Source;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    tblSettings: TFDMemTable;
    tblSources: TFDMemTable;
    srcSources: TDataSource;
    srcWhiteList: TDataSource;
    tblWhiteList: TFDMemTable;
    tblAllPayloads: TFDMemTable;
    srcAllPayloads: TDataSource;
    srcLivePayloads: TDataSource;
    tblLivePayloads: TFDMemTable;
    tblLivePayloadsPayloadID: TStringField;
    tblLivePayloadsCounter: TIntegerField;
    tblLivePayloadsTimestamp: TDateTimeField;
    tblLivePayloadsLatitude: TFloatField;
    tblLivePayloadsLongitude: TFloatField;
    tblLivePayloadsAltitude: TFloatField;
    tblLivePayloadsDistance: TFloatField;
    tblLivePayloadsReceivedLocally: TBooleanField;
    tblSettingsCallsign: TStringField;
    tblSettingsFormLeft: TIntegerField;
    tblSettingsFormTop: TIntegerField;
    tblSettingsFormWidth: TIntegerField;
    tblSettingsFormHeight: TIntegerField;
    tblSettingsTopLeftHeight: TIntegerField;
    tblSettingsTopHeight: TIntegerField;
    tblSettingsBottomLeftHeight: TIntegerField;
    tblSettingsBottomHeight: TIntegerField;
    tblSettingsTopMiddleHeight: TIntegerField;
    tblSettingsLatitude: TFloatField;
    tblSettingsLongitude: TFloatField;
    tblSettingsAltitude: TFloatField;
    srcSettings: TDataSource;
    tblSettingsLeftWidth: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
  public
    { Public declarations }
    procedure UpdateSource(ID: Integer; PayloadID: String);
    function AddPayloadToLiveTable(Position: THABPosition): Boolean;
    function AddPayloadToFullTable(Position: THABPosition): Boolean;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
    Path, FileName: String;
begin
    Path := ExtractFilePath(Application.ExeName);

    FileName := Path + 'settings.json';
    if FileExists(FileName) then begin
        tblSettings.LoadFromFile(FileName);
    end;

    FileName := Path + 'sources.json';
    if FileExists(FileName) then begin
        tblSources.LoadFromFile(FileName);
    end;
end;

procedure TDataModule1.UpdateSource(ID: Integer; PayloadID: String);
begin
    with tblSources do begin
        if FindKey([ID]) then begin
            Edit;
            FieldByName('Payload').AsString := PayloadID;
            Post;
        end;
    end;
end;

function TDataModule1.AddPayloadToFullTable(Position: THABPosition): Boolean;
begin
    Result := AddPayloadToTable(Position, tblAllPayloads);
end;

function TDataModule1.AddPayloadToLiveTable(Position: THABPosition): Boolean;
begin
    Result := AddPayloadToTable(Position, tblLivePayloads);
end;

function TDataModule1.AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
var
    MyBookmark: TBookmark;
begin
    Result := False;

    with Table do begin
        MyBookmark := GetBookmark;
        DisableControls;
        if FindKey([Position.PayloadID]) then begin
            Edit;
        end else begin
            Append;
            FieldByName('PayloadID').AsString := Position.PayloadID;
            Result := True;
        end;

        FieldByName('PayloadID').AsString := Position.PayloadID;
        // FieldByName('DocID').AsString := Position.PayloadDocID;
        FieldByName('Counter').AsInteger := Position.Counter;
        FieldByName('TimeStamp').AsDateTime := Position.TimeStamp;
        FieldByName('Latitude').AsFloat := Position.Latitude;
        FieldByName('Longitude').AsFloat := Position.Longitude;
        FieldByName('Altitude').AsFloat := Position.Altitude;
        FieldByName('Distance').AsFloat := Position.Distance;
        FieldByName('ReceivedLocally').AsBoolean := False;

        Post;

        GotoBookmark(MyBookmark);

        EnableControls;
    end;
end;



end.
