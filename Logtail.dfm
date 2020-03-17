inherited frmLogtail: TfrmLogtail
  Caption = 'Logtail Source'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    object WebBrowser1: TWebBrowser
      Left = 1
      Top = 1
      Width = 831
      Height = 468
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 0
      ControlData = {
        4C000000C2260000C15100000000000000000000000000000000000000000000
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
