inherited frmLogtail: TfrmLogtail
  Caption = 'Logtail Source'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    object WebBrowser1: TWebBrowser
      Left = 0
      Top = 0
      Width = 833
      Height = 470
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 831
      ExplicitHeight = 468
      ControlData = {
        4C00000018560000933000000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 354
    Top = 344
  end
end
