inherited frmHabitatSettings: TfrmHabitatSettings
  Caption = 'Habitat Settings'
  ClientHeight = 141
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    Height = 141
    FullHeight = 337
    inherited Label9: TLabel
      Left = 41
      ExplicitLeft = 41
    end
    inherited Label10: TLabel
      Left = 151
      ExplicitLeft = 151
    end
    object Label1: TLabel [2]
      Left = 9
      Top = 50
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payload List:'
    end
    inherited edtCode: TEdit
      Left = 76
      ExplicitLeft = 76
    end
    inherited edtName: TEdit
      Left = 188
      ExplicitLeft = 188
    end
    inherited chKEnabled: TAdvOfficeCheckBox
      Left = 388
      ExplicitLeft = 388
    end
    inherited btnSave: TAdvSmoothButton
      Top = 88
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      Top = 88
      TMSStyle = 8
    end
    object edtWhiteList: TEdit
      Left = 76
      Top = 47
      Width = 547
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      OnChange = edtWhiteListChange
    end
  end
end
