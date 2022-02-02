unit Map;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls,
  VCL.TMSFNCMaps,
  Vcl.ExtCtrls, Miscellaneous, Source, Misc;

type
  TFollowMode = (fmInit, fmNone, fmCar, fmPayload);

type
  TBalloon = record
      InUse:            Boolean;

      FNCMarker:        TTMSFNCMapsMarker;

      MarkerName:       String;

      FNCLanding:       TTMSFNCMapsMarker;

      FNCRadial:        TTMSFNCMapsPolyline;

      FNCTrack:         TTMSFNCMapsPolyline;

      FNCPrediction:    TTMSFNCMapsPolyline;

      FNCHorizon:       Array[0..1] of TTMSFNCMapsCircle;
      Position:         THABPosition;
  end;

type
  TfrmMap = class(TfrmNormal)
    procedure FormCreate(Sender: TObject);
    procedure GMapMarkerClick(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double; Button: TMouseButton);
  private
    { Private declarations }
    // MarkerNames: array[0..64] of String;
    // PolylineItems: array[0..64] of TPolylineItem;
    FollowMode: TFollowMode;
    // function FindMapMarker(PayloadID: String): Integer;
    procedure DrawBalloonRadials;
  protected
    ImageFolder: String;
    Balloons: Array[1..MAX_PAYLOADS] of TBalloon;
    FNCMastMarker: TTMSFNCMapsMarker;
    procedure DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor); virtual;
    procedure CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); virtual;
    procedure UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); virtual;
    procedure SetMapHomePosition; virtual;
    procedure DrawRadial(PayloadIndex: Integer; NewHome: Boolean); virtual;
    procedure DrawHorizon(PayloadIndex: Integer); virtual;
    procedure RemoveMapPayload(PayloadIndex: Integer); virtual;
    procedure AddOrUpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); virtual;
    function BalloonIconName(Position: THABPosition; ColourText: String; Target: Boolean=False): String;
  public
    { Public declarations }
    function ProcessNewPosition(PayloadIndex: Integer; Position: THABPosition; Colour: TColor; ColourText: String): Boolean;
    procedure SetHomePosition;
    procedure RemovePayload(PayloadIndex: Integer);
    procedure CentrePayloadOnMap(PayloadIndex: Integer); virtual;
    procedure SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); virtual;
    procedure ClearPredictionPath(PayloadIndex: Integer; Colour: TColor); virtual;
    procedure AppendToPredictionPath(PayloadIndex: Integer; PredictedLatitude, PredictedLongitude, PredictedAltitude: Double); virtual;
  end;

var
  frmMap: TfrmMap;

implementation

{$R *.dfm}

uses Data, BaseTypes, Payloads;


procedure TfrmMap.FormCreate(Sender: TObject);
var
    Path: String;
begin
    FollowMode := fmInit;

    if GetCommandLineParameter('PATH', Path) then begin
        ImageFolder := Path + '\Images\';
    end else begin
        ImageFolder := ExtractFilePath(Application.ExeName) + 'Images\';
    end;

    SetHomePosition;
end;

procedure TfrmMap.DrawBalloonRadials;
var
    PayloadIndex: Integer;
begin
    for PayloadIndex := Low(Balloons) to High(Balloons) do begin
        if Balloons[PayloadIndex].InUse then begin
            DrawRadial(PayloadIndex, True);
        end;
    end;
end;

procedure TfrmMap.GMapMarkerClick(Sender: TObject; MarkerTitle: string;
  IdMarker: Integer; Latitude, Longitude: Double; Button: TMouseButton);
begin
    frmPayloads.HighlightPayload(MarkerTitle, True, False);
end;

function TfrmMap.BalloonIconName(Position: THABPosition; ColourText: String; Target: Boolean=False): String;
begin
    Result := 'balloon-' + ColourText;

//    if Target then begin
//        Result := 'x-' + BalloonColour;
//    end else begin
        case Position.FlightMode of
            fmIdle:         Result := 'balloon-' + ColourText;
            fmLaunched:     Result := 'balloon-' + ColourText;
            fmDescending:   Result := 'parachute-' + ColourText;
            fmLanded:       Result := 'payload-' + ColourText;
        end;
//    end;
end;


function TfrmMap.ProcessNewPosition(PayloadIndex: Integer; Position: THABPosition; Colour: TColor; ColourText: String): Boolean;
begin
    Result := False;

    if (Position.Latitude <> 0) and (Position.Longitude <> 0) then begin
        Balloons[PayloadIndex].Position := Position;

        // Find or create marker for this payload
        AddOrUpdateMapMarker(PayloadIndex, Position, ColourText);

        // Line to Balloon
        DrawRadial(PayloadIndex, False);

        // Reception horizon
        DrawHorizon(PayloadIndex);

        // Balloon Path
        DrawPath(PayloadIndex, Position, Colour);

        // Pan to balloon
//        if (FollowMode = fmPayload) and (Index = SelectedIndex) then begin
//            GMap.MapPanTo(Positions[Index].Position.Latitude, Positions[Index].Position.Longitude);
//        end;

        Result := True;
    end;
end;

procedure TfrmMap.AddOrUpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
begin
    if not Balloons[PayloadIndex].InUse then begin
        Balloons[PayloadIndex].InUse := True;

        CreateMarker(PayloadIndex, Position, ColourText);
    end else if Balloons[PayloadIndex].FNCMarker <> nil then begin
        Balloons[PayloadIndex].FNCMarker.Latitude := Position.Latitude;
        Balloons[PayloadIndex].FNCMarker.Longitude := Position.Longitude;
    end;

    if Position.ContainsPrediction then begin
        SetLandingMarker(PayloadIndex, Position, ColourText);
    end;

    UpdateMapMarker(PayloadIndex, Position, ColourText);
end;

procedure TfrmMap.SetHomePosition;
begin
    if (not DataModule1.tblSettings.FieldByName('Latitude').IsNull) and (not DataModule1.tblSettings.FieldByName('Longitude').IsNull) then begin
        SetMapHomePosition;

        DrawBalloonRadials;
    end;
end;

procedure TfrmMap.RemovePayload(PayloadIndex: Integer);
begin
    with Balloons[PayloadIndex] do begin
        InUse := False;

        RemoveMapPayload(PayloadIndex);
    end;
end;

//function TfrmMap.FindMapMarker(PayloadID: String): Integer;
//var
//    i: Integer;
//begin
//    for i := 0 to GMap.Markers.Count-1 do begin
//        if GMap.Markers[i].Title = PayloadID then begin
//            // Found it
//            Result := i;
//            Exit;
//        end;
//    end;
//
//    Result := -1;
//end;


procedure TfrmMap.DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor);
begin
    // inherited
end;

procedure TfrmMap.CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
begin
    // inherited
end;

procedure TfrmMap.SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
begin
    // virtual
end;

procedure TfrmMap.SetMapHomePosition;
begin
    // virtual
end;

procedure TfrmMap.DrawRadial(PayloadIndex: Integer; NewHome: Boolean);
begin
    // virtual
end;

procedure TfrmMap.DrawHorizon(PayloadIndex: Integer);
begin
    // virtual
end;

procedure TfrmMap.RemoveMapPayload(PayloadIndex: Integer);
begin
    // virtual
end;

procedure TfrmMap.CentrePayloadOnMap(PayloadIndex: Integer);
begin
    // virtual
end;

procedure TfrmMap.UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
begin
    // virtual
end;

procedure TfrmMap.ClearPredictionPath(PayloadIndex: Integer; Colour: TColor);
begin
    // virtual
end;

procedure TfrmMap.AppendToPredictionPath(PayloadIndex: Integer; PredictedLatitude, PredictedLongitude, PredictedAltitude: Double);
begin
    // virtual
end;

end.
