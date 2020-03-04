object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'HAB Base Station Manager'
  ClientHeight = 791
  ClientWidth = 1039
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
    Left = 265
    Top = 0
    Width = 17
    Height = 791
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = clWhite
    Appearance.ColorTo = clSilver
    Appearance.ColorHot = clWhite
    Appearance.ColorHotTo = clGray
    GripStyle = sgDots
    ExplicitLeft = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 791
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object AdvSplitter2: TAdvSplitter
      Left = 0
      Top = 297
      Width = 265
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
    end
    object AdvSplitter3: TAdvSplitter
      Left = 0
      Top = 681
      Width = 265
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
      ExplicitTop = 434
    end
    object Panel3: TPanel
      Left = 0
      Top = 313
      Width = 265
      Height = 368
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 209
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 265
        Height = 368
        Align = alClient
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
        ExplicitLeft = 160
        ExplicitTop = 48
        ExplicitWidth = 185
        ExplicitHeight = 89
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 265
      Height = 297
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lstPayloadIDs: TListBox
        Left = 0
        Top = 0
        Width = 265
        Height = 297
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        ExplicitLeft = 160
        ExplicitTop = 152
        ExplicitWidth = 121
        ExplicitHeight = 97
      end
    end
    object pnlSources: TPanel
      Left = 0
      Top = 697
      Width = 265
      Height = 94
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitTop = 593
      ExplicitHeight = 198
    end
  end
  object Panel2: TPanel
    Left = 282
    Top = 0
    Width = 757
    Height = 791
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object AdvSplitter4: TAdvSplitter
      Left = 0
      Top = 281
      Width = 757
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
      Top = 522
      Width = 757
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
      ExplicitTop = 434
      ExplicitWidth = 265
    end
    object Panel6: TPanel
      Left = 0
      Top = 297
      Width = 757
      Height = 225
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 0
        Width = 757
        Height = 225
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 344
        ExplicitTop = 43
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C0000007D4600000B1D00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 757
      Height = 281
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lstPositions: TListBox
        Left = 0
        Top = 0
        Width = 757
        Height = 281
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        ExplicitLeft = 160
        ExplicitTop = 152
        ExplicitWidth = 121
        ExplicitHeight = 97
      end
    end
    object Panel8: TPanel
      Left = 0
      Top = 538
      Width = 757
      Height = 253
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 354
    Top = 344
  end
end
