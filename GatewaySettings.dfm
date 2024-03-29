inherited frmGatewaySettings: TfrmGatewaySettings
  Caption = 'Gateway Settings'
  ClientHeight = 177
  ClientWidth = 664
  ExplicitWidth = 680
  ExplicitHeight = 216
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    Width = 664
    Height = 177
    ExplicitWidth = 664
    ExplicitHeight = 177
    FullHeight = 337
    object Label1: TLabel [2]
      Left = 32
      Top = 62
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'Host'
    end
    object Label2: TLabel [3]
      Left = 258
      Top = 62
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'Port:'
    end
    object Label3: TLabel [4]
      Left = 3
      Top = 102
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Ch 0 Freq:'
    end
    object Label4: TLabel [5]
      Left = 252
      Top = 102
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Mode:'
    end
    object Label5: TLabel [6]
      Left = 3
      Top = 126
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Ch 1 Freq:'
    end
    object Label6: TLabel [7]
      Left = 252
      Top = 129
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Mode:'
    end
    inherited edtCode: TEdit
      OnChange = edtHostChange
    end
    inherited edtName: TEdit
      OnChange = edtHostChange
    end
    inherited btnSave: TAdvSmoothButton
      Left = 478
      Top = 124
      ExplicitLeft = 478
      ExplicitTop = 124
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      Left = 564
      Top = 124
      ExplicitLeft = 564
      ExplicitTop = 124
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
    object edtPort: TEdit
      Left = 288
      Top = 59
      Width = 60
      Height = 21
      MaxLength = 5
      TabOrder = 6
      OnChange = edtHostChange
    end
    object edtFrequency1: TEdit
      Left = 60
      Top = 99
      Width = 106
      Height = 21
      MaxLength = 8
      TabOrder = 7
      OnChange = edtHostChange
    end
    object edtMode1: TEdit
      Left = 288
      Top = 99
      Width = 60
      Height = 21
      MaxLength = 1
      TabOrder = 8
      OnChange = edtHostChange
    end
    object edtFrequency2: TEdit
      Left = 60
      Top = 126
      Width = 106
      Height = 21
      MaxLength = 8
      TabOrder = 9
      OnChange = edtHostChange
    end
    object edtMode2: TEdit
      Left = 288
      Top = 126
      Width = 60
      Height = 21
      MaxLength = 1
      TabOrder = 10
      OnChange = edtHostChange
    end
    object chkAFC1: TAdvOfficeCheckBox
      Left = 384
      Top = 100
      Width = 49
      Height = 20
      TabOrder = 11
      Alignment = taRightJustify
      Caption = 'AFC:'
      ReturnIsTab = False
      Version = '1.8.1.0'
    end
    object chkAFC2: TAdvOfficeCheckBox
      Left = 384
      Top = 126
      Width = 49
      Height = 20
      TabOrder = 12
      Alignment = taRightJustify
      Caption = 'AFC:'
      ReturnIsTab = False
      Version = '1.8.1.0'
    end
  end
end
