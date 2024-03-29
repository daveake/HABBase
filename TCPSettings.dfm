inherited frmTCPSettings: TfrmTCPSettings
  Caption = 'TCP/IP Settings'
  ClientHeight = 160
  ClientWidth = 574
  ExplicitWidth = 590
  ExplicitHeight = 199
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    Width = 574
    Height = 160
    ExplicitWidth = 574
    ExplicitHeight = 152
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
    inherited edtCode: TEdit
      OnChange = edtHostChange
    end
    inherited edtName: TEdit
      OnChange = edtHostChange
    end
    inherited btnSave: TAdvSmoothButton
      Left = 380
      Top = 107
      ExplicitLeft = 380
      ExplicitTop = 99
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      Left = 474
      Top = 107
      ExplicitLeft = 474
      ExplicitTop = 99
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
    object chkUpload: TAdvOfficeCheckBox
      Left = 372
      Top = 60
      Width = 120
      Height = 20
      TabOrder = 7
      OnClick = chKEnabledClick
      Alignment = taLeftJustify
      Caption = 'Upload To Server(s)'
      ReturnIsTab = False
      Version = '1.8.1.0'
    end
  end
end
