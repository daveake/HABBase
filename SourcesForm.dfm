inherited frmSources: TfrmSources
  Caption = 'Sources'
  ClientWidth = 302
  OnDestroy = FormDestroy
  ExplicitWidth = 318
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 302
    ExplicitWidth = 302
    inherited Panel1: TPanel
      Width = 302
      ExplicitWidth = 302
      inherited lblTitle: TLabel
        Width = 285
        Caption = 'Sources'
        ExplicitWidth = 46
      end
    end
    object scrollMain: TScrollBox
      Left = 0
      Top = 24
      Width = 302
      Height = 446
      Align = alClient
      TabOrder = 1
      object btnAddSource: TAdvSmoothButton
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 286
        Height = 40
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Align = alTop
        Appearance.Font.Charset = DEFAULT_CHARSET
        Appearance.Font.Color = 2303013
        Appearance.Font.Height = -11
        Appearance.Font.Name = 'Tahoma'
        Appearance.Font.Style = []
        Appearance.Rounding = 0
        Status.Caption = '0'
        Status.Appearance.Fill.Color = clRed
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.GradientType = gtSolid
        Status.Appearance.Fill.GradientMirrorType = gtSolid
        Status.Appearance.Fill.BorderColor = clGray
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWhite
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Tahoma'
        Status.Appearance.Font.Style = []
        Caption = 'Add Source'
        ParentFont = False
        TabOrder = 0
        Version = '2.2.1.2'
        OnClick = btnAddSourceClick
        TMSStyle = 8
      end
    end
  end
  object tmrSSDV: TTimer
    Interval = 60000
    OnTimer = tmrSSDVTimer
    Left = 192
    Top = 288
  end
end
