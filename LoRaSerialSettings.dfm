inherited frmLoRaSerialSettings: TfrmLoRaSerialSettings
  Caption = 'LoRa Serial Settings'
  ClientHeight = 155
  OnCreate = FormCreate
  ExplicitHeight = 194
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    Height = 155
    ExplicitHeight = 155
    FullHeight = 337
    object Label2: TLabel [2]
      Left = 6
      Top = 62
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = 'Com Port:'
    end
    object Label3: TLabel [3]
      Left = 28
      Top = 102
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'Freq:'
    end
    object Label4: TLabel [4]
      Left = 252
      Top = 102
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Mode:'
    end
    object Label1: TLabel [5]
      Left = 258
      Top = 62
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'PPM:'
    end
    object Label5: TLabel [6]
      Left = 386
      Top = 62
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Offset:'
    end
    inherited btnSave: TAdvSmoothButton
      Top = 102
      ExplicitTop = 102
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      Top = 102
      ExplicitTop = 102
      TMSStyle = 8
    end
    object edtFrequency1: TEdit
      Left = 60
      Top = 99
      Width = 106
      Height = 21
      MaxLength = 8
      TabOrder = 5
      OnChange = edtPortChange
    end
    object edtMode1: TEdit
      Left = 288
      Top = 99
      Width = 60
      Height = 21
      MaxLength = 1
      TabOrder = 6
      OnChange = edtPortChange
    end
    object cmbPort: TComboBox
      Left = 60
      Top = 59
      Width = 106
      Height = 22
      Style = csOwnerDrawFixed
      Sorted = True
      TabOrder = 7
    end
    object edtPPM1: TEdit
      Left = 288
      Top = 59
      Width = 60
      Height = 21
      MaxLength = 4
      TabOrder = 8
      OnChange = edtPortChange
    end
    object chkUpload: TAdvOfficeCheckBox
      Left = 472
      Top = 12
      Width = 120
      Height = 20
      TabOrder = 9
      OnClick = chKEnabledClick
      Alignment = taLeftJustify
      Caption = 'Upload To Server(s)'
      ReturnIsTab = False
      Version = '1.8.4.0'
    end
    object edtOffset: TEdit
      Left = 427
      Top = 59
      Width = 60
      Height = 21
      Enabled = False
      MaxLength = 1
      ReadOnly = True
      TabOrder = 10
      OnChange = edtPortChange
    end
  end
end
