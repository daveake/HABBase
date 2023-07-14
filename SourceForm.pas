unit SourceForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, AdvUtil, Vcl.Grids, AdvObj, BaseGrid,
  AdvGrid, DBAdvGrid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Menus, Vcl.StdCtrls, Miscellaneous, Source, Vcl.ComCtrls, AdvSmoothButton, AdvPanel;

type
  TfrmSource = class(TfrmBase)
    pnlTop: TPanel;
    tblPositions: TFDMemTable;
    tblLivePayloadsCounter: TIntegerField;
    tblLivePayloadsTimestamp: TDateTimeField;
    tblLivePayloadsLatitude: TFloatField;
    tblLivePayloadsLongitude: TFloatField;
    tblLivePayloadsAltitude: TFloatField;
    tblLivePayloadsDistance: TFloatField;
    srcPositions: TDataSource;
    tblPositionsPayloadID: TStringField;
    menuSource: TPopupMenu;
    ModifySource: TMenuItem;
    DeleteSource: TMenuItem;
    mnuAddNewSource: TMenuItem;
    pnlTitle: TPanel;
    PageControl1: TPageControl;
    tabHistory: TTabSheet;
    DBAdvGrid3: TDBAdvGrid;
    EnableSource: TMenuItem;
    tabStatus: TTabSheet;
    lstLog: TListBox;
    btnDown: TButton;
    btnUp: TButton;
    btnSettings: TButton;
    lblTitle: TLabel;
    PopupMenu1: TPopupMenu;
    ClearHistory1: TMenuItem;
    tabUplink: TTabSheet;
    lblUploadPayload: TLabel;
    edtUploadPayload: TEdit;
    lblUploadType: TLabel;
    btnSendUpload: TButton;
    PageControl2: TPageControl;
    tabCutdown: TTabSheet;
    tabOutput: TTabSheet;
    lblOutputPin: TLabel;
    edtPin: TEdit;
    edtPinPeriod: TEdit;
    lblOutputPeriod: TLabel;
    tabServo: TTabSheet;
    lblServoPin: TLabel;
    edtServoPin: TEdit;
    lblServoPeriod: TLabel;
    edtServoPeriod: TEdit;
    edtServoPosition: TEdit;
    lblServoPosn: TLabel;
    tabScript: TTabSheet;
    lblScriptName: TLabel;
    edtScriptName: TEdit;
    lblScriptParameters: TLabel;
    edtScriptParameters: TEdit;
    lblCutdownPeriod: TLabel;
    edtCutdownPeriod: TEdit;
    chkCutdownNow: TRadioButton;
    chkCutdownAltitude: TRadioButton;
    Label8: TLabel;
    edtAltitude: TEdit;
    pnlUpdated: TPanel;
    tmrUpdated: TTimer;
    procedure btnSettingsClick(Sender: TObject);
    procedure ModifySourceClick(Sender: TObject);
    procedure mnuAddNewSourceClick(Sender: TObject);
    procedure DeleteSourceClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EnableSourceClick(Sender: TObject);
    procedure ClearHistory1Click(Sender: TObject);
    procedure edtUploadPayloadKeyPress(Sender: TObject; var Key: Char);
    procedure cmbUploadCommandCloseUp(Sender: TObject);
    procedure btnSendUploadClick(Sender: TObject);
    procedure tmrUpdatedTimer(Sender: TObject);
  private
    { Private declarations }
    DisableCallsignUpdates: Boolean;
    procedure Down;
    procedure Up;
  protected
    function OKToEnableSendButton: Boolean; virtual;
    procedure SendUploadCommand; virtual;
    function BuildUplinkCommand: String;
  public
    { Public declarations }
    SourceIndex: Integer;
//    SettingsID: Integer;
    Code, Group: String;
    Enabled: Boolean;
    procedure AddPosition(Position: THABPosition); virtual;
    procedure AddStatusToLog(Status: String);
    procedure ShowSNR(Channel, SNR: Integer); virtual;
    procedure ShowCurrentRSSI(Channel, CurrentRSSI: Integer); virtual;
    procedure ShowPacketRSSI(Channel, PacketRSSI: Integer); virtual;
    procedure ShowFrequencyError(Channel: Integer; FrequencyError: Double); virtual;
    procedure ShowFrequency(Channel: Integer; Frequency: Double); virtual;
    procedure ShowSetting(Setting, Value: String); virtual;
    procedure DoAFC(Channel: Integer; FrequencyError: Double); virtual;
    procedure SetDeviceVersion(Version: Double); virtual;
    procedure SetFromCallingMode(CallingModeFrequency:   Double; CallingModeImplicit, CallingModeError, CallingModeBandwidth, CallingModeSpreading, CallingModeOptimize: Integer); virtual;
  end;


implementation

{$R *.dfm}

uses SourcesForm, Misc;

procedure TfrmSource.btnDownClick(Sender: TObject);
begin
    Down;
end;

procedure TfrmSource.btnSendUploadClick(Sender: TObject);
begin
    SendUploadCommand;
end;

procedure TfrmSource.btnSettingsClick(Sender: TObject);
var
    pnt: TPoint;
begin
    if GetCursorPos(pnt) then begin
        EnableSource.Checked := frmSources.SourceIsEnabled(SourceIndex);

        menuSource.Popup(pnt.X, pnt.Y);
    end;
end;

procedure TfrmSource.btnUpClick(Sender: TObject);
begin
    Up;
end;

procedure TfrmSource.ClearHistory1Click(Sender: TObject);
begin
    with tblPositions do begin
        while RecordCount > 0 do begin
            Delete;
        end;
    end;
end;

procedure TfrmSource.cmbUploadCommandCloseUp(Sender: TObject);
begin
    btnSendUpload.Enabled := OKToEnableSendButton;
end;

procedure TfrmSource.DeleteSourceClick(Sender: TObject);
begin
    frmSources.DeleteSource(SourceIndex);
end;

procedure TfrmSource.FormCreate(Sender: TObject);
begin
    Up;
end;

procedure TfrmSource.mnuAddNewSourceClick(Sender: TObject);
begin
    frmSources.AddNewSource;
end;

procedure TfrmSource.ModifySourceClick(Sender: TObject);
begin
    frmSources.ModifySource(SourceIndex);
end;

procedure TfrmSource.Down;
begin
    pnlMain.Height := Round(350 * ScaleFactor);
    btnDown.Visible := False;
    btnUp.Visible := True;
end;

procedure TfrmSource.edtUploadPayloadKeyPress(Sender: TObject; var Key: Char);
begin
    DisableCallsignUpdates := True;

    btnSendUpload.Enabled := OKToEnableSendButton;
end;

procedure TfrmSource.EnableSourceClick(Sender: TObject);
begin
    frmSources.EnableSource(SourceIndex, EnableSource.Checked);
end;

procedure TfrmSource.Up;
begin
    pnlMain.Height := pnlTop.Top + pnlTop.Height + pnlTop.Margins.Top + 1;
    btnUp.Visible := False;
    btnDown.Visible := True;
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

    if not DisableCallsignUpdates then begin
        edtUploadPayload.Text := Position.PayloadID;
        btnSendUpload.Enabled := OKToEnableSendButton;
    end;

    WriteToLogFile('SOURCES', Code, Position.Line, ',');


    pnlUpdated.Color := clLime;
    tmrUpdated.Enabled := True;
end;

procedure TfrmSource.ShowSNR(Channel, SNR: Integer);
begin
    // virtual
end;

procedure TfrmSource.ShowCurrentRSSI(Channel, CurrentRSSI: Integer);
begin
    // virtual
end;

procedure TfrmSource.ShowPacketRSSI(Channel, PacketRSSI: Integer);
begin
    // virtual
end;

procedure TfrmSource.ShowFrequencyError(Channel: Integer; FrequencyError: Double);
begin
    // virtual
end;

procedure TfrmSource.ShowFrequency(Channel: Integer; Frequency: Double);
begin
    // virtual
end;

procedure TfrmSource.ShowSetting(Setting, Value: String);
begin
    // virtual
end;

procedure TfrmSource.tmrUpdatedTimer(Sender: TObject);
begin
    tmrUpdated.Enabled := False;
    pnlUpdated.Color := clSilver;
end;

procedure TfrmSource.AddStatusToLog(Status: String);
begin
    with lstLog do begin
        if Items.Count > 30 then begin
            Items.Delete(30);
        end;

        Items.Insert(0, Status);
        ItemIndex := 0;
    end;
end;

procedure TfrmSource.DoAFC(Channel: Integer; FrequencyError: Double);
begin
    // virtual
end;

function TfrmSource.OKToEnableSendButton: Boolean;
begin
    Result := (edtUploadPayload.Text <> '');    // and (cmbUploadCommand.ItemIndex >= 0);
end;

function TfrmSource.BuildUplinkCommand: String;
begin
    if PageControl2.ActivePage = tabCutdown then begin
        Result := 'C';
        if chkCutdownAltitude.Checked then begin
            Result := Result + 'A' + IntToStr(StrToIntDef(edtAltitude.Text, 0));
        end else begin
            Result := Result + 'N' + IntToStr(StrToIntDef(edtCutdownPeriod.Text, 0));
        end;
    end else if PageControl2.ActivePage = tabOutput then begin
        Result := 'P' + IntToStr(StrToIntDef(edtPin.Text, 0)) + ',' +
                        IntToStr(StrToIntDef(edtPinPeriod.Text, 0))
    end else if PageControl2.ActivePage = tabServo then begin
        Result := 'S' + IntToStr(StrToIntDef(edtServoPin.Text, 0)) + ',' +
                        IntToStr(StrToIntDef(edtServoPeriod.Text, 0)) + ',' +
                        IntToStr(StrToIntDef(edtServoPosition.Text, 0));
    end else begin
        Result := 'R' + edtScriptName.Text + ',' + edtScriptParameters.Text;
    end;

    Result := edtUploadPayload.Text + '/' + Result;
end;

procedure TfrmSource.SendUploadCommand;
begin
    // virtual
end;

procedure TfrmSource.SetDeviceVersion(Version: Double);
begin
    // virtual
end;

procedure TfrmSource.SetFromCallingMode(CallingModeFrequency:   Double; CallingModeImplicit, CallingModeError, CallingModeBandwidth, CallingModeSpreading, CallingModeOptimize: Integer);
begin
    // virtual
end;

end.
