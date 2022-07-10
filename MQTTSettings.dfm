inherited frmMQTTSettings: TfrmMQTTSettings
  Caption = 'MQTT Settings'
  ClientHeight = 193
  ClientWidth = 511
  ExplicitWidth = 527
  ExplicitHeight = 232
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    Width = 511
    Height = 193
    ExplicitWidth = 511
    ExplicitHeight = 193
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
      Left = 29
      Top = 94
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'Topic'
    end
    object Label3: TLabel [4]
      Left = 261
      Top = 62
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'User Name'
    end
    object Label4: TLabel [5]
      Left = 267
      Top = 94
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Password'
    end
    inherited btnSave: TAdvSmoothButton
      Left = 317
      Top = 140
      ExplicitLeft = 317
      ExplicitTop = 140
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      Left = 411
      Top = 140
      ExplicitLeft = 411
      ExplicitTop = 140
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
      Top = 91
      Width = 173
      Height = 21
      TabOrder = 6
    end
    object edtUserName: TEdit
      Left = 319
      Top = 59
      Width = 173
      Height = 21
      TabOrder = 7
    end
    object edtPassword: TEdit
      Left = 319
      Top = 91
      Width = 173
      Height = 21
      TabOrder = 8
    end
  end
end
