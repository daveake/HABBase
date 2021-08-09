inherited frmAPRSSettings: TfrmAPRSSettings
  Caption = 'APRS / OGN Settings'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    FullHeight = 337
    object Label3: TLabel [4]
      Left = 43
      Top = 99
      Width = 294
      Height = 38
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'For APRS, use your local APRS server e.g.euro.aprs2.net.   For O' +
        'GN, use aprs.glidernet.org.  Port is normally 14580.'
      WordWrap = True
    end
    inherited btnSave: TAdvSmoothButton
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      TMSStyle = 8
    end
    inherited edtPort: TEdit
      Text = '14580'
    end
  end
end
