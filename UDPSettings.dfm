inherited frmUDPSettings: TfrmUDPSettings
  Caption = 'UDP Settings'
  ClientHeight = 152
  ClientWidth = 574
  ExplicitWidth = 590
  ExplicitHeight = 191
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCommon: TAdvPanel
    Width = 574
    Height = 152
    ExplicitWidth = 574
    ExplicitHeight = 152
    FullHeight = 337
    object Label2: TLabel [2]
      Left = 17
      Top = 62
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Port(s):'
    end
    inherited edtCode: TEdit
      OnChange = edtHostChange
    end
    inherited edtName: TEdit
      OnChange = edtHostChange
    end
    inherited btnSave: TAdvSmoothButton
      Left = 380
      Top = 99
      ExplicitLeft = 380
      ExplicitTop = 99
      TMSStyle = 8
    end
    inherited btnCancel: TAdvSmoothButton
      Left = 474
      Top = 99
      ExplicitLeft = 474
      ExplicitTop = 99
      TMSStyle = 8
    end
    object edtPortList: TEdit
      Left = 60
      Top = 59
      Width = 496
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      OnChange = edtHostChange
    end
  end
end
