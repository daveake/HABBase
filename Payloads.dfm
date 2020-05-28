inherited frmPayloads: TfrmPayloads
  Caption = 'Payloads'
  ClientWidth = 296
  ExplicitWidth = 312
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 296
    ExplicitWidth = 296
    inherited Panel1: TPanel
      Width = 296
      ExplicitWidth = 296
      inherited lblTitle: TLabel
        Width = 50
        Caption = 'Payloads'
        ExplicitWidth = 50
      end
    end
    object scrollMain: TScrollBox
      Left = 0
      Top = 24
      Width = 296
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
  object tmrExpired: TTimer
    Interval = 10000
    OnTimer = tmrExpiredTimer
    Left = 216
    Top = 368
  end
end
