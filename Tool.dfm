inherited frmTool: TfrmTool
  Caption = 'Tool Form'
  ClientHeight = 286
  ClientWidth = 351
  ExplicitWidth = 367
  ExplicitHeight = 325
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 351
    Height = 286
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 351
      Height = 24
      Align = alTop
      BevelOuter = bvLowered
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object lblTitle: TLabel
        AlignWithMargins = True
        Left = 13
        Top = 4
        Width = 303
        Height = 16
        Margins.Left = 12
        Align = alClient
        Caption = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 25
      end
      object Button1: TButton
        AlignWithMargins = True
        Left = 322
        Top = 2
        Width = 27
        Height = 19
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alRight
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 320
        ExplicitHeight = 20
      end
    end
  end
end
