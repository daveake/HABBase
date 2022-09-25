unit Map;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls,
  VCL.TMSFNCMaps,
  Vcl.ExtCtrls, Miscellaneous, Source, Misc, VCL.TMSFNCTypes,
  VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCMapsCommonTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser;

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
    FNCMap: TTMSFNCMaps;
    tmrCentreAtHome: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure GMapMarkerClick(Sender: TObject; MarkerTitle: string;
      IdMarker: Integer; Latitude, Longitude: Double; Button: TMouseButton);
    procedure FNCMapMapInitialized(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrCentreAtHomeTimer(Sender: TObject);
  private
    { Private declarations }
    NeedToHome, CanHome: Boolean;
    // MarkerNames: array[0..64] of String;
    // PolylineItems: array[0..64] of TPolylineItem;
    FollowMode: TFollowMode;
    // function FindMapMarker(PayloadID: String): Integer;
    procedure DrawBalloonRadials;
  protected
    ImageFolder: String;
    Balloons: Array[1..MAX_PAYLOADS] of TBalloon;
    FNCMastMarker: TTMSFNCMapsMarker;
    procedure DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor);
    procedure CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
    procedure UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
    procedure SetMapHomePosition;
    procedure DrawRadial(PayloadIndex: Integer; NewHome: Boolean);
    procedure DrawHorizon(PayloadIndex: Integer);
    procedure RemoveMapPayload(PayloadIndex: Integer);
    procedure AddOrUpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); virtual;
    function BalloonIconName(Position: THABPosition; ColourText: String; Target: Boolean=False): String;
  public
    { Public declarations }
    function ProcessNewPosition(PayloadIndex: Integer; Position: THABPosition; Colour: TColor; ColourText: String): Boolean;
    procedure SetHomePosition;
    procedure RemovePayload(PayloadIndex: Integer);
    procedure CentrePayloadOnMap(PayloadIndex: Integer);
    procedure SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
    procedure ClearPredictionPath(PayloadIndex: Integer; Colour: TColor); virtual;
    procedure AppendToPredictionPath(PayloadIndex: Integer; PredictedLatitude, PredictedLongitude, PredictedAltitude: Double); virtual;
    procedure SetMapSource(Source: String);
  end;

var
  frmMap: TfrmMap;

implementation

{$R *.dfm}

uses Data, BaseTypes, Payloads;

// IF THE FOLLOWING LINE GIVES AN ERROR

{$INCLUDE 'key.pas'}

(* THEN CREATE A FILE key.pas CONTAINING:

const GoogleMapsAPIKey = '<YOUR_GOOGLE_MAPS_API_KEY>';
const BingMapsAPIKey = '<YOUR_BING_MAPS_API_KEY>';
const TomTomMapsAPIKey = '<YOUR_TOMTOM_MAPS_API_KEY>';

*)
// THE key.pas FILE IS SPECIFICALLY EXCLUDED in .gitignore TO AVOID SHARING API KEYS


procedure TfrmMap.FNCMapMapInitialized(Sender: TObject);
begin
    CanHome := True;
end;

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

    SetMapSource('GOOGLE');
end;

procedure TfrmMap.FormShow(Sender: TObject);
begin
    tmrCentreAtHome.Enabled := True;
end;

procedure TfrmMap.SetMapHomePosition;
var
    FileName: String;
    PayloadIndex: Integer;
begin
    if FNCMastMarker = nil then begin
        FNCMastMarker := FNCMap.Markers.Add;
        FNCMastMarker.Latitude := DataModule1.tblSettings.FieldByName('Latitude').Asfloat;
        FNCMastMarker.Longitude := DataModule1.tblSettings.FieldByName('Longitude').Asfloat;
        FNCMastMarker.Title := 'Home';

        FileName := ImageFolder + 'mast.png';
        if FileExists(FileName) then begin
            FNCMastMarker.IconURL := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
        end;
    end else begin
        FNCMastMarker.Latitude := DataModule1.tblSettings.FieldByName('Latitude').Asfloat;
        FNCMastMarker.Longitude := DataModule1.tblSettings.FieldByName('Longitude').Asfloat;
    end;

    NeedToHome := True;
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
    if Position.IsChase then begin
        Result := 'car-' + ColourText;
    end else begin
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
    end;
end;


function TfrmMap.ProcessNewPosition(PayloadIndex: Integer; Position: THABPosition; Colour: TColor; ColourText: String): Boolean;
begin
    Result := False;

    if (Position.Latitude <> 0) and (Position.Longitude <> 0) then begin
        Balloons[PayloadIndex].Position := Position;

        FNCMap.BeginUpdate;

        // Find or create marker for this payload
        AddOrUpdateMapMarker(PayloadIndex, Position, ColourText);

        if not Position.IsChase then begin
            // Line to Balloon
            DrawRadial(PayloadIndex, False);

            // Reception horizon
            DrawHorizon(PayloadIndex);
        end;

        // Path
        DrawPath(PayloadIndex, Position, Colour);

        // Pan to balloon
//        if (FollowMode = fmPayload) and (Index = SelectedIndex) then begin
//            GMap.MapPanTo(Positions[Index].Position.Latitude, Positions[Index].Position.Longitude);
//        end;

        FNCMap.EndUpdate;

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

    if Position.PredictionType <> ptNone then begin
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
    if Balloons[PayloadIndex].FNCTrack = nil then begin
        Balloons[PayloadIndex].FNCTrack := FNCMap.Polylines.Add;
        Balloons[PayloadIndex].FNCTrack.StrokeColor := Colour;
        // FNCMap.CreateMapPolyline(Balloons[PayloadIndex].FNCTrack.Polyline);
    end else begin
//        Balloons[PayloadIndex].Track.Polyline.Path.Add(Position.Latitude, Position.Longitude);
        // FNCMap.UpdateMapPolyline(Balloons[PayloadIndex].FNCTrack.Polyline);
    end;
    Balloons[PayloadIndex].FNCTrack.Visible := False;
    Balloons[PayloadIndex].FNCTrack.Coordinates.Add;
    Balloons[PayloadIndex].FNCTrack.Coordinates.Items[Balloons[PayloadIndex].FNCTrack.Coordinates.Count-1].Latitude := Position.Latitude;
    Balloons[PayloadIndex].FNCTrack.Coordinates.Items[Balloons[PayloadIndex].FNCTrack.Coordinates.Count-1].Longitude := Position.Longitude;
    Balloons[PayloadIndex].FNCTrack.Visible := True;
end;


procedure TfrmMap.CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
begin
    // inherited
    Balloons[PayloadIndex].FNCMarker := FNCMap.Markers.Add;

    Balloons[PayloadIndex].FNCMarker.Latitude := Position.Latitude;
    Balloons[PayloadIndex].FNCMarker.Longitude := Position.Longitude;
    Balloons[PayloadIndex].FNCMarker.Title := Position.PayloadID;

//    if Position.IsSonde then begin
//        Balloons[PayloadIndex].FNCMarker.MapLabel.Color := clYellow;
//    end else begin
//        Balloons[PayloadIndex].FNCMarker.MapLabel.Color := clLime;
//    end;
//
//    Balloons[PayloadIndex].FNCMarker.MapLabel.Text := Position.PayloadID;
//    Balloons[PayloadIndex].FNCMarker.MapLabel.OffsetTop := 70;
end;

procedure TfrmMap.SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
var
    FileName: String;
begin
    if Balloons[PayloadIndex].FNCLanding = nil then begin
        FileName := ImageFolder + 'x-' + ColourText + '.png';
        Balloons[PayloadIndex].FNCLanding := FNCMap.Markers.Add;
        Balloons[PayloadIndex].FNCLanding.Title := Position.PayloadID;
        Balloons[PayloadIndex].FNCLanding.IconURL := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
    end;

    Balloons[PayloadIndex].FNCLanding.Latitude := Position.PredictedLatitude;
    Balloons[PayloadIndex].FNCLanding.Longitude := Position.PredictedLongitude;
end;

procedure TfrmMap.DrawRadial(PayloadIndex: Integer; NewHome: Boolean);
begin
    if (not DataModule1.tblSettings.FieldByName('Latitude').IsNull) and (not DataModule1.tblSettings.FieldByName('Longitude').IsNull) then begin
        if Balloons[PayloadIndex].FNCRadial = nil then begin
            Balloons[PayloadIndex].FNCRadial := FNCMap.Polylines.Add;
            Balloons[PayloadIndex].FNCRadial.StrokeColor := clLime;

            // Add ends of line
            Balloons[PayloadIndex].FNCRadial.Coordinates.Add;
            Balloons[PayloadIndex].FNCRadial.Coordinates.Add;

            NewHome := True;
        end;

        if NewHome then begin
            // Start at home
            Balloons[PayloadIndex].FNCRadial.Coordinates[0].Latitude := DataModule1.tblSettings.FieldByName('Latitude').AsFloat;
            Balloons[PayloadIndex].FNCRadial.Coordinates[0].Longitude := DataModule1.tblSettings.FieldByName('Longitude').AsFloat;
        end;

        // Target at balloon
        Balloons[PayloadIndex].FNCRadial.Visible := False;
        Balloons[PayloadIndex].FNCRadial.Coordinates[1].Latitude := Balloons[PayloadIndex].Position.Latitude;
        Balloons[PayloadIndex].FNCRadial.Coordinates[1].Longitude := Balloons[PayloadIndex].Position.Longitude;
        Balloons[PayloadIndex].FNCRadial.Visible := True;
    end;
end;

procedure TfrmMap.DrawHorizon(PayloadIndex: Integer);
const
    Colors: Array[0..1] of TColor = (clBlue, clLime);
    Radius: Array[0..1] of Double = (0.0, 5.0);
var
    i: Integer;
    NewCircle: Boolean;
begin
    for i := 0 to 1 do begin
        if Balloons[PayloadIndex].FNCHorizon[i] = nil then begin
            Balloons[PayloadIndex].FNCHorizon[i] := FNCMap.Circles.Add;
            Balloons[PayloadIndex].FNCHorizon[i].StrokeColor := Colors[i];
            Balloons[PayloadIndex].FNCHorizon[i].FillOpacity := 0;
//            Balloons[PayloadIndex].FNCHorizon[i].Polygon.HoverBorderColor := Colors[i];
//            Balloons[PayloadIndex].FNCHorizon[i].Polygon.HoverBackgroundColor := clNone;
//            Balloons[PayloadIndex].FNCHorizon[i].Polygon.BackgroundOpacity := 0;
            Balloons[PayloadIndex].FNCHorizon[i].StrokeWidth := 2;
            NewCircle := True;
        end else begin;
            NewCircle := False;
        end;

        Balloons[PayloadIndex].FNCHorizon[i].Radius := Round(1000.0 * CalculateHorizonRadius(Balloons[PayloadIndex].Position.Altitude, Radius[i]));
        Balloons[PayloadIndex].FNCHorizon[i].Center.Latitude := Balloons[PayloadIndex].Position.Latitude;
        Balloons[PayloadIndex].FNCHorizon[i].Center.Longitude := Balloons[PayloadIndex].Position.Longitude;

//        if NewCircle then begin
//            GMap.CreateMapPolygon(Balloons[PayloadIndex].Horizon[i].Polygon);
//        end else begin
//            GMap.UpdateMapPolygon(Balloons[PayloadIndex].Horizon[i].Polygon);
//        end;
    end;
end;

procedure TfrmMap.RemoveMapPayload(PayloadIndex: Integer);
begin
    with Balloons[PayloadIndex] do begin
        if FNCMarker <> nil then begin
            FNCMarker.Free;
            FNCMarker := nil;
        end;

        if FNCLanding <> nil then begin
            FNCLanding.Free;
            FNCLanding := nil;
        end;

        if FNCRadial <> nil then begin
            FNCRadial.Free;
            FNCRadial := nil;
        end;
        if FNCTrack <> nil then begin
            FNCTrack.Coordinates.Clear;
        end;
        if FNCHorizon[0] <> nil then begin
            FNCHorizon[0].Free;
            FNCHorizon[0] := nil;
        end;
        if FNCHorizon[1] <> nil then begin
            FNCHorizon[1].Free;
            FNCHorizon[1] := nil;
        end;
    end;
end;

procedure TfrmMap.CentrePayloadOnMap(PayloadIndex: Integer);
begin
    if PayloadIndex >= 0 then begin
        if Balloons[PayloadIndex].FNCMarker <> nil then begin
            FNCMap.SetCenterCoordinate(Balloons[PayloadIndex].FNCMarker.Latitude, Balloons[PayloadIndex].FNCMarker.Longitude);
        end;
    end else begin
        SetHomePosition;
        // FNCMap.SetCenterCoordinate(FNCMap.Options.DefaultLatitude, FNCMap.Options.DefaultLongitude);
    end;
end;


procedure TfrmMap.UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
var
    FileName: String;
begin
    if Balloons[PayloadIndex].FNCMarker <> nil then begin
        FileName := ImageFolder + BalloonIconName(Position, ColourText, False) + '.png';

        if FileName <> Balloons[PayloadIndex].MarkerName then begin
            Balloons[PayloadIndex].MarkerName := FileName;
            if FileExists(FileName) then begin
                Balloons[PayloadIndex].FNCMarker.IconURL := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
            end;
        end;
    end;
end;

procedure TfrmMap.ClearPredictionPath(PayloadIndex: Integer; Colour: TColor);
begin
    // virtual
end;

procedure TfrmMap.AppendToPredictionPath(PayloadIndex: Integer; PredictedLatitude, PredictedLongitude, PredictedAltitude: Double);
begin
    // virtual
end;

procedure TfrmMap.SetMapSource(Source: String);
begin
    Source := UpperCase(Source);
    FNCMap.APIKey := '';
    CanHome := False;

    if Source = 'AZURE' then begin
        FNCMap.Service := msAzureMaps;
    end else if Source = 'BING' then begin
        FNCMap.APIKey := BingMapsAPIKey;
        FNCMap.Service := msBingMaps;
    end else if Source = 'GOOGLE' then begin
        FNCMap.APIKey := GoogleMapsAPIKey;
        FNCMap.Service := msGoogleMaps;
    end else if Source = 'HERE' then begin
        FNCMap.Service := msHere;
    end else if Source = 'MAPBOX' then begin
        FNCMap.Service := msMapBox;
    end else if Source = 'MAPKIT' then begin
        FNCMap.Service := msMapKit;
    end else if Source = 'OPEN' then begin
        FNCMap.Service := msOpenLayers;
    end else if Source = 'TOMTOM' then begin
        FNCMap.APIKey := TomTomMapsAPIKey;
        FNCMap.Service := msTomTom;
    end;


    NeedToHome := True;
end;

procedure TfrmMap.tmrCentreAtHomeTimer(Sender: TObject);
begin
    if NeedToHome and CanHome then begin
        NeedToHome := False;
        FNCMap.SetCenterCoordinate(DataModule1.tblSettings.FieldByName('Latitude').Asfloat, DataModule1.tblSettings.FieldByName('Longitude').AsFloat);
    end;
end;

end.
