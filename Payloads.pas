unit Payloads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls, Vcl.ExtCtrls,
  AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, Payload,
  Miscellaneous, Source, Math;

type
    TPayload = record
        InUse:              Boolean;
        Position:           THABPosition;
        PreviousPosition:   THABPosition;
        Form:               TfrmPayload;
        ColourText:         String;
        Colour:             TColor;
        Sources:            String;
        LastUpdate:         TDateTime;
//        Button:             TAdvSmoothButton;
//        PayloadID:      String;
//        // Indicator:      TAdvSmoothStatusIndicator;
//        Position:       THABPosition;
//        GotGPS:         Boolean;
//        Count:          Integer;
    end;

  TfrmPayloads = class(TfrmNormal)
    scrollMain: TScrollBox;
    tmrUpdates: TTimer;
    tmrExpired: TTimer;
    procedure tmrUpdatesTimer(Sender: TObject);
    procedure tmrExpiredTimer(Sender: TObject);
  private
    { Private declarations }
    HABPayloads: Array[1..32] of TPayload;
    function AddOrUpdatePayloadInOurList(Position: THABPosition; SourceCode: String; var PositionIsNew: Boolean): Integer;
    function FindPayload(PayloadID: String): Integer;
    function FindOrAddPayload(PayloadID: String): Integer;
    function PositionHasChanged(NewPosition, OldPosition: THABPosition): Boolean;
  public
    { Public declarations }
    function NewPosition(Position: THABPosition; SourceCode, SourceDescription: String): Boolean;
    procedure UpdateActivePayloads;
    procedure ShowPacketRSSI(PayloadID: String; PacketRSSI: Integer);
    procedure ShowCurrentRSSI(PayloadID: String; CurrentRSSI: Integer);
    procedure ShowFrequencyError(PayloadID: String; FrequencyError: Double);
    procedure CheckForExpiredPayloads;
    procedure HighlightPayload(PayloadID: String);
  end;

var
  frmPayloads: TfrmPayloads;

implementation

{$R *.dfm}

uses Main, Data, ToolLog, Map, BaseTypes;

function TfrmPayloads.NewPosition(Position: THABPosition; SourceCode, SourceDescription: String): Boolean;
var
    PayloadIndex: Integer;
    PositionIsNew: Boolean;
begin
    PositionIsNew := False;
    DataModule1.AddPayloadToFullTable(Position);

    if frmMain.PayloadInWhiteList(Position) then begin
        if DataModule1.AddPayloadToLiveTable(Position) and (frmToolLog <> nil) then begin
            // New payload
            frmToolLog.AddToLog('Added Payload ' + Position.PayloadID + ', Rx by ' + SourceCode + ' (' + SourceDescription + ')');
        end;

        PayloadIndex := AddOrUpdatePayloadInOurList(Position, SourceCode, PositionIsNew);

        if PayloadIndex > 0 then begin
            // Update Map
            frmMap.ProcessNewPosition(PayloadIndex, HABPayloads[PayloadIndex].Position, HABPayloads[PayloadIndex].Colour, HABPayloads[PayloadIndex].ColourText);
        end;
    end;

    Result := PositionIsNew;
end;

function TfrmPayloads.AddOrUpdatePayloadInOurList(Position: THABPosition; SourceCode: String; var PositionIsNew: Boolean): Integer;
const
    BGColours: Array[0..3] of TColor = (clBlue, clRed, clGreen, clYellow);
    FGColours: Array[0..3] of TColor = (clWhite, clBlack, clWhite, clBlack);
    ColourTexts: Array[0..3] of String = ('blue', 'red', 'green', 'yellow');
var
    PayloadIndex, ColourIndex: Integer;
begin
    PositionIsNew := False;
    PayloadIndex := FindOrAddPayload(Position.PayloadID);

    if PayloadIndex > 0 then begin
        // Found, or appended
        if not HABPayloads[PayloadIndex].InUse then begin
            // Appended, so fill in basic details
            HABPayloads[PayloadIndex].InUse := True;
            ColourIndex := (PayloadIndex-1) mod (High(BGColours)+1);
            HABPayloads[PayloadIndex].Colour := BGColours[ColourIndex];
            HABPayloads[PayloadIndex].ColourText := ColourTexts[ColourIndex];

            // Add form
            HABPayloads[PayloadIndex].Form := TfrmPayload.Create(nil);
            HABPayloads[PayloadIndex].Form.pnlMain.Parent := scrollMain;    // pnlMain;
            HABPayloads[PayloadIndex].Form.pnlTitle.Caption := Position.PayloadID + ' (00:00)';
            HABPayloads[PayloadIndex].Form.pnlTitle.Color := BGColours[(PayloadIndex-1) mod (High(BGColours)+1)];
            HABPayloads[PayloadIndex].Form.pnlTitle.Font.Color := FGColours[(PayloadIndex-1) mod (High(FGColours)+1)];
        end;

        // New position ?
        if PositionHasChanged(Position, HABPayloads[PayloadIndex].Position) then begin
            PositionIsNew := True;

            HABPayloads[PayloadIndex].Sources := SourceCode;
            // Store latest position

            DoPositionCalculations(HABPayloads[PayloadIndex].Position, Position);

            HABPayloads[PayloadIndex].PreviousPosition := HABPayloads[PayloadIndex].Position;
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

                HABPayloads[PayloadIndex].Form.UpdateSources(Position, HABPayloads[PayloadIndex].Sources);
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

procedure TfrmPayloads.tmrExpiredTimer(Sender: TObject);
begin
    CheckForExpiredPayloads;
end;

procedure TfrmPayloads.tmrUpdatesTimer(Sender: TObject);
var
    PayloadIndex: Integer;
begin
    for PayloadIndex := Low(HABPayloads) to High(HABPayloads) do begin
        if HABPayloads[PayloadIndex].InUse and (HABPayloads[PayloadIndex].Form <> nil) then begin
            HABPayloads[PayloadIndex].Form.pnlTitle.Caption := HABPayloads[PayloadIndex].Position.PayloadID + ' (' + FormatDateTime('nn:ss', Now - HABPayloads[PayloadIndex].LastUpdate) + ')';
        end;
    end;
end;

function TfrmPayloads.FindOrAddPayload(PayloadID: String): Integer;
var
    PayloadIndex: Integer;
begin
    PayloadIndex := FindPayload(PayloadID);

    if PayloadIndex = 0 then begin
        // Add new one
        for PayloadIndex := Low(HABPayloads) to High(HABPayloads) do begin
            if not HABPayloads[PayloadIndex].InUse then begin
                Result := PayloadIndex;
                Exit;
            end;
        end;
    end;

    Result := PayloadIndex;
end;

function TfrmPayloads.FindPayload(PayloadID: String): Integer;
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

    Result := 0;
end;

procedure TfrmPayloads.UpdateActivePayloads;
var
    PayloadIndex: Integer;
    Position: THABPosition;
    PositionIsNew: Boolean;
begin
    // Update masks from table
    frmMain.LoadPayloadMasks;

    // Test currently active payloads to see if any need removing
    for PayloadIndex := Low(HABPayloads) to High(HABPayloads) do begin
        if HABPayloads[PayloadIndex].InUse then begin
            // Calculate distance
            if (not DataModule1.tblSettings.FieldByName('Latitude').IsNull) and (not DataModule1.tblSettings.FieldByName('Longitude').IsNull) then begin
                HABPayloads[PayloadIndex].Position.Distance := CalculateDistance(HABPayloads[PayloadIndex].Position.Latitude,
                                                                                 HABPayloads[PayloadIndex].Position.Longitude,
                                                                                 DataModule1.tblSettings.FieldByName('Latitude').Asfloat,
                                                                                 DataModule1.tblSettings.FieldByName('Longitude').AsFloat) / 1000.0;
                if not frmMain.PayloadInWhiteList(HABPayloads[PayloadIndex].Position) then begin
                    // Remove it
                    HABPayloads[PayloadIndex].InUse := False;
                    HABPayloads[PayloadIndex].Form.Free;
                    frmMap.RemovePayload(PayloadIndex);
                end;
            end;
        end;
    end;

    // Now cycle through all the payloads we've received
    with DataModule1.tblAllPayloads, Position do begin
        First;
        while not EOF do begin
            PayloadID := FieldByName('PayloadID').AsString;
            Counter := FieldByName('Counter').AsInteger;
            TimeStamp := FieldByName('TimeStamp').AsDateTime;
            Latitude := FieldByName('Latitude').AsFloat;
            Longitude := FieldByName('Longitude').AsFloat;
            Altitude := FieldByName('Altitude').AsFloat;
            ReceivedRemotely := not FieldByName('ReceivedLocally').AsBoolean;

            Distance := CalculateDistance(Latitude,
                                          Longitude,
                                          DataModule1.tblSettings.FieldByName('Latitude').Asfloat,
                                          DataModule1.tblSettings.FieldByName('Longitude').AsFloat) / 1000.0;

            if frmMain.PayloadInWhiteList(Position) then begin
                if DataModule1.AddPayloadToLiveTable(Position) then begin
                    // New payload
                    frmToolLog.AddToLog('Added Payload ' + Position.PayloadID + ', from history');

                    PayloadIndex := AddOrUpdatePayloadInOurList(Position, '', PositionIsNew);

                    if PayloadIndex > 0 then begin
                        // Update Map
                        frmMap.ProcessNewPosition(PayloadIndex, HABPayloads[PayloadIndex].Position, HABPayloads[PayloadIndex].Colour, HABPayloads[PayloadIndex].ColourText);
                    end;
                end;
            end;
            Next;
        end;
    end;
end;

procedure TfrmPayloads.ShowPacketRSSI(PayloadID: String; PacketRSSI: Integer);
var
    PayloadIndex: Integer;
begin
    PayloadIndex := FindPayload(PayloadID);

    if PayloadIndex > 0 then begin
        HABPayloads[PayloadIndex].Form.ShowPacketRSSI(PacketRSSI);
    end;
end;

procedure TfrmPayloads.ShowCurrentRSSI(PayloadID: String; CurrentRSSI: Integer);
var
    PayloadIndex: Integer;
begin
    PayloadIndex := FindPayload(PayloadID);

    if PayloadIndex > 0 then begin
        HABPayloads[PayloadIndex].Form.ShowCurrentRSSI(CurrentRSSI);
    end;
end;

procedure TfrmPayloads.ShowFrequencyError(PayloadID: String; FrequencyError: Double);
var
    PayloadIndex: Integer;
begin
    PayloadIndex := FindPayload(PayloadID);

    if PayloadIndex > 0 then begin
        HABPayloads[PayloadIndex].Form.ShowFrequencyError(FrequencyError);
    end;
end;

procedure TfrmPayloads.CheckForExpiredPayloads;
var
    PayloadIndex: Integer;
    MustHaveUpdatedSince: TDateTime;
begin
    MustHaveUpdatedSince := Now - DataModule1.tblSettings.FieldByName('Expiry').AsInteger * 60 / 86400;

    for PayloadIndex := Low(HABPayloads) to High(HABPayloads) do begin
        if HABPayloads[PayloadIndex].InUse then begin
            if HABPayloads[PayloadIndex].LastUpdate < MustHaveUpdatedSince then begin
                HABPayloads[PayloadIndex].InUse := False;
                HABPayloads[PayloadIndex].Form.Free;
                frmMap.RemovePayload(PayloadIndex);
            end;
        end;
    end;
end;

procedure TfrmPayloads.HighlightPayload(PayloadID: String);
var
    SelectedPayload, PayloadIndex: Integer;
begin
    SelectedPayload := FindPayload(PayloadID);
    if SelectedPayload > 0 then begin
        for PayloadIndex := Low(HABPayloads) to High(HABPayloads) do begin
            if HABPayloads[PayloadIndex].InUse and (HABPayloads[PayloadIndex].Form <> nil) then begin
                HABPayloads[PayloadIndex].Form.ShowDetails(PayloadIndex = SelectedPayload);
            end;
        end;
    end;
end;

end.
