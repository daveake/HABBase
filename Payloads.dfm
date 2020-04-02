inherited frmPayloads: TfrmPayloads
  Caption = 'Payloads'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited Panel1: TPanel
      inherited lblTitle: TLabel
        Width = 816
        Caption = 'Payloads'
        ExplicitWidth = 50
      end
    end
    object scrollMain: TScrollBox
      Left = 0
      Top = 24
      Width = 833
      Height = 446
      Align = alClient
      TabOrder = 1
    end
  end
  object tmrUpdates: TTimer
    OnTimer = tmrUpdatesTimer
    Left = 616
    Top = 272
  end
end
