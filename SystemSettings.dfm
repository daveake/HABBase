object frmSystemSettings: TfrmSystemSettings
  Left = 0
  Top = 0
  Caption = 'System Settings'
  ClientHeight = 220
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCommon: TAdvPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 220
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
      447
      216)
    FullHeight = 337
    object Label9: TLabel
      Left = 62
      Top = 14
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Callsign:'
    end
    object Label1: TLabel
      Left = 59
      Top = 41
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Latitude:'
    end
    object Label2: TLabel
      Left = 51
      Top = 68
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Longitude:'
    end
    object Label3: TLabel
      Left = 61
      Top = 95
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Altitude:'
    end
    object Label4: TLabel
      Left = 27
      Top = 122
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payload Expiry:'
    end
    object Label5: TLabel
      Left = 163
      Top = 95
      Width = 8
      Height = 13
      Caption = 'm'
    end
    object Label6: TLabel
      Left = 163
      Top = 119
      Width = 16
      Height = 13
      Caption = 'min'
    end
    object Label7: TLabel
      Left = 22
      Top = 149
      Width = 80
      Height = 13
      Alignment = taRightJustify
      Caption = 'UDP Output Port'
    end
    object btnSave: TAdvSmoothButton
      AlignWithMargins = True
      Left = 257
      Top = 167
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
      TabOrder = 0
      Enabled = False
      Version = '2.2.1.2'
      OnClick = btnSaveClick
      TMSStyle = 8
    end
    object btnCancel: TAdvSmoothButton
      AlignWithMargins = True
      Left = 351
      Top = 167
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
      TabOrder = 1
      Version = '2.2.1.2'
      ModalResult = 2
      OnClick = btnCancelClick
      TMSStyle = 8
    end
    object DBEdit1: TDBEdit
      Left = 108
      Top = 8
      Width = 121
      Height = 21
      DataField = 'Callsign'
      DataSource = DataModule1.srcSettings
      TabOrder = 2
      OnChange = DBEdit1Change
    end
    object DBEdit2: TDBEdit
      Left = 108
      Top = 35
      Width = 121
      Height = 21
      DataField = 'Latitude'
      DataSource = DataModule1.srcSettings
      TabOrder = 3
      OnChange = DBEdit1Change
      OnKeyPress = DBEdit2KeyPress
    end
    object DBEdit3: TDBEdit
      Left = 108
      Top = 62
      Width = 121
      Height = 21
      DataField = 'Longitude'
      DataSource = DataModule1.srcSettings
      TabOrder = 4
      OnChange = DBEdit1Change
      OnKeyPress = DBEdit2KeyPress
    end
    object DBEdit4: TDBEdit
      Left = 108
      Top = 89
      Width = 49
      Height = 21
      DataField = 'Altitude'
      DataSource = DataModule1.srcSettings
      TabOrder = 5
      OnChange = DBEdit1Change
    end
    object DBEdit5: TDBEdit
      Left = 108
      Top = 116
      Width = 49
      Height = 21
      DataField = 'Expiry'
      DataSource = DataModule1.srcSettings
      TabOrder = 6
      OnChange = DBEdit1Change
    end
    object DBEdit6: TDBEdit
      Left = 108
      Top = 143
      Width = 49
      Height = 21
      DataField = 'UDPPort'
      DataSource = DataModule1.srcSettings
      TabOrder = 7
      OnChange = DBEdit1Change
    end
  end
end
