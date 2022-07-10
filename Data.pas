unit Data;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageJSON,
  VCL.Forms, FireDAC.Stan.StorageBin, Miscellaneous, Source,
  FireDAC.Phys.SQLiteWrapper.Stat;

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
    tblSettingsUDPPort: TIntegerField;
    tblSettingsTopHeight: TIntegerField;
    tblSettingsBottomLeftHeight: TIntegerField;
    tblSettingsBottomHeight: TIntegerField;
    tblSettingsTopMiddleHeight: TIntegerField;
    tblSettingsLatitude: TFloatField;
    tblSettingsLongitude: TFloatField;
    tblSettingsAltitude: TFloatField;
    srcSettings: TDataSource;
    tblSettingsLeftWidth: TIntegerField;
    tblWhiteListEnabled: TBooleanField;
    tblWhiteListHAB: TBooleanField;
    tblWhiteListSonde: TBooleanField;
    tblWhiteListRemote: TBooleanField;
    tblWhiteListMask: TStringField;
    tblWhiteListDistance: TFloatField;
    tblSettingsRightWidth: TIntegerField;
    tblSettingsExpiry: TIntegerField;
    tblClonedSources: TFDMemTable;
    tblSettingsUplinkHABHUB: TBooleanField;
    tblSettingsUplinkHABLINK: TBooleanField;
    tblSettingsUplinkMQTT: TBooleanField;
    tblSettingsUplinkSSDV: TBooleanField;
    tblSettingsMQTTHost: TStringField;
    tblSettingsMQTTTopic: TStringField;
    tblSettingsMQTTUserName: TStringField;
    tblSettingsMQTTPassword: TStringField;
    tblClonedSettings: TFDMemTable;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    IntegerField12: TIntegerField;
    BooleanField1: TBooleanField;
    BooleanField2: TBooleanField;
    BooleanField3: TBooleanField;
    BooleanField4: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function AddPayloadToTable(Position: THABPosition; Table: TFDMemTable): Boolean;
    procedure LoadSettingsFromJSON;
    procedure LoadSourcesFromJSON;
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
    FileName: String;
begin
    LoadSettingsFromJSON;

    LoadSourcesFromJSON;

    FileName := ExtractFilePath(Application.ExeName) + 'whitelist.json';
    if FileExists(FileName) then begin
        tblWhiteList.LoadFromFile(FileName);
    end;
end;

procedure TDataModule1.LoadSettingsFromJSON;
var
    i: Integer;
    FileName: String;
begin
    FileName := ExtractFilePath(Application.ExeName) + 'settings.json';

    if FileExists(FileName) then begin
        try
            tblSettings.LoadFromFile(FileName);
        except
            tblClonedSettings.LoadFromFile(FileName);

            if tblClonedSettings.FieldDefs.Count < tblSettings.FieldDefs.Count then begin
                while not tblClonedSettings.EOF do begin
                    tblSettings.Append;
                    for i := 0 to tblClonedSettings.Fields.Count-1 do begin
                        tblSettings.Fields[i].Assign(tblClonedSettings.Fields[i]);
                    end;
                    tblSettings.Post;

                    tblClonedSettings.Next;
                end;
            end else begin
                tblSettings.LoadFromFile(FileName);
            end;

            tblClonedSettings.Close;
        end;
    end;
end;

procedure TDataModule1.LoadSourcesFromJSON;
var
    i: Integer;
    FileName: String;
begin
    FileName := ExtractFilePath(Application.ExeName) + 'sources.json';

    if FileExists(FileName) then begin
        tblClonedSources.LoadFromFile(FileName);

        if tblClonedSources.FieldDefs.Count < tblSources.FieldDefs.Count then begin
            while not tblClonedSources.EOF do begin
                tblSources.Append;
                for i := 0 to tblClonedSources.Fields.Count-1 do begin
                    tblSources.Fields[i].Assign(tblClonedSources.Fields[i]);
                end;
                tblSources.Post;

                tblClonedSources.Next;
            end;
        end else begin
            tblSources.LoadFromFile(FileName);
        end;

        tblClonedSources.Close;
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
        FieldByName('Counter').AsInteger := Position.Counter;
        FieldByName('TimeStamp').AsDateTime := Position.TimeStamp;
        FieldByName('Latitude').AsFloat := Position.Latitude;
        FieldByName('Longitude').AsFloat := Position.Longitude;
        FieldByName('Altitude').AsFloat := Position.Altitude;
        FieldByName('Distance').AsFloat := Position.Distance;
        FieldByName('ReceivedLocally').AsBoolean := not Position.ReceivedRemotely;

        Post;

        GotoBookmark(MyBookmark);

        EnableControls;
    end;
end;



end.
