inherited frmPayloads: TfrmPayloads
  Caption = 'Payloads'
  ClientWidth = 296
  OnCreate = FormCreate
  ExplicitWidth = 312
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 296
    ExplicitWidth = 296
    inherited Panel1: TPanel
      Width = 296
      ExplicitWidth = 296
      inherited lblTitle: TLabel
        Width = 279
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
      OnClick = scrollMainClick
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
  object UDPClient: TIdUDPClient
    Port = 0
    Left = 60
    Top = 366
  end
  object tmrPredictions: TTimer
    Interval = 500
    OnTimer = tmrPredictionsTimer
    Left = 168
    Top = 312
  end
end
