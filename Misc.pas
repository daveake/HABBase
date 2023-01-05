unit Misc;

interface

uses SysUtils;

function GetSetting(FieldName, Settings: String): String;
function GetBooleanSetting(FieldName, Settings: String): Boolean;
function MyStrToFloat(Value: String): Double;
function GetCommandLineParameter(ParameterName: String; var Value: String): Boolean;

const
    MAX_PAYLOADS = 100;
    HAB_BASE = 'HAB Base';
    HAB_BASE_VERSION = 'V1.7.1';

implementation

function GetSetting(FieldName, Settings: String): String;
var
    Position: Integer;
    Temp: String;
begin
    Settings := ';' + Settings;
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

function GetCommandLineParameter(ParameterName: String; var Value: String): Boolean;
var
    i, Len: Integer;
begin
    Value := '';

    Len := Length(ParameterName) + 1;
    ParameterName := UpperCase(ParameterName);

    for i := 1 to ParamCount do begin
        if ParameterName = UpperCase(ParamStr(i)) then begin
            Result := True;
            Exit;
        end else if Copy(ParamStr(i), 1, Len) = (ParameterName + '=') then begin
            Result := True;
            Value := Copy(ParamStr(i), Len+1, 99);
            Exit;
        end;
    end;

    Result := False;
end;

end.
