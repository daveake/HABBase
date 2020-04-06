inherited frmLogtail: TfrmLogtail
  Caption = 'Logtail Source'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    object WebBrowser1: TWebBrowser [0]
      Left = 1
      Top = 45
      Width = 382
      Height = 0
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 348
      ControlData = {
        4C0000007B270000000000000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126200000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    inherited DBAdvGrid3: TDBAdvGrid
      TabOrder = 2
    end
  end
  object Timer1: TTimer [1]
    OnTimer = Timer1Timer
    Left = 354
    Top = 344
  end
  inherited menuSource: TPopupMenu
    inherited DeleteSource: TMenuItem
      OnClick = nil
    end
  end
end
