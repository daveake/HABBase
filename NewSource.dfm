object frmNewSource: TfrmNewSource
  Left = 0
  Top = 0
  Caption = 'New Source'
  ClientHeight = 179
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 36
    Top = 56
    Width = 152
    Height = 19
    Caption = 'Type Of New Source:'
  end
  object ComboBox1: TComboBox
    Left = 216
    Top = 53
    Width = 261
    Height = 27
    Style = csDropDownList
    TabOrder = 0
    OnClick = ComboBox1Click
    Items.Strings = (
      'Logtail'
      'LoRa Gateway'
      'Lora Serial'
      'TCP (DL-FLDigi)'
      'UDP (HABDEC, Sonde)'
      'Habitat'
      'APRS')
  end
  object btnOK: TAdvSmoothButton
    AlignWithMargins = True
    Left = 303
    Top = 121
    Width = 82
    Height = 36
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
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
    TabOrder = 1
    Enabled = False
    Version = '2.2.1.2'
    ModalResult = 1
    TMSStyle = 8
  end
  object AdvSmoothButton1: TAdvSmoothButton
    AlignWithMargins = True
    Left = 395
    Top = 121
    Width = 82
    Height = 36
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
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
    TabOrder = 2
    Version = '2.2.1.2'
    ModalResult = 2
    TMSStyle = 8
  end
end
