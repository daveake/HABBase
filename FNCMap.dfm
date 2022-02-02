inherited frmFNCMap: TfrmFNCMap
  ActiveControl = FNCMap
  Caption = 'frmFNCMap'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    object FNCMap: TTMSFNCMaps
      Left = 0
      Top = 24
      Width = 833
      Height = 446
      Align = alClient
      ParentDoubleBuffered = False
      DoubleBuffered = True
      TabOrder = 1
      OnMapInitialized = FNCMapMapInitialized
      Polylines = <>
      Polygons = <>
      Circles = <>
      Rectangles = <>
      Markers = <>
      Options.DefaultLatitude = 52.000000000000000000
      Options.DefaultLongitude = 0.000000000000000000
      Options.DefaultZoomLevel = 12.000000000000000000
      Service = msOpenLayers
      LocalFileAccess = True
      ExplicitTop = 26
    end
  end
  object tmrCentreAtHome: TTimer
    Interval = 100
    OnTimer = tmrCentreAtHomeTimer
    Left = 580
    Top = 184
  end
end
