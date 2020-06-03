inherited frmMap: TfrmMap
  Caption = 'frmMap'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    object GMap: TWebGMaps [0]
      Left = 0
      Top = 24
      Width = 833
      Height = 446
      Align = alClient
      APIVersion = '3.34'
      Clusters = <>
      Markers = <>
      Polylines = <>
      Polygons = <>
      Directions = <>
      MapOptions.ZoomMap = 8
      MapOptions.DefaultLatitude = 48.859040000000000000
      MapOptions.DefaultLongitude = 2.294297000000000000
      Routing.PolylineOptions.Icons = <>
      StreetViewOptions.DefaultLatitude = 48.859040000000000000
      StreetViewOptions.DefaultLongitude = 2.294297000000000000
      MapPersist.Location = mplInifile
      MapPersist.Key = 'WebGMaps'
      MapPersist.Section = 'MapBounds'
      PolygonLabel.Font.Charset = DEFAULT_CHARSET
      PolygonLabel.Font.Color = clBlack
      PolygonLabel.Font.Height = -16
      PolygonLabel.Font.Name = 'Arial'
      PolygonLabel.Font.Style = []
      TabOrder = 0
      Version = '3.1.5.0'
      OnDownloadStart = GMapDownloadStart
      OnDownloadFinish = GMapDownloadFinish
      OnMarkerClick = GMapMarkerClick
    end
    inherited Panel1: TPanel
      TabOrder = 1
      inherited lblTitle: TLabel
        Width = 816
        Caption = 'Map'
        ExplicitWidth = 24
      end
    end
  end
end
