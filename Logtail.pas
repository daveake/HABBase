unit Logtail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SourceForm, Vcl.ExtCtrls, Vcl.OleCtrls,
  SHDocVw, Vcl.StdCtrls, MSHTML, ActiveX, DateUtils,
  Source;

type
  TfrmLogtail = class(TfrmSource)
    WebBrowser1: TWebBrowser;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure ProcessLogtail(Strings: TStringList);
    function ProcessLogtailLine(Line: String; var Position: THABPosition): Boolean;
  public
    { Public declarations }
  end;

var
  frmLogtail: TfrmLogtail;

implementation

{$R *.dfm}

uses Main, Miscellaneous;

procedure TfrmLogtail.Timer1Timer(Sender: TObject);
const
    FirstTime: Boolean = True;
var
    Strings: TStringList;
    Document: IHTMLDocument2;
begin
    Timer1.Enabled := False;

     try
        if FirstTime then begin
            FirstTime := False;
            WebBrowser1.Navigate('http://habitat.habhub.org/logtail/');
            frmMain.ShowConnected(SourceIndex, True);
        end else begin
            Strings := TStringList.Create;
            try
                Document := webBrowser1.Document as IHTMLDocument2;
                if Document <> nil then begin
                    if Document.Body <> nil then begin
                        Strings.Text := Document.Body.innerHTML;

                        ProcessLogtail(Strings);
                    end;
                end;
            finally
                Strings.Free;
                Timer1.Interval := 5000;
            end;
        end;
    finally
        Timer1.Enabled := True;
    end;
end;

procedure TfrmLogtail.ProcessLogtail(Strings: TStringList);
const
    PreviousLastLine: String = '';
var
    i: Integer;
    Position: THABPosition;
begin
    Position := Default(THABPosition);

    if Strings.Count > 0 then begin
        // if PreviousLastLine <> Strings[Strings.Count-1] then begin
            for i := Strings.Count-1 downto 0 do begin
                if ProcessLogtailLine(Strings[i], Position) then begin
                    // Calculate distance
                    Position.Distance := CalculateDistance(Position.Latitude, Position.Longitude, 52, -2) / 1000.0;

                    // Add to list
                    frmMain.NewPosition(SourceIndex, Position);

                    // Clear for next payload
                    Position := Default(THABPosition);
                end;
            end;
            PreviousLastLine := Strings[0];
        // end;
    end;
end;

function TfrmLogtail.ProcessLogtailLine(Line: String; var Position: THABPosition): Boolean;
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

                Position.TimeStamp := EncodeDateTime(StrToIntDef(Copy(Line, 2, 4), 2020),
                                                     StrToIntDef(Copy(Line, 7, 2), 1),
                                                     StrToIntDef(Copy(Line, 10, 2), 1),
                                                     StrToIntDef(Copy(Line, 13, 2), 1),
                                                     StrToIntDef(Copy(Line, 16, 2), 1),
                                                     StrToIntDef(Copy(Line, 19, 2), 1),
                                                     0);


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
