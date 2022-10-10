unit BaseTypes;

interface

type
    TSourceType = (stLogtail, stGateway, stSerial, stTCP, stUDP, stHabitat, stAPRS, stMQTT, stWSMQTT, stSondehub);

    TPayloadMask = record
        HAB:            Boolean;
        Sonde:          Boolean;
        Remote:         Boolean;
        Mask:           String;
        Distance:       Double;
    end;

implementation

end.
