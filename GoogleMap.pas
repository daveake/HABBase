unit GoogleMap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Map, UWebGMapsCommon, UWebGMaps,
  Vcl.StdCtrls, Vcl.ExtCtrls, Miscellaneous, Source, Misc;

type
  TfrmGMap = class(TfrmMap)
    GMap: TWebGMaps;
    procedure FormCreate(Sender: TObject);
    procedure GMapDownloadFinish(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor); override;
    procedure CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); override;
    procedure SetMapHomePosition; override;
    procedure DrawRadial(PayloadIndex: Integer; NewHome: Boolean); override;
    procedure DrawHorizon(PayloadIndex: Integer); override;
    procedure RemoveMapPayload(PayloadIndex: Integer); override;
    procedure UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); override;
  public
    { Public declarations }
    procedure CentrePayloadOnMap(PayloadIndex: Integer); override;
    procedure SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String); override;
    procedure ClearPredictionPath(PayloadIndex: Integer; Colour: TColor); override;
    procedure AppendToPredictionPath(PayloadIndex: Integer; PredictedLatitude, PredictedLongitude, PredictedAltitude: Double); override;
  end;

var
  frmGMap: TfrmGMap;

implementation

{$R *.dfm}

uses Data, BaseTypes, Payloads;

// IF THE FOLLOWING LINE GIVES AN ERROR

{$INCLUDE 'key.pas'}

(* THEN CREATE A FILE key.pas CONTAINING:

const GoogleMapsAPIKey = '<YOUR_GOOGLE_API_KEY>';

THIS FILE IS SPECIFICALLY EXCLUDED in .gitignore TO AVOID SHARING API KEYS
*)

procedure TfrmGMap.FormCreate(Sender: TObject);
begin
    GMap.LocationAPIKey := GoogleMapsAPIKey;

    GMap.APIKey := GMap.LocationAPIKey;

    inherited;
end;

procedure TfrmGMap.GMapDownloadFinish(Sender: TObject);
begin
    OKToUpdateMap := True;
end;

procedure TfrmGMap.SetMapHomePosition;
var
    FileName: String;
    PayloadIndex: Integer;
begin
    GMap.MapOptions.DefaultLatitude := DataModule1.tblSettings.FieldByName('Latitude').Asfloat;
    GMap.MapOptions.DefaultLongitude := DataModule1.tblSettings.FieldByName('Longitude').AsFloat;

    if MastMarker = nil then begin
        MastMarker := GMap.Markers.Add(GMap.MapOptions.DefaultLatitude, GMap.MapOptions.DefaultLongitude);
        FileName := ImageFolder + 'mast.png';
        if FileExists(FileName) then begin
            MastMarker.Icon := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
        end;
    end else begin
        MastMarker.Latitude := GMap.MapOptions.DefaultLatitude;
        MastMarker.Longitude := GMap.MapOptions.DefaultLongitude;
    end;
end;

procedure TfrmGMap.CreateMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
begin
    // inherited
    Balloons[PayloadIndex].Marker := GMap.Markers.Add(Position.Latitude, Position.Longitude, Position.PayloadID);
    // Balloons[PayloadIndex].Marker.Text := Position.PayloadID;
    if Position.IsSonde then begin
        Balloons[PayloadIndex].Marker.MapLabel.Color := clYellow;
    end else begin
        Balloons[PayloadIndex].Marker.MapLabel.Color := clLime;
    end;
    Balloons[PayloadIndex].Marker.MapLabel.Text := Position.PayloadID;
    Balloons[PayloadIndex].Marker.MapLabel.OffsetTop := 70;
end;

procedure TfrmGMap.DrawPath(PayloadIndex: Integer; Position: THABPosition; Colour: TColor);
begin
    if Balloons[PayloadIndex].Track = nil then begin
        Balloons[PayloadIndex].Track := GMap.Polylines.Add;
        Balloons[PayloadIndex].Track.Polyline.Color := Colour;
        Balloons[PayloadIndex].Track.Polyline.Path.Add(Position.Latitude, Position.Longitude);
        GMap.CreateMapPolyline(Balloons[PayloadIndex].Track.Polyline);
    end else begin
        Balloons[PayloadIndex].Track.Polyline.Path.Add(Position.Latitude, Position.Longitude);
        GMap.UpdateMapPolyline(Balloons[PayloadIndex].Track.Polyline);
    end;
end;

procedure TfrmGMap.SetLandingMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
var
    FileName: String;
begin
    if Balloons[PayloadIndex].Landing = nil then begin
        FileName := ImageFolder + 'x-' + ColourText + '.png';
        Balloons[PayloadIndex].Landing := GMap.Markers.Add(Position.PredictedLatitude,
                                                       Position.PredictedLongitude,
                                                       Position.PayloadID);
        Balloons[PayloadIndex].Landing.Icon := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
        Balloons[PayloadIndex].Landing.IconAnchorHeight := 13;
        Balloons[PayloadIndex].Landing.IconAnchorWidth := 23;
    end else begin
        Balloons[PayloadIndex].Landing.Latitude := Position.PredictedLatitude;
        Balloons[PayloadIndex].Landing.Longitude := Position.PredictedLongitude;
    end;
end;

procedure TfrmGMap.DrawHorizon(PayloadIndex: Integer);
const
    Colors: Array[0..1] of TColor = (clBlue, clLime);
    Radius: Array[0..1] of Double = (0.0, 5.0);
var
    i: Integer;
    NewCircle: Boolean;
begin
    for i := 0 to 1 do begin
        if Balloons[PayloadIndex].Horizon[i] = nil then begin
            Balloons[PayloadIndex].Horizon[i] := GMap.Polygons.Add;
            Balloons[PayloadIndex].Horizon[i].Polygon.PolygonType := ptCircle;
            Balloons[PayloadIndex].Horizon[i].Polygon.BorderColor := Colors[i];
            Balloons[PayloadIndex].Horizon[i].Polygon.BackgroundColor := clNone;
            Balloons[PayloadIndex].Horizon[i].Polygon.HoverBorderColor := Colors[i];
            Balloons[PayloadIndex].Horizon[i].Polygon.HoverBackgroundColor := clNone;
            Balloons[PayloadIndex].Horizon[i].Polygon.BackgroundOpacity := 0;
            Balloons[PayloadIndex].Horizon[i].Polygon.BorderWidth := 2;
            NewCircle := True;
        end else begin;
            NewCircle := False;
        end;

        Balloons[PayloadIndex].Horizon[i].Polygon.Radius := Round(1000.0 * CalculateHorizonRadius(Balloons[PayloadIndex].Position.Altitude, Radius[i]));
        Balloons[PayloadIndex].Horizon[i].Polygon.Center.Latitude := Balloons[PayloadIndex].Position.Latitude;
        Balloons[PayloadIndex].Horizon[i].Polygon.Center.Longitude := Balloons[PayloadIndex].Position.Longitude;

        if NewCircle then begin
            GMap.CreateMapPolygon(Balloons[PayloadIndex].Horizon[i].Polygon);
        end else begin
            GMap.UpdateMapPolygon(Balloons[PayloadIndex].Horizon[i].Polygon);
        end;
    end;
end;

procedure TfrmGMap.RemoveMapPayload(PayloadIndex: Integer);
begin
    with Balloons[PayloadIndex] do begin
        if Marker <> nil then begin
            Marker.Free;
            Marker := nil;
        end;

        if Landing <> nil then begin
            Landing.Free;
            Landing := nil;
        end;

        if Prediction <> nil then begin
            Prediction.Free;
            Prediction := nil;
        end;

        if Radial <> nil then begin
            GMap.DeleteMapPolyline(Radial.Index);
            GMap.PolyLines.Delete(Radial.Index);
            // Radial.Free;
            Radial := nil;
        end;
        if Track <> nil then begin
            GMap.DeleteMapPolyline(Track.Index);
            GMap.PolyLines.Delete(Track.Index);
            // Track.Free;
            Track := nil;
        end;
        if Horizon[0] <> nil then begin
            GMap.DeleteMapPolygon(Horizon[0].Index);
            GMap.Polygons.Delete(Horizon[0].Index);
            Horizon[0] := nil;
        end;
        if Horizon[1] <> nil then begin
            GMap.DeleteMapPolygon(Horizon[1].Index);
            GMap.Polygons.Delete(Horizon[1].Index);
            Horizon[1] := nil;
        end;
    end;
end;

procedure TfrmGMap.CentrePayloadOnMap(PayloadIndex: Integer);
begin
    if PayloadIndex >= 0 then begin
        if Balloons[PayloadIndex].Marker <> nil then begin
            GMap.MapPanTo(Balloons[PayloadIndex].Marker.Latitude, Balloons[PayloadIndex].Marker.Longitude);
        end;
    end else begin
        GMap.MapPanTo(GMap.MapOptions.DefaultLatitude, GMap.MapOptions.DefaultLongitude);
    end;
end;

procedure TfrmGMap.UpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ColourText: String);
var
    FileName: String;
begin
    if Balloons[PayloadIndex].Marker <> nil then begin
        FileName := ImageFolder + BalloonIconName(Position, ColourText, False) + '.png';

        if FileName <> Balloons[PayloadIndex].MarkerName then begin
            Balloons[PayloadIndex].MarkerName := FileName;
            if FileExists(FileName) then begin
                Balloons[PayloadIndex].Marker.Icon := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
            end;
        end;
    end;
end;

procedure TfrmGMap.DrawRadial(PayloadIndex: Integer; NewHome: Boolean);
begin
    if (not DataModule1.tblSettings.FieldByName('Latitude').IsNull) and (not DataModule1.tblSettings.FieldByName('Longitude').IsNull) then begin
        if Balloons[PayloadIndex].Radial = nil then begin
            Balloons[PayloadIndex].Radial := GMap.Polylines.Add;
            Balloons[PayloadIndex].Radial.Polyline.Color := clLime;
            // Source at listener position
            Balloons[PayloadIndex].Radial.Polyline.Path.Add(DataModule1.tblSettings.FieldByName('Latitude').AsFloat,
                                                            DataModule1.tblSettings.FieldByName('Longitude').AsFloat);
            // Target at balloon
            Balloons[PayloadIndex].Radial.Polyline.Path.Add(Balloons[PayloadIndex].Position.Latitude, Balloons[PayloadIndex].Position.Longitude);
            GMap.CreateMapPolyline(Balloons[PayloadIndex].Radial.Polyline);
        end else begin
            // Move target to new balloon position
            if NewHome then begin
                Balloons[PayloadIndex].Radial.Polyline.Path.Items[0].Latitude := DataModule1.tblSettings.FieldByName('Latitude').AsFloat;
                Balloons[PayloadIndex].Radial.Polyline.Path.Items[0].Longitude := DataModule1.tblSettings.FieldByName('Longitude').AsFloat;
            end;

            Balloons[PayloadIndex].Radial.Polyline.Path.Items[1].Latitude := Balloons[PayloadIndex].Position.Latitude;
            Balloons[PayloadIndex].Radial.Polyline.Path.Items[1].Longitude := Balloons[PayloadIndex].Position.Longitude;

            GMap.UpdateMapPolyline(Balloons[PayloadIndex].Radial.Polyline);
        end;
    end;
end;

procedure TfrmGMap.ClearPredictionPath(PayloadIndex: Integer; Colour: TColor);
begin
    if Balloons[PayloadIndex].Prediction = nil then begin
        Balloons[PayloadIndex].Prediction := GMap.Polylines.Add;
        Balloons[PayloadIndex].Prediction.Polyline.Color := Colour;
        Balloons[PayloadIndex].Prediction.Polyline.Width := 2;
        GMap.CreateMapPolyline(Balloons[PayloadIndex].Prediction.Polyline);
    end else begin
        Balloons[PayloadIndex].Prediction.Polyline.Path.Clear;
        GMap.UpdateMapPolyline(Balloons[PayloadIndex].Prediction.Polyline);
    end;
end;

procedure TfrmGMap.AppendToPredictionPath(PayloadIndex: Integer; PredictedLatitude, PredictedLongitude, PredictedAltitude: Double);
begin
    Balloons[PayloadIndex].Prediction.Polyline.Path.Add(PredictedLatitude, PredictedLongitude);
    GMap.UpdateMapPolyline(Balloons[PayloadIndex].Prediction.Polyline);
end;

end.
