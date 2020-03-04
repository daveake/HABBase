object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 297
  Width = 450
  object SQLConnection1: TSQLConnection
    ConnectionName = 'HABBase'
    DriverName = 'Sqlite'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Sqlite'
      'DriverUnit=Data.DbxSqlite'
      
        'DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver260.bp' +
        'l'
      
        'MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqlite' +
        'Driver260.bpl'
      'FailIfMissing=True'
      'Database=D:\Dropbox\dev\HAB\HABBase\HABBase.db')
    Left = 56
    Top = 42
  end
  object qrySettings: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from settings')
    SQLConnection = SQLConnection1
    Left = 56
    Top = 122
  end
end
