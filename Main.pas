unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvSplitter, Math,
  AdvCustomControl, Vcl.StdCtrls, ActiveX, MSHTML,
  Data.FMTBcd, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DateUtils, AdvSmoothStatusIndicator, AdvGDIP, AdvPanel, BaseTypes,
  SourceForm,
  Source, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid;

type
//    THABPosition = record
//        PayloadID:      String;
//        PayloadDocID:   String;
//        TimeStamp:      TDateTime;
//        Latitude:       Double;
//        Longitude:      Double;
//        Altitude:       Double;
//        Distance:       Double;
//    end;

//    TFlightMode = (fmIdle, fmLaunched, fmDescending, fmHoming, fmDirect, fmDownwind, fmUpwind, fmLanding, fmLanded);

    THABSource = class
        public
            ID:                 Integer;
            Enabled:            Boolean;
            Connected:          Boolean;
            Description:        String;
            Code:               String;
            // SectionName:     String;
            // Index:           Integer;
            SourceType:         TSourceType;
            Form:               TfrmSource;
            Indicator:          TAdvSmoothStatusIndicator;
            LatestPosition:     THABPosition;
    end;

type
  TfrmMain = class(TForm)
    AdvSplitter1: TAdvSplitter;
    pnlLeft: TPanel;
    AdvSplitter2: TAdvSplitter;
    plMiddleLeft: TPanel;
    AdvSplitter3: TAdvSplitter;
    pnlTopLeft: TPanel;
    pnlSources: TPanel;
    pnlMain: TPanel;
    AdvSplitter4: TAdvSplitter;
    AdvSplitter5: TAdvSplitter;
    Panel6: TPanel;
    pnlPayloads: TPanel;
    Panel8: TPanel;
    Panel4: TPanel;
    pnlStatus: TAdvPanel;
    pnlHidden: TPanel;
    lstPositions: TListBox;
    lstPayloadIDs: TListBox;
    lslLog: TListBox;
    DBAdvGrid1: TDBAdvGrid;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    HABSources: Array[1..32] of THABSource;
    procedure LoadData;
    procedure LoadForms;
    procedure LoadSources;
    procedure AddPayload(Position: THABPosition);
    procedure LoadSource(SourceIndex, pID: Integer; pCode: String; pSourceType: TSourceType);
  public
    { Public declarations }
    procedure ShowConnected(SourceIndex: Integer; IsConnected: Boolean);
    procedure NewPosition(SourceIndex: Integer; Position: THABPosition);
  end;

var
  frmMain: TfrmMain;

implementation

uses Data, Sources, Payloads, Logtail;

{$R *.dfm}

procedure TfrmMain.FormActivate(Sender: TObject);
const
    FirstTime: Boolean = True;
begin
    if FirstTime then begin
        FirstTime := False;
        LoadData;
        LoadForms;
        LoadSources;
    end;
end;

procedure TfrmMain.LoadData;
begin
    DataModule1 := TDataModule1.Create(nil);
end;

procedure TfrmMain.LoadForms;
begin
//    frmSources.pnlMain.Parent := pnlSources;
//    frmPayloads.pnlMain.Parent := pnlPayloads;
end;

procedure TfrmMain.LoadSources;
var
    Index: Integer;
begin
    with DataModule1.tblSources do begin
        First;
        Index := 0;
        while not EOF do begin
            Inc(Index);
            LoadSource(Index, FieldByName('ID').AsInteger, FieldByName('Code').AsString, TSourceType(FieldByName('Type').AsInteger));
            Next;
        end;
    end;
end;

procedure TfrmMain.AddPayload(Position: THABPosition);
var
    Bookmark: TBookmark;
begin


(*
    with DataModule1.tblPayloads do begin
        Bookmark := GetBookmark;
        DisableControls;
        if FindKey([Position.PayloadID]) then begin
            Edit;
        end else begin
            Append;
            FieldByName('PayloadID').AsString := Position.PayloadID;
        end;

        FieldByName('PayloadID').AsString := Position.PayloadID;
        FieldByName('DocID').AsString := Position.PayloadDocID;
        FieldByName('TimeStamp').AsString := FormatDateTime('hh:nn:ss', Position.TimeStamp);
        FieldByName('Latitude').AsFloat := Position.Latitude;
        FieldByName('Longitude').AsFloat := Position.Longitude;
        FieldByName('Altitude').AsFloat := Position.Altitude;
        FieldByName('Distance').AsFloat := Position.Distance;

        Post;

        GotoBookmark(Bookmark);

        EnableControls;
    end;
*)

//    frmPayloads.UpdateTables;
end;

procedure TfrmMain.LoadSource(SourceIndex, pID: Integer; pCode: String; pSourceType: TSourceType);
begin
    HABSources[SourceIndex] := THABSource.Create;

    with HABSources[SourceIndex] do begin
        ID := pID;
        Code := pCode;
        SourceType := pSourceType;

        // Index := SourceIndex;
        // SectionName := Section;

        // Enabled := INI.ReadBool(Section, 'Enabled', True);
//        Description := INI.ReadString(Section, 'Description', 'Source ' + IntToStr(SourceIndex));
//        Code := INI.ReadString(Section, 'Code', IntToStr(SourceIndex));

//        SourceTypeText := INI.ReadString(Section, 'Type', '');

    // TSourceType = (stLogtail, stGateway, stTCP, stUDP, stSerial);       // stDLFLDigi, stSerial, stHabitat, stUDP);
        if SourceType = stLogtail then begin
            Form := TfrmLogtail.Create(nil);
            Form.pnlMain.Parent := pnlHidden;
//        end else if SourceTypeText = 'DLFLDigi' then begin
//            SourceType := stDLFLDigi;
//            Form := TfrmDLFLDigiSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'Serial' then begin
//            SourceType := stSerial;
//            Form := TfrmLoRaSerialSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'Habitat' then begin
//            SourceType := stHabitat;
//            Form := TfrmHabitatSource.Create(nil, HABDB, HabitatThread, SourceIndex);
//        end else if SourceTypeText = 'UDP' then begin
//            SourceType := stUDP;
//            Form := TfrmUDPSource.Create(nil, HABDB, HabitatThread, SourceIndex);
        end else begin
            Form := nil;
        end;

        if Form <> nil then begin
            Form.SourceIndex := SourceIndex;
//            Form.HideYourself;

//            Form.Caption := Form.Caption + ' - ' + Description;

//            Form.LoadSettings;

            // Status bar button
        end;

        Indicator := TAdvSmoothStatusIndicator.Create(Self);
        with Indicator do begin
            Parent := pnlStatus;
            Align := alRight;
            AlignWithMargins := True;
            BorderWidth := 1;
            Appearance.Fill.Color := clGray;
            Appearance.Fill.ColorMirror := clNone;
            Appearance.Fill.ColorMirrorTo := clNone;
            Appearance.Fill.GradientType := TAdvGradientType.gtSolid;
            Appearance.Fill.BorderColor := 3355443;
            Appearance.Fill.Rounding := 18;
            Appearance.Fill.ShadowOffset := 0;
            Appearance.Font.Height := -24;
            Appearance.Font.Color := clWhite;
            AutoSize := True;
            Caption := Code;
            Tag := SourceIndex;
            // PopupMenu := menuSource;
            // OnClick := DataSourceClick;
        end;
    end;
end;

procedure TfrmMain.NewPosition(SourceIndex: Integer; Position: THABPosition);
var
    Index: Integer;
    PositionString: String;
begin
    with HABSources[SourceIndex] do begin
        LatestPosition := Position;
        if Position.PayloadID <> '' then begin
            if Position.PayloadDocID = '' then begin
                PositionString := Position.PayloadID + ' ** NO PAYLOAD DOC **';
            end else begin
                PositionString := Position.PayloadID + ' ' + Position.PayloadDocID + ':' +
                                  FormatDateTime('hh:nn:ss', Position.TimeStamp) + ', ' +
                                  FormatFloat('0.00000', Position.Latitude) + ', ' +
                                  FormatFloat('0.00000', Position.Longitude) + ', ' +
                                  FormatFloat('0', Position.Altitude) + ', ' +
                                  FormatFloat('0', Position.Distance) + 'km';
            end;

            Index := lstPayloadIDs.Items.IndexOf(Position.PayloadID);

            if Index < 0 then begin
                // Not in list so add it
                lstPayloadIDs.Items.Add(Position.PayloadID);
                lstPositions.Items.Add(PositionString);

                AddPayload(Position);

                lslLog.ItemIndex := lslLog.Items.Add('Added ' + Position.PayloadID);
            end else begin
                if lstPositions.Items[Index] <> PositionString then begin
                    lstPositions.Items[Index] := PositionString;

                    AddPayload(Position);
                    // Memo1.Lines.Add('Changed ' + Position.PayloadID);
                end;
            end;

            DataModule1.UpdateSource(ID, Position.PayloadID);
        end;

        // Update indicator
        Indicator.Appearance.Fill.Color := clGreen;

    end;
end;


procedure TfrmMain.ShowConnected(SourceIndex: Integer; IsConnected: Boolean);
begin
    with HABSources[SourceIndex] do begin
        Connected := IsConnected;
        if IsConnected then begin
            Indicator.Appearance.Fill.Color := clOlive;
        end else begin
            Indicator.Appearance.Fill.Color := clRed;
        end;
    end;
end;

end.
