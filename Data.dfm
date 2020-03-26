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
    Left = 312
    Top = 64
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
    Left = 88
    Top = 168
  end
  object srcSources: TDataSource
    DataSet = tblSources
    Left = 88
    Top = 224
  end
  object srcWhiteList: TDataSource
    DataSet = tblWhiteList
    Left = 168
    Top = 224
  end
  object tblWhiteList: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Enabled'
        DataType = ftBoolean
      end
      item
        Name = 'HAB'
        DataType = ftBoolean
      end
      item
        Name = 'Sonde'
        DataType = ftBoolean
      end
      item
        Name = 'Local'
        DataType = ftBoolean
      end
      item
        Name = 'Mask'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Distance'
        DataType = ftFloat
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 168
    Top = 168
    Content = {
      414442530F0014308F020000FF00010001FF02FF03040018000000740062006C
      00570068006900740065004C0069007300740005000A0000005400610062006C
      006500060000000000070000080032000000090000FF0AFF0B04000E00000045
      006E00610062006C006500640005000E00000045006E00610062006C00650064
      000C00010000000E000D000F000110000111000112000113000114000115000E
      00000045006E00610062006C0065006400FEFF0B040006000000480041004200
      0500060000004800410042000C00020000000E000D000F000110000111000112
      0001130001140001150006000000480041004200FEFF0B04000A00000053006F
      006E006400650005000A00000053006F006E00640065000C00030000000E000D
      000F000110000111000112000113000114000115000A00000053006F006E0064
      006500FEFF0B04000A0000004C006F00630061006C0005000A0000004C006F00
      630061006C000C00040000000E000D000F000110000111000112000113000114
      000115000A0000004C006F00630061006C00FEFF0B0400080000004D00610073
      006B000500080000004D00610073006B000C00060000000E0016001700140000
      000F00011000011100011200011300011400011500080000004D00610073006B
      00180014000000FEFF0B040010000000440069007300740061006E0063006500
      050010000000440069007300740061006E00630065000C00070000000E001900
      0F00011000011100011200011300011400011500100000004400690073007400
      61006E0063006500FEFEFF1AFEFF1BFEFF1CFF1D1E000000000020001F00FF21
      0000010001000100020001000300000005000000000000000000FEFEFEFEFEFF
      22FEFF23240006000000FF25FEFEFE0E004D0061006E0061006700650072001E
      0055007000640061007400650073005200650067006900730074007200790012
      005400610062006C0065004C006900730074000A005400610062006C00650008
      004E0061006D006500140053006F0075007200630065004E0061006D0065000A
      0054006100620049004400240045006E0066006F0072006300650043006F006E
      00730074007200610069006E00740073001E004D0069006E0069006D0075006D
      0043006100700061006300690074007900180043006800650063006B004E006F
      0074004E0075006C006C00140043006F006C0075006D006E004C006900730074
      000C0043006F006C0075006D006E00100053006F007500720063006500490044
      0012006400740042006F006F006C00650061006E001000440061007400610054
      007900700065001400530065006100720063006800610062006C006500120041
      006C006C006F0077004E0075006C006C000800420061007300650014004F0041
      006C006C006F0077004E0075006C006C0012004F0049006E0055007000640061
      007400650010004F0049006E00570068006500720065001A004F007200690067
      0069006E0043006F006C004E0061006D00650018006400740041006E00730069
      0053007400720069006E0067000800530069007A006500140053006F00750072
      0063006500530069007A00650010006400740044006F00750062006C0065001C
      0043006F006E00730074007200610069006E0074004C00690073007400100056
      006900650077004C006900730074000E0052006F0077004C0069007300740006
      0052006F0077000A0052006F0077004900440016007200730055006E00630068
      0061006E006700650064001A0052006F0077005000720069006F007200530074
      0061007400650010004F0072006900670069006E0061006C001800520065006C
      006100740069006F006E004C006900730074001C005500700064006100740065
      0073004A006F00750072006E0061006C001200530061007600650050006F0069
      006E0074000E004300680061006E00670065007300}
  end
  object tblAllPayloads: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'PayloadID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Counter'
        DataType = ftInteger
      end
      item
        Name = 'Timestamp'
        DataType = ftDateTime
      end
      item
        Name = 'Latitude'
        DataType = ftFloat
      end
      item
        Name = 'Longitude'
        DataType = ftFloat
      end
      item
        Name = 'Altitude'
        DataType = ftFloat
      end
      item
        Name = 'Distance'
        DataType = ftFloat
      end
      item
        Name = 'ReceivedLocally'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    IndexFieldNames = 'PayloadID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 232
    Top = 168
  end
  object srcAllPayloads: TDataSource
    DataSet = tblAllPayloads
    Left = 232
    Top = 224
  end
  object srcLivePayloads: TDataSource
    DataSet = tblLivePayloads
    Left = 312
    Top = 224
  end
  object tblLivePayloads: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'PayloadID'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Counter'
        DataType = ftInteger
      end
      item
        Name = 'Timestamp'
        DataType = ftDateTime
      end
      item
        Name = 'Latitude'
        DataType = ftFloat
      end
      item
        Name = 'Longitude'
        DataType = ftFloat
      end
      item
        Name = 'Altitude'
        DataType = ftFloat
      end
      item
        Name = 'Distance'
        DataType = ftFloat
      end
      item
        Name = 'ReceivedLocally'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    IndexFieldNames = 'PayloadID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 312
    Top = 168
    object tblLivePayloadsPayloadID: TStringField
      FieldName = 'PayloadID'
    end
    object tblLivePayloadsCounter: TIntegerField
      FieldName = 'Counter'
    end
    object tblLivePayloadsTimestamp: TDateTimeField
      FieldName = 'Timestamp'
      DisplayFormat = 'hh:nn:ss'
    end
    object tblLivePayloadsLatitude: TFloatField
      FieldName = 'Latitude'
      DisplayFormat = '0.00000'
    end
    object tblLivePayloadsLongitude: TFloatField
      FieldName = 'Longitude'
      DisplayFormat = '0.00000'
    end
    object tblLivePayloadsAltitude: TFloatField
      FieldName = 'Altitude'
      DisplayFormat = '0 m'
    end
    object tblLivePayloadsDistance: TFloatField
      FieldName = 'Distance'
      DisplayFormat = '0 km'
    end
    object tblLivePayloadsReceivedLocally: TBooleanField
      FieldName = 'ReceivedLocally'
    end
  end
end
