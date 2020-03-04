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
  object qryMain: TSQLQuery
    DataSource = srcMain
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DataModule1.SQLConnection1
    Left = 40
    Top = 74
  end
  object dspMain: TDataSetProvider
    DataSet = qryMain
    ResolveToDataSet = True
    Left = 34
    Top = 152
  end
  object srcMain: TDataSource
    DataSet = cdsMain
    Left = 34
    Top = 228
  end
  object cdsMain: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 28
    Top = 300
  end
end
