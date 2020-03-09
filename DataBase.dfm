inherited frmDataBase: TfrmDataBase
  Caption = 'Data Form'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 833
    ExplicitHeight = 470
  end
  object qryMain: TFDQuery
    Connection = DataModule1.FDConnection
    Left = 48
    Top = 65
  end
  object srcMain: TDataSource
    DataSet = qryMain
    Left = 48
    Top = 144
  end
end
