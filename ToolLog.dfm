inherited frmToolLog: TfrmToolLog
  Caption = 'Log'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited Panel1: TPanel
      inherited lblTitle: TLabel
        Width = 303
        Caption = 'Log'
        ExplicitWidth = 20
      end
      inherited Button1: TButton
        ExplicitLeft = 322
        ExplicitHeight = 19
      end
    end
    object lstLog: TListBox
      Left = 0
      Top = 24
      Width = 351
      Height = 262
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
      ExplicitTop = 0
      ExplicitWidth = 329
      ExplicitHeight = 225
    end
  end
end
