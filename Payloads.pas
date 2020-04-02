unit Payloads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Payload,
  Source;

type
    TPayload = record
        InUse:              Boolean;
        Position:           THABPosition;
//        Button:             TAdvSmoothButton;
//        PayloadID:      String;
        Form:           TfrmPayload;
//        // Indicator:      TAdvSmoothStatusIndicator;
//        Position:       THABPosition;
//        GotGPS:         Boolean;
//        Count:          Integer;
//        AscentRate:     Double;
        BalloonColour:      String;
        Sources:            String;
//        FlightMode:     TFlightMode;
        LastUpdate:     TDateTime;
    end;

  TfrmPayloads = class(TfrmNormal)
    scrollMain: TScrollBox;
    tmrUpdates: TTimer;
    procedure tmrUpdatesTimer(Sender: TObject);
  private
    { Private declarations }
    HABPayloads: Array[1..32] of TPayload;
    function AddOrUpdatePayloadInOurList(Position: THABPosition; SourceCode: String; var PositionIsNew: Boolean): Integer;
    function FindOrAddPayload(PayloadID: String): Integer;
    function PositionHasChanged(NewPosition, OldPosition: THABPosition): Boolean;
  public
    { Public declarations }
    function NewPosition(Position: THABPosition; SourceCode, SourceDescription: String): Boolean;
  end;

var
  frmPayloads: TfrmPayloads;

implementation

{$R *.dfm}

uses Main, Data, ToolLog, Map;

function TfrmPayloads.NewPosition(Position: THABPosition; SourceCode, SourceDescription: String): Boolean;
var
    PayloadIndex: Integer;
    PositionIsNew: Boolean;
begin
    PositionIsNew := False;
    DataModule1.AddPayloadToFullTable(Position);

    if frmMain.PayloadInWhiteList(Position) then begin
        if DataModule1.AddPayloadToLiveTable(Position) then begin
            // New payload
            frmToolLog.AddToLog('Added Payload ' + Position.PayloadID + ', Rx by ' + SourceCode + ' (' + SourceDescription + ')');
        end;

        PayloadIndex := AddOrUpdatePayloadInOurList(Position, SourceCode, PositionIsNew);

        if PayloadIndex > 0 then begin
            // Update Map
            frmMap.ProcessNewPosition(Position, HABPayloads[PayloadIndex].BalloonColour);
        end;
    end;

    Result := PositionIsNew;
end;

function TfrmPayloads.AddOrUpdatePayloadInOurList(Position: THABPosition; SourceCode: String; var PositionIsNew: Boolean): Integer;
const
    ColourTexts: Array[0..3] of String = ('blue', 'red', 'green', 'yellow');
    BGColours: Array[0..3] of TColor = (clBlue, clRed, clGreen, clYellow);
    FGColours: Array[0..3] of TColor = (clWhite, clBlack, clWhite, clBlack);
var
    PayloadIndex: Integer;
begin
    PositionIsNew := False;
    PayloadIndex := FindOrAddPayload(Position.PayloadID);

    if PayloadIndex > 0 then begin
        // Found, or appeneed
        if not HABPayloads[PayloadIndex].InUse then begin
            // Appeneded, so fill in basic details
            HABPayloads[PayloadIndex].InUse := True;
            HABPayloads[PayloadIndex].BalloonColour := ColourTexts[(PayloadIndex-1) mod (High(BGColours)+1)];

            // Add form
            HABPayloads[PayloadIndex].Form := TfrmPayload.Create(nil);
            HABPayloads[PayloadIndex].Form.pnlMain.Parent := pnlMain;
            HABPayloads[PayloadIndex].Form.pnlTitle.Caption := Position.PayloadID + ' (00:00)';
            HABPayloads[PayloadIndex].Form.pnlTitle.Color := BGColours[(PayloadIndex-1) mod (High(BGColours)+1)];
            HABPayloads[PayloadIndex].Form.pnlTitle.Font.Color := FGColours[(PayloadIndex-1) mod (High(FGColours)+1)];
        end;

        // New position ?
        if PositionHasChanged(Position, HABPayloads[PayloadIndex].Position) then begin
            PositionIsNew := True;

            HABPayloads[PayloadIndex].Sources := SourceCode;
            // Store latest position

            HABPayloads[PayloadIndex].Position := Position;

            HABPayloads[PayloadIndex].LastUpdate := Now;

            // Add to history
            HABPayloads[PayloadIndex].Form.AddPosition(Position, SourceCode);
        end else begin
            if Pos(',' + SourceCode + ',', ',' + HABPayloads[PayloadIndex].Sources + ',') = 0 then begin
                if HABPayloads[PayloadIndex].Sources = '' then begin
                    HABPayloads[PayloadIndex].Sources := SourceCode;
                end else begin
                    HABPayloads[PayloadIndex].Sources := HABPayloads[PayloadIndex].Sources + ',' + SourceCode;
                end;

                HABPayloads[PayloadIndex].Form.UpdatePosition(Position, HABPayloads[PayloadIndex].Sources);
            end;
        end;
    end;

    Result := PayloadIndex;
end;

function TfrmPayloads.PositionHasChanged(NewPosition, OldPosition: THABPosition): Boolean;
begin
    if NewPosition.ReceivedRemotely then begin
        Result := // (NewPosition.Counter > OldPosition.Counter) or
                  (NewPosition.TimeStamp > OldPosition.TimeStamp);
    end else begin
        Result := (NewPosition.Counter <> OldPosition.Counter) or
                  (NewPosition.TimeStamp <> OldPosition.TimeStamp);
    end;
end;

procedure TfrmPayloads.tmrUpdatesTimer(Sender: TObject);
var
    i: Integer;
begin
    for i := Low(HABPayloads) to High(HABPayloads) do begin
        if HABPayloads[i].InUse and (HABPayloads[i].Form <> nil) then begin
            HABPayloads[i].Form.pnlTitle.Caption := HABPayloads[i].Position.PayloadID + ' (' + FormatDateTime('nn:ss', Now - HABPayloads[i].LastUpdate) + ')';
        end;
    end;
end;

function TfrmPayloads.FindOrAddPayload(PayloadID: String): Integer;
var
    i: Integer;
begin
    for i := Low(HABPayloads) to High(HABPayloads) do begin
        if HABPayloads[i].InUse then begin
            if HABPayloads[i].Position.PayloadID = PayloadID then begin
                Result := i;
                Exit;
            end;
        end;
    end;

    // Add new one
    for i := Low(HABPayloads) to High(HABPayloads) do begin
        if not HABPayloads[i].InUse then begin
            Result := i;
            Exit;
        end;
    end;

    Result := 0;
end;


end.
