inherited frmToolSettings: TfrmToolSettings
  Caption = 'Settings'
  ClientHeight = 82
  ExplicitHeight = 121
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Height = 82
    Font.Height = -16
    ParentFont = False
    OnResize = pnlMainResize
    ExplicitHeight = 82
    inherited Panel1: TPanel
      inherited lblTitle: TLabel
        Width = 303
        Caption = 'Settings'
        ExplicitWidth = 46
      end
      inherited Button1: TButton
        Visible = False
        ExplicitLeft = 322
        ExplicitHeight = 19
      end
    end
    object btnSettings: TAdvSmoothButton
      AlignWithMargins = True
      Left = 6
      Top = 27
      Width = 147
      Height = 49
      Margins.Left = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alLeft
      Appearance.PictureAlignment = taCenter
      Appearance.SimpleLayout = False
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
      Caption = 'System Settings'
      TabOrder = 1
      Version = '2.2.3.1'
      OnClick = btnSettingsClick
      TMSStyle = 8
    end
    object btnFilters: TAdvSmoothButton
      AlignWithMargins = True
      Left = 165
      Top = 27
      Width = 180
      Height = 49
      Margins.Left = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Appearance.PictureAlignment = taCenter
      Appearance.SimpleLayout = False
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
      Caption = 'Balloon Filters'
      TabOrder = 2
      Version = '2.2.3.1'
      OnClick = btnFiltersClick
      TMSStyle = 8
    end
  end
end
