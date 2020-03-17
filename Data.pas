unit Data;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageJSON,
  VCL.Forms;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    tblSettings: TFDMemTable;
    tblSources: TFDMemTable;
    srcSources: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateSource(ID: Integer; PayloadID: String);
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


end.
