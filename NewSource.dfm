object frmNewSource: TfrmNewSource
  Left = 0
  Top = 0
  Caption = 'New Source'
  ClientHeight = 287
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    521
    287)
  TextHeight = 19
  object Label1: TLabel
    Left = 24
    Top = 36
    Width = 152
    Height = 19
    Caption = 'Type Of New Source:'
  end
  object ComboBox1: TComboBox
    Left = 216
    Top = 33
    Width = 285
    Height = 27
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    DropDownCount = 12
    TabOrder = 0
    OnClick = ComboBox1Click
    Items.Strings = (
      'LoRa Gateway'
      'Lora Serial'
      'TCP (DL-FLDigi, FLDigi)'
      'UDP ( rdzTTGOSonde, HABDEC)'
      'APRS / OGN'
      'MQTT (e.g. hablink)'
      'WS MQTT (e.g. Sondehub)'
      'Sondehub Area Polling')
  end
  object btnOK: TAdvSmoothButton
    AlignWithMargins = True
    Left = 327
    Top = 234
    Width = 82
    Height = 36
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Anchors = [akRight, akBottom]
    Appearance.SimpleLayout = False
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
    Version = '2.2.3.1'
    ModalResult = 1
    TMSStyle = 8
  end
  object AdvSmoothButton1: TAdvSmoothButton
    AlignWithMargins = True
    Left = 419
    Top = 234
    Width = 82
    Height = 36
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Anchors = [akRight, akBottom]
    Appearance.SimpleLayout = False
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
    Version = '2.2.3.1'
    ModalResult = 2
    TMSStyle = 8
  end
  object pnlAbout: TPanel
    Left = 20
    Top = 84
    Width = 481
    Height = 125
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 3
    object lblAbout: TLabel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 467
      Height = 111
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Alignment = taCenter
      WordWrap = True
      ExplicitWidth = 5
      ExplicitHeight = 19
    end
  end
end
