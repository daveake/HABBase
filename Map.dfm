inherited frmMap: TfrmMap
  Caption = 'frmMap'
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited Panel1: TPanel
      inherited lblTitle: TLabel
        Width = 816
        Caption = 'Map'
        ExplicitWidth = 24
      end
    end
  end
  object tmrCentreAtHome: TTimer
    Interval = 100
    OnTimer = tmrCentreAtHomeTimer
    Left = 580
    Top = 184
  end
end
