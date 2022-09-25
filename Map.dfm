inherited frmMap: TfrmMap
  Caption = 'frmMap'
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited Panel1: TPanel
      inherited lblTitle: TLabel
        Width = 24
        Caption = 'Map'
        ExplicitWidth = 24
      end
    end
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
      ElementContainers = <>
      HeadLinks = <>
      Options.DefaultLatitude = 52.000000000000000000
      Options.DefaultLongitude = 0.000000000000000000
      Options.DefaultZoomLevel = 12.000000000000000000
      Service = msOpenLayers
      LocalFileAccess = True
    end
  end
  object tmrCentreAtHome: TTimer
    Interval = 100
    OnTimer = tmrCentreAtHomeTimer
    Left = 580
    Top = 184
  end
end
