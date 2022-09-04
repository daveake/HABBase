object frmSystemSettings: TfrmSystemSettings
  Left = 0
  Top = 0
  Caption = 'System Settings'
  ClientHeight = 310
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  TextHeight = 13
  object pnlCommon: TAdvPanel
    Left = 0
    Top = 0
    Width = 597
    Height = 310
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
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
    Version = '2.6.3.1'
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
      593
      306)
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
    object Label8: TLabel
      Left = 36
      Top = 179
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'MQTT Broker:'
    end
    object Label10: TLabel
      Left = 73
      Top = 206
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Topic:'
    end
    object Label11: TLabel
      Left = 46
      Top = 233
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'User Name:'
    end
    object Label12: TLabel
      Left = 52
      Top = 260
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Password:'
    end
    object btnSave: TAdvSmoothButton
      AlignWithMargins = True
      Left = 403
      Top = 257
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
      Caption = 'Save'
      ParentFont = False
      TabOrder = 0
      Enabled = False
      Version = '2.2.3.1'
      OnClick = btnSaveClick
      TMSStyle = 8
    end
    object btnCancel: TAdvSmoothButton
      AlignWithMargins = True
      Left = 497
      Top = 257
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
      ParentFont = False
      TabOrder = 1
      Version = '2.2.3.1'
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
    object DBEdit7: TDBEdit
      Left = 108
      Top = 173
      Width = 121
      Height = 21
      DataField = 'MQTTHost'
      DataSource = DataModule1.srcSettings
      TabOrder = 8
      OnChange = DBEdit1Change
    end
    object DBEdit8: TDBEdit
      Left = 108
      Top = 200
      Width = 267
      Height = 21
      DataField = 'MQTTTopic'
      DataSource = DataModule1.srcSettings
      TabOrder = 9
      OnChange = DBEdit1Change
      OnKeyPress = DBEdit2KeyPress
    end
    object DBEdit9: TDBEdit
      Left = 108
      Top = 227
      Width = 121
      Height = 21
      DataField = 'MQTTUserName'
      DataSource = DataModule1.srcSettings
      TabOrder = 10
      OnChange = DBEdit1Change
      OnKeyPress = DBEdit2KeyPress
    end
    object DBEdit10: TDBEdit
      Left = 108
      Top = 254
      Width = 121
      Height = 21
      DataField = 'MQTTPassword'
      DataSource = DataModule1.srcSettings
      TabOrder = 11
      OnChange = DBEdit1Change
    end
    object DBAdvOfficeCheckBox1: TDBAdvOfficeCheckBox
      Left = 304
      Top = 9
      Width = 174
      Height = 20
      TabOrder = 12
      Alignment = taLeftJustify
      Caption = 'Enable HABHUB Uploads'
      ReturnIsTab = False
      State = cbGrayed
      Version = '1.1.1.4'
      DataField = 'UplinkHABHUB'
      DataSource = DataModule1.srcSettings
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBAdvOfficeCheckBox2: TDBAdvOfficeCheckBox
      Left = 304
      Top = 42
      Width = 174
      Height = 20
      TabOrder = 13
      Alignment = taLeftJustify
      Caption = 'Enable HABLINK Uploads'
      ReturnIsTab = False
      State = cbGrayed
      Version = '1.1.1.4'
      DataField = 'UplinkHABLINK'
      DataSource = DataModule1.srcSettings
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBAdvOfficeCheckBox3: TDBAdvOfficeCheckBox
      Left = 304
      Top = 144
      Width = 174
      Height = 20
      TabOrder = 14
      Alignment = taLeftJustify
      Caption = 'Enable SSDV Uploads'
      ReturnIsTab = False
      State = cbGrayed
      Version = '1.1.1.4'
      DataField = 'UplinkSSDV'
      DataSource = DataModule1.srcSettings
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBAdvOfficeCheckBox4: TDBAdvOfficeCheckBox
      Left = 304
      Top = 75
      Width = 174
      Height = 20
      TabOrder = 15
      Alignment = taLeftJustify
      Caption = 'Enable MQTT Uploads'
      ReturnIsTab = False
      State = cbGrayed
      Version = '1.1.1.4'
      DataField = 'UplinkMQTT'
      DataSource = DataModule1.srcSettings
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBAdvOfficeCheckBox5: TDBAdvOfficeCheckBox
      Left = 304
      Top = 112
      Width = 174
      Height = 20
      TabOrder = 16
      Alignment = taLeftJustify
      Caption = 'Enable Sondehub Uploads'
      ReturnIsTab = False
      State = cbGrayed
      Version = '1.1.1.4'
      DataField = 'UplinkSondehub'
      DataSource = DataModule1.srcSettings
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
end
