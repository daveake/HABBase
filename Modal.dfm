object frmModal: TfrmModal
  Left = 0
  Top = 0
  Caption = 'Modal Form'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlStatus: TAdvPanel
    Left = 0
    Top = 250
    Width = 635
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '2.5.10.2'
    BorderColor = clGray
    Caption.Color = 15722471
    Caption.ColorTo = 11176072
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clBlack
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Height = 24
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clHighlight
    CollapsDelay = 0
    ColorTo = 13948116
    ColorMirror = 13948116
    ColorMirrorTo = clSilver
    DoubleBuffered = True
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 12560553
    StatusBar.ColorTo = 14602191
    StatusBar.GradientDirection = gdVertical
    Text = ''
    ExplicitLeft = -404
    ExplicitWidth = 1039
    FullHeight = 42
    object pnlHidden: TPanel
      Left = 383
      Top = 0
      Width = 0
      Height = 49
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 1039
    end
    object AdvSmoothButton1: TAdvSmoothButton
      AlignWithMargins = True
      Left = 512
      Top = 3
      Width = 120
      Height = 43
      Align = alRight
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -16
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = []
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
      Caption = 'Cancel'
      ParentFont = False
      Shadow = True
      TabOrder = 1
      ShowFocus = False
      Version = '2.2.1.2'
      OnClick = AdvSmoothButton1Click
      ExplicitLeft = 544
      ExplicitTop = 16
      ExplicitHeight = 35
      TMSStyle = 8
    end
    object AdvSmoothButton2: TAdvSmoothButton
      AlignWithMargins = True
      Left = 386
      Top = 3
      Width = 120
      Height = 43
      Align = alRight
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -16
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = []
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
      Caption = 'OK'
      ParentFont = False
      Shadow = True
      TabOrder = 2
      ShowFocus = False
      Version = '2.2.1.2'
      OnClick = AdvSmoothButton2Click
      ExplicitLeft = 544
      ExplicitTop = 16
      ExplicitHeight = 35
      TMSStyle = 8
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 250
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -198
    ExplicitTop = -171
    ExplicitWidth = 833
    ExplicitHeight = 470
  end
end
