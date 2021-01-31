unit Misc;

interface

uses SysUtils;

function GetSetting(FieldName, Settings: String): String;
function GetBooleanSetting(FieldName, Settings: String): Boolean;
function MyStrToFloat(Value: String): Double;

implementation

function GetSetting(FieldName, Settings: String): String;
var
    Position: Integer;
    Temp: String;
begin
    Position := Pos(';' + FieldName + '=', Settings);
    if Position > 0 then begin
        Temp := Copy(Settings, Position + Length(FieldName) + 2, 99);
        Position := Pos(';', Temp);
        if Position > 0 then begin
            Result := Copy(Temp, 1, Position-1);
        end else begin
            Result := Temp;
        end;
    end else begin
        Result := '';
    end;
end;

function GetBooleanSetting(FieldName, Settings: String): Boolean;
var
    Temp: String;
begin
    Temp := GetSetting(FieldName, Settings);

    Result := Pos('T', Temp) > 0;
end;

function MyStrToFloat(Value: String): Double;
begin
    if FormatSettings.DecimalSeparator <> '.' then begin
        Value := StringReplace(Value, '.', FormatSettings.DecimalSeparator, []);
    end;

    try
        Result := StrToFloat(Value);   // , LFormat);
    except
        Result := 0;
    end;
end;


end.
