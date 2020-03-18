unit BaseTypes;

interface

type
    TSourceType = (stLogtail, stGateway, stTCP, stUDP, stSerial);       // stDLFLDigi, stSerial, stHabitat, stUDP);

    TPayloadMask = record
        HAB:            Boolean;
        Sonde:          Boolean;
        Local:          Boolean;
        Mask:           String;
        Distance:       Double;
    end;

implementation

end.
