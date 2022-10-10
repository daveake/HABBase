inherited frmWSMQTTSettings: TfrmWSMQTTSettings
  Caption = 'WS MQTT Settings'
  ClientHeight = 219
  ClientWidth = 511
  ExplicitWidth = 527
  ExplicitHeight = 258
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    Width = 511
    Height = 219
    ExplicitWidth = 511
    ExplicitHeight = 219
    FullHeight = 337
    object Label1: TLabel [2]
      Left = 23
      Top = 62
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Broker'
    end
    object Label2: TLabel [3]
      Left = 24
      Top = 95
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Topics'
    end
    object Label3: TLabel [4]
      Left = 261
      Top = 95
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'User Name'
    end
    object Label4: TLabel [5]
      Left = 267
      Top = 129
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Password'
    end
    object Label5: TLabel [6]
      Left = 291
      Top = 62
      Width = 20
      Height = 13
      Alignment = taRightJustify
      Caption = 'Port'
    end
    inherited btnSave: TAdvSmoothButton
      Left = 317
      Top = 166
      ExplicitLeft = 317
      ExplicitTop = 166
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      Left = 411
      Top = 166
      ExplicitLeft = 411
      ExplicitTop = 166
      TMSStyle = 8
    end
    object edtHost: TEdit
      Left = 60
      Top = 59
      Width = 173
      Height = 21
      TabOrder = 5
      OnChange = edtHostChange
    end
    object edtTopic: TEdit
      Left = 60
      Top = 92
      Width = 173
      Height = 21
      TabOrder = 6
    end
    object edtUserName: TEdit
      Left = 319
      Top = 92
      Width = 173
      Height = 21
      TabOrder = 7
    end
    object edtPassword: TEdit
      Left = 319
      Top = 126
      Width = 173
      Height = 21
      TabOrder = 8
    end
    object AdvSmoothButton1: TAdvSmoothButton
      AlignWithMargins = True
      Left = 60
      Top = 162
      Width = 173
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
      Caption = 'Set for SONDEHUB'
      ParentFont = False
      TabOrder = 9
      Version = '2.2.3.1'
      OnClick = AdvSmoothButton1Click
      TMSStyle = 8
    end
    object edtPort: TEdit
      Left = 320
      Top = 59
      Width = 173
      Height = 21
      TabOrder = 10
      OnChange = edtHostChange
    end
  end
end
