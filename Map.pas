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
  TfrmMap = class(TfrmNormal)
    GMap: TWebGMaps;
    procedure FormCreate(Sender: TObject);
    procedure GMapDownloadFinish(Sender: TObject);
    procedure GMapDownloadStart(Sender: TObject);
  private
    { Private declarations }
    ImageFolder: String;
    OKToUpdateMap: Boolean;
    MarkerNames: array[0..32] of String;
    PolylineItems: array[0..32] of TPolylineItem;
    FollowMode: TFollowMode;
    function FindMapMarker(PayloadID: String): Integer;
    procedure AddOrUpdateMapMarker(PayloadID: String; Latitude: Double; Longitude: Double; ImageName: String);
  public
    { Public declarations }
    function ProcessNewPosition(Position: THABPosition; BalloonColour: String): Boolean;
  end;

var
  frmMap: TfrmMap;

implementation

{$R *.dfm}

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

function BalloonIconName(Position: THABPosition; BalloonColour: String; Target: Boolean=False): String;
begin
    Result := 'balloon-' + BalloonColour;

//    if Target then begin
//        Result := 'x-' + BalloonColour;
//    end else begin
//        case Position.FlightMode of
//            fmIdle:         Result := 'payload-' + BalloonColour;
//            fmLaunched:     Result := 'balloon-' + BalloonColour;
//            fmDescending:   Result := 'parachute-' + BalloonColour;
//            fmLanded:       Result := 'payload-' + BalloonColour;
//        end;
//    end;
end;


function TfrmMap.ProcessNewPosition(Position: THABPosition; BalloonColour: String): Boolean;
var
    Index: Integer;
begin
    Result := False;

    if OKToUpdateMap then begin
        // Find or create marker for this payload
        AddOrUpdateMapMarker(Position.PayloadID,
                             Position.Latitude,
                             Position.Longitude,
                             BalloonIconName(Position, BalloonColour, False));

        // Update balloon prediction marker
        if Position.ContainsPrediction then begin
            AddOrUpdateMapMarker('X', Position.PredictedLatitude, Position.PredictedLongitude, BalloonIconName(Position, BalloonColour.Empty ));
        end;

        // Balloon path
        // PolylineItems[Index].Polyline.Path.Add(Position.Latitude, Position.Longitude);
        // GMap.UpdateMapPolyline(PolylineItems[Index].Polyline);

        // Pan to balloon
//        if (FollowMode = fmPayload) and (Index = SelectedIndex) then begin
//            GMap.MapPanTo(Positions[Index].Position.Latitude, Positions[Index].Position.Longitude);
//        end;

        Result := True;
    end;
end;

procedure TfrmMap.AddOrUpdateMapMarker(PayloadID: String; Latitude: Double; Longitude: Double; ImageName: String);
var
    MarkerIndex: Integer;
    Marker: TMarker;
    FileName: String;
begin
    MarkerIndex := FindMapMarker(PayloadID);

    if MarkerIndex >= 0 then begin
        Marker := GMap.Markers[MarkerIndex];
    end else begin
        Marker := GMap.Markers.Add(Latitude, Longitude, PayloadID);
        MarkerIndex := GMap.Markers.Count-1;
    end;

    Marker.Latitude := Latitude;
    Marker.Longitude := Longitude;

    // Marker.Icon := StringReplace('File://' + 'C:\Dropbox\dev\HAB\HABMobile2\images\' + ImageName + '.png', '\', '/',[rfReplaceAll, rfIgnoreCase]);
    FileName := ImageFolder + ImageName + '.png';

    if FileName <> MarkerNames[MarkerIndex] then begin
        MarkerNames[MarkerIndex] := FileName;
        if FileExists(FileName) then begin
            Marker.Icon := StringReplace('File://' + FileName, '\', '/',[rfReplaceAll, rfIgnoreCase]);
        end else begin
            Caption := '11';
        end;
    end;
end;



end.
