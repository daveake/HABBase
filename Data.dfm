object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 297
  Width = 450
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Dropbox\dev\HAB\apps\HABBase\HABBase.db'
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
    LoginPrompt = False
    Left = 48
    Top = 57
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 168
    Top = 64
  end
  object tblSettings: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 168
  end
  object tblSources: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftAutoInc
      end
      item
        Name = 'Enabled'
        DataType = ftBoolean
      end
      item
        Name = 'Type'
        DataType = ftInteger
      end
      item
        Name = 'Code'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Host'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Port'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'LastConnection'
        DataType = ftDateTime
      end
      item
        Name = 'LastPacket'
        DataType = ftDateTime
      end
      item
        Name = 'Payload'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Settings'
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 192
    Top = 168
  end
  object srcSources: TDataSource
    DataSet = tblSources
    Left = 192
    Top = 224
  end
end
