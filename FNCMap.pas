unit FNCMap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Map, Vcl.StdCtrls, Vcl.ExtCtrls,
  VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCMapsCommonTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser,
  VCL.TMSFNCMaps, Miscellaneous, Source, Misc;

type
  TfrmFNCMap = class(TfrmMap)
    tmrCentreAtHome: TTimer;
    FNCMap: TTMSFNCMaps;
    procedure FormCreate(Sender: TObject);
    procedure tmrCentreAtHomeTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FNCMapMapInitialized(Sender: TObject);
  private
    { Private declarations }
    NeedToHome, CanHome: Boolean;
  protected
    procedure SetMapHomePosition; override;
    procedure CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); override;
    procedure DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor); override;
    procedure DrawHorizon(PayloadIndex: Integer); override;
    procedure DrawRadial(PayloadIndex: Integer; NewHome: Boolean); override;
    procedure RemoveMapPayload(PayloadIndex: Integer); override;
    procedure UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); override;
    procedure SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); override;
  public
    { Public declarations }
    procedure CentrePayloadOnMap(PayloadIndex: Integer); override;
    procedure SetMapSource(Source: String);
  end;

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


procedure TfrmFNCMap.FNCMapMapInitialized(Sender: TObject);
begin
    CanHome := True;
end;

procedure TfrmFNCMap.FormCreate(Sender: TObject);
begin
    SetMapSource('GOOGLE');

    inherited;
end;

procedure TfrmFNCMap.FormShow(Sender: TObject);
begin
    tmrCentreAtHome.Enabled := True;
end;

procedure TfrmFNCMap.SetMapHomePosition;
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


procedure TfrmFNCMap.tmrCentreAtHomeTimer(Sender: TObject);
begin
    if NeedToHome and CanHome then begin
        NeedToHome := False;
        FNCMap.SetCenterCoordinate(DataModule1.tblSettings.FieldByName('Latitude').Asfloat, DataModule1.tblSettings.FieldByName('Longitude').AsFloat);
    end;
end;

procedure TfrmFNCMap.CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
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

procedure TfrmFNCMap.UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
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

procedure TfrmFNCMap.CentrePayloadOnMap(PayloadIndex: Integer);
begin
    if PayloadIndex >= 0 then begin
        if Balloons[PayloadIndex].FNCMarker <> nil then begin
            FNCMap.SetCenterCoordinate(Balloons[PayloadIndex].FNCMarker.Latitude, Balloons[PayloadIndex].FNCMarker.Longitude);
        end;
    end else begin
        FNCMap.SetCenterCoordinate(FNCMap.Options.DefaultLatitude, FNCMap.Options.DefaultLongitude);
    end;
end;

procedure TfrmFNCMap.DrawHorizon(PayloadIndex: Integer);
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

procedure TfrmFNCMap.DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor);
begin
    if Balloons[PayloadIndex].FNCTrack = nil then begin
        Balloons[PayloadIndex].FNCTrack := FNCMap.Polylines.Add;
        Balloons[PayloadIndex].FNCTrack.StrokeColor := Colour;
        // FNCMap.CreateMapPolyline(Balloons[PayloadIndex].FNCTrack.Polyline);
    end else begin
//        Balloons[PayloadIndex].Track.Polyline.Path.Add(Position.Latitude, Position.Longitude);
        // FNCMap.UpdateMapPolyline(Balloons[PayloadIndex].FNCTrack.Polyline);
    end;
    Balloons[PayloadIndex].FNCTrack.Coordinates.Add;
    Balloons[PayloadIndex].FNCTrack.Coordinates.Items[Balloons[PayloadIndex].FNCTrack.Coordinates.Count-1].Latitude := Position.Latitude;
    Balloons[PayloadIndex].FNCTrack.Coordinates.Items[Balloons[PayloadIndex].FNCTrack.Coordinates.Count-1].Longitude := Position.Longitude;
end;

procedure TfrmFNCMap.RemoveMapPayload(PayloadIndex: Integer);
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
            // FNCMap.PolyLines.Delete(FNCTrack.Index);
            // FNCTrack.Free;
            // FNCTrack := nil;
        end;
        if FNCHorizon[0] <> nil then begin
            FNCHorizon[0].Free;
            FNCHorizon[0] := nil;
            // FNCMap.Circles.Delete(FNCHorizon[0].Index);
            // FNCHorizon[0].Free;
        end;
        if FNCHorizon[1] <> nil then begin
            FNCHorizon[1].Free;
            FNCHorizon[1] := nil;
//            FNCMap.Circles.Delete(FNCHorizon[1].Index);
            // FNCHorizon[1].Free;
//            FNCHorizon[1] := nil;
        end;
    end;
end;

procedure TfrmFNCMap.DrawRadial(PayloadIndex: Integer; NewHome: Boolean);
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
        Balloons[PayloadIndex].FNCRadial.Coordinates[1].Latitude := Balloons[PayloadIndex].Position.Latitude;
        Balloons[PayloadIndex].FNCRadial.Coordinates[1].Longitude := Balloons[PayloadIndex].Position.Longitude;
    end;
end;

procedure TfrmFNCMap.SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
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

procedure TfrmFNCMap.SetMapSource(Source: String);
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

end.
