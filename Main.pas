unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvSplitter, Math,
  AdvCustomControl, AdvWebBrowser, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, ActiveX, MSHTML;

type
    THABPosition = record
        PayloadID:      String;
        PayloadDocID:   String;
        TimeStamp:      TDateTime;
        Latitude:       Double;
        Longitude:      Double;
        Altitude:       Double;
        Distance:       Double;
    end;

type
  TfrmMain = class(TForm)
    AdvSplitter1: TAdvSplitter;
    Panel1: TPanel;
    AdvSplitter2: TAdvSplitter;
    Panel3: TPanel;
    AdvSplitter3: TAdvSplitter;
    Panel4: TPanel;
    pnlSources: TPanel;
    Panel2: TPanel;
    AdvSplitter4: TAdvSplitter;
    AdvSplitter5: TAdvSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    lstPayloadIDs: TListBox;
    lstPositions: TListBox;
    Memo1: TMemo;
    WebBrowser1: TWebBrowser;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure LoadForms;
    procedure ProcessHabitat(Strings: TStringList);
    function ProcessHabitatLine(Line: String; var Position: THABPosition): Boolean;
  public
    { Public declarations }
    procedure StorePayload(Position: THABPosition);
  end;

var
  frmMain: TfrmMain;

implementation

uses Sources;

{$R *.dfm}

procedure TfrmMain.FormActivate(Sender: TObject);
const
    FirstTime: Boolean = True;
begin
    if FirstTime then begin
        FirstTime := False;
        LoadForms;
        WebBrowser1.Navigate('http://habitat.habhub.org/logtail/');
    end;
end;

procedure TfrmMain.LoadForms;
begin
    frmSources.pnlMain.Parent := pnlSources;
end;

procedure TfrmMain.StorePayload(Position: THABPosition);
var
    Index: Integer;
    PositionString: String;
begin
    if Position.PayloadDocID = '' then begin
        PositionString := Position.PayloadID + ' ** NO PAYLOAD DOC **';
    end else begin
        PositionString := Position.PayloadID + ' ' + Position.PayloadDocID + ':' +
                          FormatDateTime('hh:nn:ss', Position.TimeStamp) + ', ' +
                          FormatFloat('0.00000', Position.Latitude) + ', ' +
                          FormatFloat('0.00000', Position.Longitude) + ', ' +
                          FormatFloat('0', Position.Altitude) + ', ' +
                          FormatFloat('0', Position.Distance) + 'km';
    end;

    Index := lstPayloadIDs.Items.IndexOf(Position.PayloadID);

    if Index < 0 then begin
        // Not in list so add it
        lstPayloadIDs.Items.Add(Position.PayloadID);
        lstPositions.Items.Add(PositionString);

        Memo1.Lines.Add('Added ' + Position.PayloadID);
    end else begin
        if lstPositions.Items[Index] <> PositionString then begin
            lstPositions.Items[Index] := PositionString;

            // Memo1.Lines.Add('Changed ' + Position.PayloadID);
        end;
    end;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
    Strings: TStringList;
    Document: IHTMLDocument2;
begin
    Timer1.Enabled := False;
    Strings := TStringList.Create;
    try
        Document := webBrowser1.Document as IHTMLDocument2;
        if Document <> nil then begin
            if Document.Body <> nil then begin
                Strings.Text := Document.Body.innerHTML;

                ProcessHabitat(Strings);
            end;
        end;
    finally
        Strings.Free;
        Timer1.Enabled := True;
    end;
end;

function CalculateDistance(HABLatitude, HABLongitude, CarLatitude, CarLongitude: Double): Double;
begin
    // Return distance in km

    HABLatitude := HABLatitude * Pi / 180;
    HABLongitude := HABLongitude * Pi / 180;
    CarLatitude := CarLatitude * Pi / 180;
    CarLongitude := CarLongitude * Pi / 180;

    try
        Result := 6371 * arccos(sin(CarLatitude) * sin(HABLatitude) +
                                cos(CarLatitude) * cos(HABLatitude) * cos(HABLongitude-CarLongitude));
    except
        Result := 0.0;
    end;
end;

function GetString(var Line: String; Delimiter: String = ','): String;
var
    Posn: Integer;
begin
    Posn := Pos(Delimiter, Line);

    if Posn > 0 then begin
        Result := Copy(Line, 1, Posn-1);
        Line := Copy(Line, Posn+Length(Delimiter), 999);
    end else begin
        Result := Line;
        Line := '';
    end;
end;

function GetFloat(var Line: String; Delimiter: String = ','): Double;
var
    Temp: String;
begin
    Temp := GetString(Line, Delimiter);

    try
        Result := StrToFloat(Temp);
    except
        Result := 0.0;
    end;
end;

function GetTime(var Line: String; Delimiter: String = ','): TDateTime;
var
    Temp: String;
begin
    Temp := GetString(Line, Delimiter);

    try
        if Pos(':', Temp) > 0 then begin
            Result := EncodeTime(StrToIntDef(Copy(Temp, 1, 2), 0),
                      StrToIntDef(Copy(Temp, 4, 2), 0),
                      StrToIntDef(Copy(Temp, 7, 2), 0),
                      0);
        end else begin
            Result := EncodeTime(StrToIntDef(Copy(Temp, 1, 2), 0),
                      StrToIntDef(Copy(Temp, 3, 2), 0),
                      StrToIntDef(Copy(Temp, 5, 2), 0),
                      0);
        end;
    except
        Result := 0;
    end;
end;

procedure TfrmMain.ProcessHabitat(Strings: TStringList);
const
    PreviousLastLine: String = '';
var
    i: Integer;
    Position: THABPosition;
begin
    Position := Default(THABPosition);

    if Strings.Count > 0 then begin
        if PreviousLastLine <> Strings[Strings.Count-1] then begin
            for i := Strings.Count-1 downto 0 do begin
                if ProcessHabitatLine(Strings[i], Position) then begin
                    // Calculate distance
                    Position.Distance := CalculateDistance(Position.Latitude, Position.Longitude, 52, -2);

                    // Add to list
                    frmMain.StorePayload(Position);

                    // Clear for next payload
                    Position := Default(THABPosition);
                end;
            end;
            PreviousLastLine := Strings[0];
        end;
    end;
end;

function TfrmMain.ProcessHabitatLine(Line: String; var Position: THABPosition): Boolean;
var
    TimeStamp: TDateTime;
    i, j, Posn: Integer;
    Latitude, Longitude: Double;
    FullLine, Command: String;
begin
    Result := False;

    FullLine := Line;

    if Copy(Line,1,1) = '[' then begin
        // One of the lines we're interested in

// [2020-03-03 09:36:41,239] DEBUG habitat.parser MainThread: Selected payload_configuration 8c36ab528b16cb3adf00b7e07a228854 for 'RS_DFM-616153'
// [2020-03-03 09:36:43,650] DEBUG habitat.parser MainThread: No configuration doc for 'UNCHANGES' found

(*
        Posn := Pos('''$$', Line);
        if Posn > 0 then begin
            // Telemetry line
            // [2020-03-03 08:42:32,841] INFO habitat.parser MainThread: Parsing [ascii] '$$RS_DFM-17050539,188,08:42:28,53.05664,10.03080,8408,26.7,-51.0,-1.0,DFM09 DFM-17050539 403.471 MHz*57B1\n' (0d9acf53d3ed09c28debd57e232c8af877fff789f73cf6dcff8810b4aeaf916f) from OZ1SKY_AUTO_RX

            Line := Copy(Line, Posn, 999);
            // $$RS_DFM-17050539,188,08:42:28,53.05664,10.03080,8408,26.7,-51.0,-1.0,DFM09 DFM-17050539 403.471 MHz*57B1\n' (0d9acf53d3ed09c28debd57e232c8af877fff789f73cf6dcff8810b4aeaf916f) from OZ1SKY_AUTO_RX

            Posn := LastDelimiter('$', Copy(Line, 1, 9));

            if Posn > 0 then begin
                Line := Copy(Line, Posn+1, 999);

                // RS_DFM-17050539,188,08:42:28,53.05664,10.03080,8408,26.7,-51.0,-1.0,DFM09 DFM-17050539 403.471 MHz*57B1\n' (0d9acf53d3ed09c28debd57e232c8af877fff789f73cf6dcff8810b4aeaf916f) from OZ1SKY_AUTO_RX
                Position.PayloadID := GetString(Line);

                if Pos('</PRE>', Position.PayloadID) > 0 then begin
                    Position.PayloadID := '';
                end;


                // 188,08:42:28,53.05664,10.03080,8408,26.7,-51.0,-1.0,DFM09 DFM-17050539 403.471 MHz*57B1\n' (0d9acf53d3ed09c28debd57e232c8af877fff789f73cf6dcff8810b4aeaf916f) from OZ1SKY_AUTO_RX

                // Counter present ?
                if Pos(',', Line) < Pos(':', Line) then begin
                    // Have sentence counter
                    GetString(Line);
                end;

                Position.TimeStamp := GetTime(Line);

                Position.Latitude := GetFloat(Line);
                Position.Longitude := GetFloat(Line);
                Position.Altitude := GetFloat(Line);
            end;
        end;
*)
        if Pos('No configuration doc', Line) > 0 then begin
            Result := True;
        end else begin
            Posn := Pos('Selected payload_configuration', Line);
            if Posn > 0 then begin
                // [2020-03-03 09:36:41,239] DEBUG habitat.parser MainThread: Selected payload_configuration 8c36ab528b16cb3adf00b7e07a228854 for 'RS_DFM-616153'
                Line := Copy(Line, Posn+31, Length(Line));
                // 8c36ab528b16cb3adf00b7e07a228854 for 'RS_DFM-616153'

                Posn := Pos(' ', Line);
                Position.PayloadDocID := Copy(Line, 1, Posn-1);
                Line := Copy(Line, Posn, Length(Line));

                Posn := Pos(' for ''', Line);
                Line := Copy(Line, Posn+6, 99);

                Position.PayloadID := GetString(Line, '''');

                if Pos('</PRE>', Position.PayloadID) > 0 then begin
                    Position.PayloadID := '';
                end;
            end;
        end;
    end else if Copy(Line,1,3) = '  "' then begin
        GetString(Line, '"');
        Command := GetString(Line, '":');

        if Command = 'latitude' then begin
            //  "latitude": 50.72363,
            Position.Latitude := GetFloat(Line, ',');
        end else if Command = 'longitude' then begin
            Position.Longitude := GetFloat(Line, ',');
        end else if Command = 'altitude' then begin
            Position.Altitude := GetFloat(Line, ',');
        end else if Command = 'payload' then begin
            GetString(Line, '"');
            if GetString(Line, '"') = Position.PayloadID then begin
                Result := True;
            end;
        end;
    end;
end;

end.
