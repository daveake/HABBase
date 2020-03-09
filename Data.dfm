object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 297
  Width = 450
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Dropbox\dev\HAB\HABBase\HABBase.db'
      'LockingMode=Normal'
      'StringFormat=ANSI'
      'DriverID=SQLite')
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtMemo
        TargetDataType = dtWideString
      end>
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 57
  end
end
