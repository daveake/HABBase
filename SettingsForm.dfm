object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  Caption = 'Settings'
  ClientHeight = 392
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCommon: TAdvPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 392
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clSilver
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
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -16
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Height = 14
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clHighlight
    CollapsDelay = 0
    ColorTo = 14540253
    ColorMirror = 14540253
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
    DesignSize = (
      637
      388)
    FullHeight = 337
    object Label9: TLabel
      Left = 25
      Top = 14
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Code:'
    end
    object Label10: TLabel
      Left = 135
      Top = 14
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Name:'
    end
    object edtCode: TEdit
      Left = 60
      Top = 11
      Width = 41
      Height = 21
      MaxLength = 2
      TabOrder = 0
      OnChange = edtCodeChange
    end
    object edtName: TEdit
      Left = 172
      Top = 11
      Width = 176
      Height = 21
      TabOrder = 1
      OnChange = edtCodeChange
    end
    object chKEnabled: TAdvOfficeCheckBox
      Left = 372
      Top = 11
      Width = 120
      Height = 20
      TabOrder = 2
      OnClick = chKEnabledClick
      Alignment = taLeftJustify
      Caption = 'Enabled'
      ReturnIsTab = False
      Version = '1.7.0.2'
    end
    object btnSave: TAdvSmoothButton
      AlignWithMargins = True
      Left = 447
      Top = 339
      Width = 82
      Height = 38
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -11
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
      Caption = 'Save'
      ParentFont = False
      TabOrder = 3
      Enabled = False
      Version = '2.2.1.2'
      OnClick = btnSaveClick
      TMSStyle = 8
    end
    object btnCancel: TAdvSmoothButton
      AlignWithMargins = True
      Left = 541
      Top = 339
      Width = 82
      Height = 38
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akRight, akBottom]
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -11
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
      TabOrder = 4
      Version = '2.2.1.2'
      ModalResult = 2
      TMSStyle = 8
    end
  end
end
