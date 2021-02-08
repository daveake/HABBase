object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'HAB Base Station Manager V1.3.3'
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
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSplitter1: TAdvSplitter
    Left = 329
    Top = 0
    Width = 16
    Height = 847
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = clWhite
    Appearance.ColorTo = clSilver
    Appearance.ColorHot = clWhite
    Appearance.ColorHotTo = clGray
    GripStyle = sgDots
    ExplicitTop = 41
    ExplicitHeight = 757
  end
  object AdvSplitter10: TAdvSplitter
    Left = 1053
    Top = 0
    Width = 16
    Height = 847
    Align = alRight
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = clWhite
    Appearance.ColorTo = clSilver
    Appearance.ColorHot = clWhite
    Appearance.ColorHotTo = clGray
    GripStyle = sgDots
    ExplicitLeft = 1075
    ExplicitTop = 8
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 847
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object pnlSettings: TPanel
      Left = 0
      Top = 788
      Width = 329
      Height = 59
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
    end
    object pnlSources: TPanel
      Left = 0
      Top = 0
      Width = 329
      Height = 788
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object pnlMain: TPanel
    Left = 345
    Top = 0
    Width = 708
    Height = 847
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlMiddle: TPanel
      Left = 0
      Top = 0
      Width = 708
      Height = 847
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
  object pnlRight: TPanel
    Left = 1069
    Top = 0
    Width = 329
    Height = 847
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
  end
end
