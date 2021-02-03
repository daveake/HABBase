unit BaseTypes;

interface

type
    TSourceType = (stLogtail, stGateway, stSerial, stTCP, stUDP, stHabitat, stAPRS);

    TPayloadMask = record
        HAB:            Boolean;
        Sonde:          Boolean;
        Remote:         Boolean;
        Mask:           String;
        Distance:       Double;
    end;

implementation

end.
