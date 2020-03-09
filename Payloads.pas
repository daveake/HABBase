unit Payloads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataGrid, AdvUtil, Data.FMTBcd,
  Datasnap.DBClient, Data.DB, Datasnap.Provider, Data.SqlExpr, Vcl.Grids,
  AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Vcl.ExtCtrls, Main, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmPayloads = class(TfrmDataGrid)
    qryMainID: TFDAutoIncField;
    qryMainPayloadID: TWideStringField;
    qryMainDocID: TWideStringField;
    qryMainTimeStamp: TWideStringField;
    qryMainLatitude: TFloatField;
    qryMainLongitude: TFloatField;
    qryMainAltitude: TIntegerField;
    qryMainSources: TWideStringField;
    qryMainCallsigns: TWideStringField;
    qryMainEnabled: TIntegerField;
    qryMainNoDelete: TIntegerField;
    qryMainFieldList: TWideStringField;
    qryMainFieldValues: TWideStringField;
    qryMainSentence: TWideStringField;
    qryMainDistance: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPayloads: TfrmPayloads;

implementation

{$R *.dfm}


end.
