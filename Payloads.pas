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
//        LastUpdate:     TDateTime;
    end;

  TfrmPayloads = class(TfrmNormal)
    scrollMain: TScrollBox;
  private
    { Private declarations }
    HABPayloads: Array[1..32] of TPayload;
    function AddOrUpdatePayloadInOurList(Position: THABPosition; SourceCode: String): Integer;
    function FindOrAddPayload(PayloadID: String): Integer;
    function PositionHasChanged(Position1, Position2: THABPosition): Boolean;
  public
    { Public declarations }
    procedure NewPosition(Position: THABPosition; SourceCode, SourceDescription: String);
  end;

var
  frmPayloads: TfrmPayloads;

implementation

{$R *.dfm}

uses Main, Data, ToolLog, Map;

procedure TfrmPayloads.NewPosition(Position: THABPosition; SourceCode, SourceDescription: String);
var
    PayloadIndex: Integer;
begin
    DataModule1.AddPayloadToFullTable(Position);

    if frmMain.PayloadInWhiteList(Position) then begin
        if DataModule1.AddPayloadToLiveTable(Position) then begin
            // New payload
            frmToolLog.AddToLog('Added Payload ' + Position.PayloadID + ', Rx by ' + SourceCode + ' (' + SourceDescription + ')');
        end;

        PayloadIndex := AddOrUpdatePayloadInOurList(Position, SourceCode);

        if PayloadIndex > 0 then begin
            // Update Map
            frmMap.ProcessNewPosition(Position, HABPayloads[PayloadIndex].BalloonColour);
        end;
    end;
end;

function TfrmPayloads.AddOrUpdatePayloadInOurList(Position: THABPosition; SourceCode: String): Integer;
const
    ColourTexts: Array[0..3] of String = ('blue', 'red', 'green', 'yellow');
    BGColours: Array[0..3] of TColor = (clBlue, clRed, clGreen, clYellow);
    FGColours: Array[0..3] of TColor = (clWhite, clBlack, clWhite, clBlack);
var
    PayloadIndex: Integer;
begin
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
            HABPayloads[PayloadIndex].Form.pnlTitle.Caption := Position.PayloadID;
            HABPayloads[PayloadIndex].Form.pnlTitle.Color := BGColours[(PayloadIndex-1) mod (High(BGColours)+1)];
            HABPayloads[PayloadIndex].Form.pnlTitle.Font.Color := FGColours[(PayloadIndex-1) mod (High(FGColours)+1)];
        end;

        // New position ?
        if PositionHasChanged(Position, HABPayloads[PayloadIndex].Position) then begin

            HABPayloads[PayloadIndex].Sources := SourceCode;
            // Store latest position

            HABPayloads[PayloadIndex].Position := Position;

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

function TfrmPayloads.PositionHasChanged(Position1, Position2: THABPosition): Boolean;
begin
    Result := (Position1.Counter <> Position2.Counter) or
              (Position1.TimeStamp <> Position2.TimeStamp);
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
