object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'HAB Base Station Manager'
  ClientHeight = 847
  ClientWidth = 1398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSplitter1: TAdvSplitter
    Left = 329
    Top = 41
    Width = 16
    Height = 757
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = clWhite
    Appearance.ColorTo = clSilver
    Appearance.ColorHot = clWhite
    Appearance.ColorHotTo = clGray
    GripStyle = sgDots
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 41
    Width = 329
    Height = 757
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object AdvSplitter2: TAdvSplitter
      Left = 0
      Top = 361
      Width = 329
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 193
      ExplicitWidth = 265
    end
    object AdvSplitter3: TAdvSplitter
      Left = 0
      Top = 561
      Width = 329
      Height = 16
      Cursor = crVSplit
      Align = alBottom
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 434
      ExplicitWidth = 265
    end
    object AdvSplitter6: TAdvSplitter
      Left = 0
      Top = 169
      Width = 329
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitLeft = 32
      ExplicitWidth = 265
    end
    object pnlLog: TPanel
      Left = 0
      Top = 377
      Width = 329
      Height = 184
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlWhiteList: TPanel
      Left = 0
      Top = 185
      Width = 329
      Height = 176
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object pnlSources: TPanel
      Left = 0
      Top = 577
      Width = 329
      Height = 180
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
    end
    object pnlPayloads: TPanel
      Left = 0
      Top = 0
      Width = 329
      Height = 169
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
    end
  end
  object pnlMain: TPanel
    Left = 345
    Top = 41
    Width = 1053
    Height = 757
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object AdvSplitter4: TAdvSplitter
      Left = 0
      Top = 201
      Width = 1053
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 193
      ExplicitWidth = 265
    end
    object AdvSplitter5: TAdvSplitter
      Left = 0
      Top = 536
      Width = 1053
      Height = 16
      Cursor = crVSplit
      Align = alBottom
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitLeft = 6
      ExplicitTop = 458
      ExplicitWidth = 694
    end
    object pnlMiddle: TPanel
      Left = 0
      Top = 217
      Width = 1053
      Height = 319
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 1053
      Height = 201
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object pnlBottom: TPanel
      Left = 0
      Top = 552
      Width = 1053
      Height = 205
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object pnlStatus: TAdvPanel
    Left = 0
    Top = 798
    Width = 1398
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
    TabOrder = 2
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
    FullHeight = 42
    object pnlHidden: TPanel
      Left = 1398
      Top = 0
      Width = 0
      Height = 49
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object pnlButtons: TAdvPanel
    Left = 0
    Top = 0
    Width = 1398
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
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
    FullHeight = 42
  end
end
