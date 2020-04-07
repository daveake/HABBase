unit Map;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Normal, Vcl.StdCtrls,
  UWebGMapsCommon, UWebGMaps, UWebGMapsPolylines, UWebGMapsMarkers,
  Vcl.ExtCtrls,
  Source;

type
  TFollowMode = (fmInit, fmNone, fmCar, fmPayload);

type
  TBalloon = record
      InUse:          Boolean;
      Marker:         TMarker;
      MarkerName:     String;
      Radial:         TPolylineItem;
      Track:          TPolylineItem;
      Position:       THABPosition;
  end;

type
  TfrmMap = class(TfrmNormal)
    GMap: TWebGMaps;
    procedure FormCreate(Sender: TObject);
    procedure GMapDownloadFinish(Sender: TObject);
    procedure GMapDownloadStart(Sender: TObject);
  private
    { Private declarations }
    Balloons: Array[1..32] of TBalloon;
    ImageFolder: String;
    OKToUpdateMap: Boolean;
    MastMarker: TMarker;
    // MarkerNames: array[0..64] of String;
    // PolylineItems: array[0..64] of TPolylineItem;
    FollowMode: TFollowMode;
    function FindMapMarker(PayloadID: String): Integer;
    procedure AddOrUpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ImageName: String);
    procedure DrawRadial(PayloadIndex: Integer; NewHome: Boolean);
  public
    { Public declarations }
    function ProcessNewPosition(PayloadIndex: Integer; Position: THABPosition; Colour: TColor; ColourText: String): Boolean;
    procedure SetHomePosition;
    procedure RemovePayload(PayloadIndex: Integer);
  end;

var
  frmMap: TfrmMap;

implementation

{$R *.dfm}

uses Data, BaseTypes;

// IF THE FOLLOWING LINE GIVES AN ERROR

{$INCLUDE 'key.pas'}

(* THEN CREATE A FILE key.pas CONTAINING:

const GoogleMapsAPIKey = '<YOUR_GOOGLE_API_KEY>';

THIS FILE IS SPECIFICALLY EXCLUDED in .gitignore TO AVOID SHARING API KEYS
*)

procedure TfrmMap.FormCreate(Sender: TObject);
begin
    GMap.LocationAPIKey := GoogleMapsAPIKey;

    GMap.APIKey := GMap.LocationAPIKey;

    FollowMode := fmInit;

    OKToUpdateMap := True;

    if ParamCount > 0 then begin
        ImageFolder := ParamStr(1) + '\Images\';
    end else begin
        ImageFolder := ExtractFilePath(Application.ExeName) + 'Images\';
    end;

    SetHomePosition;
end;

procedure TfrmMap.GMapDownloadFinish(Sender: TObject);
begin
    OKToUpdateMap := True;

//    if FollowMode = fmInit then begin
//        GMap.MapPanTo(Positions[0].Position.Latitude, Positions[0].Position.Longitude);
//        btnFreeClick(btnFree);
//    end;
//
//    if Directions.Active then begin
//        frmDebug.Debug('3');
//        tmrDirections.Enabled := True;
//        Directions.Active := False;
//    end;
end;

procedure TfrmMap.GMapDownloadStart(Sender: TObject);
begin
    // OKToUpdateMap := False;
end;

function TfrmMap.FindMapMarker(PayloadID: String): Integer;
var
    i: Integer;
begin
    for i := 0 to GMap.Markers.Count-1 do begin
        if GMap.Markers[i].Title = PayloadID then begin
            // Found it
            Result := i;
            Exit;
        end;
    end;

    Result := -1;
end;

function BalloonIconName(Position: THABPosition; ColourText: String; Target: Boolean=False): String;
begin
    Result := 'balloon-' + ColourText;

//    if Target then begin
//        Result := 'x-' + BalloonColour;
//    end else begin
        case Position.FlightMode of
            fmIdle:         Result := 'payload-' + ColourText;
            fmLaunched:     Result := 'balloon-' + ColourText;
            fmDescending:   Result := 'parachute-' + ColourText;
            fmLanded:       Result := 'payload-' + ColourText;
        end;
//    end;
end;


function TfrmMap.ProcessNewPosition(PayloadIndex: Integer; Position: THABPosition; Colour: TColor; ColourText: String): Boolean;
begin
    Result := False;

    Balloons[PayloadIndex].Position := Position;

    if OKToUpdateMap then begin
        // Find or create marker for this payload
        AddOrUpdateMapMarker(PayloadIndex, Position, BalloonIconName(Position, ColourText, False));

        // Update balloon prediction marker
//        if Position.ContainsPrediction then begin
//            AddOrUpdateMapMarker('X', Position.PredictedLatitude, Position.PredictedLongitude, BalloonIconName(Position, BalloonColour.Empty ));
//        end;

        // Line to Balloon
        DrawRadial(PayloadIndex, False);

        // Balloon Path
        if Balloons[PayloadIndex].Track = nil then begin
            Balloons[PayloadIndex].Track := GMap.Polylines.Add;
            Balloons[PayloadIndex].Track.Polyline.Color := Colour;
            Balloons[PayloadIndex].Track.Polyline.Path.Add(Position.Latitude, Position.Longitude);
            GMap.CreateMapPolyline(Balloons[PayloadIndex].Track.Polyline);
        end else begin
            Balloons[PayloadIndex].Track.Polyline.Path.Add(Position.Latitude, Position.Longitude);
            GMap.UpdateMapPolyline(Balloons[PayloadIndex].Track.Polyline);
        end;


        // Pan to balloon
//        if (FollowMode = fmPayload) and (Index = SelectedIndex) then begin
//            GMap.MapPanTo(Positions[Index].Position.Latitude, Positions[Index].Position.Longitude);
//        end;

        Result := True;
    end;
end;

procedure TfrmMap.AddOrUpdateMapMarker(PayloadIndex: Integer; Position: THABPosition; ImageName: String);
var
    FileName: String;
begin
    if not Balloons[PayloadIndex].InUse then begin
        Balloons[PayloadIndex].InUse := True;
        Balloons[PayloadIndex].Marker := GMap.Markers.Add(Position.Latitude, Position.Longitude, Position.PayloadID);
    end;

    Balloons[PayloadIndex].Marker.Latitude := Position.Latitude;
    Balloons[PayloadIndex].Marker.Longitude := Position.Longitude;

    // Marker.Icon := StringReplace('File://' + 'C:\Dropbox\dev\HAB\HABMobile2\images\' + ImageName + '.png', '\', '/',[rfReplaceAll, rfIgnoreCase]);
    FileName := ImageFolder + ImageName + '.png';

    if FileName <> Balloons[PayloadIndex].MarkerName then begin
        Balloons[PayloadIndex].MarkerName := FileName;
        if FileExists(FileName) then begin
            Balloons[PayloadIndex].Marker.Icon := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
        end else begin
            Caption := '11';
        end;
    end;
end;

procedure TfrmMap.SetHomePosition;
var
    FileName: String;
    PayloadIndex: Integer;
begin
    if (not DataModule1.tblSettings.FieldByName('Latitude').IsNull) and (not DataModule1.tblSettings.FieldByName('Longitude').IsNull) then begin
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

        for PayloadIndex := Low(Balloons) to High(Balloons) do begin
            if Balloons[PayloadIndex].InUse then begin
                DrawRadial(PayloadIndex, True);
            end;
        end;
    end;
end;

procedure TfrmMap.DrawRadial(PayloadIndex: Integer; NewHome: Boolean);
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

procedure TfrmMap.RemovePayload(PayloadIndex: Integer);
begin
    with Balloons[PayloadIndex] do begin
        InUse := False;
        if Marker <> nil then begin
            Marker.Free;
            Marker := nil;
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
    end;
end;

end.
