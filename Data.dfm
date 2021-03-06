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
    Top = 73
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 168
    Top = 64
  end
  object tblSettings: TFDMemTable
    FieldDefs = <>
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
    Left = 312
    Top = 64
    object tblSettingsCallsign: TStringField
      FieldName = 'Callsign'
      Size = 32
    end
    object tblSettingsFormLeft: TIntegerField
      FieldName = 'FormLeft'
    end
    object tblSettingsFormTop: TIntegerField
      FieldName = 'FormTop'
    end
    object tblSettingsFormWidth: TIntegerField
      FieldName = 'FormWidth'
    end
    object tblSettingsFormHeight: TIntegerField
      FieldName = 'FormHeight'
    end
    object tblSettingsUDPPort: TIntegerField
      FieldName = 'UDPPort'
    end
    object tblSettingsTopHeight: TIntegerField
      FieldName = 'TopHeight'
    end
    object tblSettingsBottomLeftHeight: TIntegerField
      FieldName = 'BottomLeftHeight'
    end
    object tblSettingsBottomHeight: TIntegerField
      FieldName = 'BottomHeight'
    end
    object tblSettingsTopMiddleHeight: TIntegerField
      FieldName = 'TopMiddleHeight'
    end
    object tblSettingsLatitude: TFloatField
      FieldName = 'Latitude'
    end
    object tblSettingsLongitude: TFloatField
      FieldName = 'Longitude'
    end
    object tblSettingsAltitude: TFloatField
      FieldName = 'Altitude'
    end
    object tblSettingsLeftWidth: TIntegerField
      FieldName = 'LeftWidth'
    end
    object tblSettingsRightWidth: TIntegerField
      FieldName = 'RightWidth'
    end
    object tblSettingsExpiry: TIntegerField
      FieldName = 'Expiry'
    end
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
        Size = 64
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
      end
      item
        Name = 'Status'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 88
    Top = 168
    Content = {
      414442530F00513CD1040000FF00010001FF02FF03040014000000740062006C
      0053006F007500720063006500730005000A0000005400610062006C00650006
      0000000000070000080032000000090000FF0AFF0B0400040000004900440005
      0004000000490044000C00010000000E000D000F000110000111000112000113
      000114000115000116000117000400000049004400FEFF0B04000E0000004500
      6E00610062006C006500640005000E00000045006E00610062006C0065006400
      0C00020000000E0018000F000110000112000113000114000115000117000E00
      000045006E00610062006C0065006400FEFF0B04000800000054007900700065
      0005000800000054007900700065000C00030000000E000D000F000110000112
      00011300011400011500011700080000005400790070006500FEFF0B04000800
      000043006F006400650005000800000043006F00640065000C00040000000E00
      19001A00030000000F0001100001120001130001140001150001170008000000
      43006F00640065001B0003000000FEFF0B0400080000004E0061006D00650005
      00080000004E0061006D0065000C00050000000E0019001A00140000000F0001
      1000011200011300011400011500011700080000004E0061006D0065001B0014
      000000FEFF0B04000800000048006F007300740005000800000048006F007300
      74000C00060000000E0019001A00140000000F00011000011200011300011400
      0115000117000800000048006F00730074001B0014000000FEFF0B0400080000
      0050006F007200740005000800000050006F00720074000C00070000000E0019
      001A00400000000F000110000112000113000114000115000117000800000050
      006F00720074001B0040000000FEFF0B04001C0000004C006100730074004300
      6F006E006E0065006300740069006F006E0005001C0000004C00610073007400
      43006F006E006E0065006300740069006F006E000C00080000000E001C000F00
      0110000112000113000114000115000117001C0000004C006100730074004300
      6F006E006E0065006300740069006F006E00FEFF0B0400140000004C00610073
      0074005000610063006B00650074000500140000004C00610073007400500061
      0063006B00650074000C00090000000E001C000F000110000112000113000114
      00011500011700140000004C006100730074005000610063006B0065007400FE
      FF0B04000E0000005000610079006C006F006100640005000E00000050006100
      79006C006F00610064000C000A0000000E0019001A00140000000F0001100001
      12000113000114000115000117000E0000005000610079006C006F0061006400
      1B0014000000FEFF0B040010000000530065007400740069006E006700730005
      0010000000530065007400740069006E00670073000C000B0000000E0019001A
      00FF0000000F0001100001120001130001140001150001170010000000530065
      007400740069006E00670073001B00FF000000FEFF0B04000C00000053007400
      610074007500730005000C0000005300740061007400750073000C000C000000
      0E0019001A00640000000F000110000112000113000114000115000117000C00
      00005300740061007400750073001B0064000000FEFEFF1DFEFF1EFEFF1FFEFE
      FEFF20FEFF21220022000000FF23FEFEFE0E004D0061006E0061006700650072
      001E005500700064006100740065007300520065006700690073007400720079
      0012005400610062006C0065004C006900730074000A005400610062006C0065
      0008004E0061006D006500140053006F0075007200630065004E0061006D0065
      000A0054006100620049004400240045006E0066006F0072006300650043006F
      006E00730074007200610069006E00740073001E004D0069006E0069006D0075
      006D0043006100700061006300690074007900180043006800650063006B004E
      006F0074004E0075006C006C00140043006F006C0075006D006E004C00690073
      0074000C0043006F006C0075006D006E00100053006F00750072006300650049
      0044000E006400740049006E0074003300320010004400610074006100540079
      00700065001400530065006100720063006800610062006C006500120041006C
      006C006F0077004E0075006C006C000E004100750074006F0049006E00630008
      00420061007300650014004F0041006C006C006F0077004E0075006C006C0012
      004F0049006E0055007000640061007400650010004F0049006E005700680065
      007200650020004F004100660074006500720049006E0073004300680061006E
      006700650064001A004F0072006900670069006E0043006F006C004E0061006D
      00650012006400740042006F006F006C00650061006E0018006400740041006E
      007300690053007400720069006E0067000800530069007A006500140053006F
      007500720063006500530069007A006500140064007400440061007400650054
      0069006D0065001C0043006F006E00730074007200610069006E0074004C0069
      0073007400100056006900650077004C006900730074000E0052006F0077004C
      006900730074001800520065006C006100740069006F006E004C006900730074
      001C0055007000640061007400650073004A006F00750072006E0061006C0012
      00530061007600650050006F0069006E0074000E004300680061006E00670065
      007300}
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
        Name = 'Remote'
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
      414442530F00513C95020000FF00010001FF02FF03040018000000740062006C
      00570068006900740065004C0069007300740005000A0000005400610062006C
      006500060000000000070000080032000000090000FF0AFF0B04000E00000045
      006E00610062006C006500640005000E00000045006E00610062006C00650064
      000C00010000000E000D000F000110000111000112000113000114000115000E
      00000045006E00610062006C0065006400FEFF0B040006000000480041004200
      0500060000004800410042000C00020000000E000D000F000110000111000112
      0001130001140001150006000000480041004200FEFF0B04000A00000053006F
      006E006400650005000A00000053006F006E00640065000C00030000000E000D
      000F000110000111000112000113000114000115000A00000053006F006E0064
      006500FEFF0B04000C000000520065006D006F007400650005000C0000005200
      65006D006F00740065000C00040000000E000D000F0001100001110001120001
      13000114000115000C000000520065006D006F0074006500FEFF0B0400080000
      004D00610073006B000500080000004D00610073006B000C00050000000E0016
      001700140000000F00011000011100011200011300011400011500080000004D
      00610073006B00180014000000FEFF0B04001000000044006900730074006100
      6E0063006500050010000000440069007300740061006E00630065000C000600
      00000E0019000F00011000011100011200011300011400011500100000004400
      69007300740061006E0063006500FEFEFF1AFEFF1BFEFF1CFF1D1E0000000000
      20001F00FF210000010001000100020001000300010005000000000000709740
      FEFEFEFEFEFF22FEFF23240008000000FF25FEFEFE0E004D0061006E00610067
      00650072001E0055007000640061007400650073005200650067006900730074
      007200790012005400610062006C0065004C006900730074000A005400610062
      006C00650008004E0061006D006500140053006F0075007200630065004E0061
      006D0065000A0054006100620049004400240045006E0066006F007200630065
      0043006F006E00730074007200610069006E00740073001E004D0069006E0069
      006D0075006D0043006100700061006300690074007900180043006800650063
      006B004E006F0074004E0075006C006C00140043006F006C0075006D006E004C
      006900730074000C0043006F006C0075006D006E00100053006F007500720063
      0065004900440012006400740042006F006F006C00650061006E001000440061
      007400610054007900700065001400530065006100720063006800610062006C
      006500120041006C006C006F0077004E0075006C006C00080042006100730065
      0014004F0041006C006C006F0077004E0075006C006C0012004F0049006E0055
      007000640061007400650010004F0049006E00570068006500720065001A004F
      0072006900670069006E0043006F006C004E0061006D00650018006400740041
      006E007300690053007400720069006E0067000800530069007A006500140053
      006F007500720063006500530069007A00650010006400740044006F00750062
      006C0065001C0043006F006E00730074007200610069006E0074004C00690073
      007400100056006900650077004C006900730074000E0052006F0077004C0069
      0073007400060052006F0077000A0052006F0077004900440016007200730055
      006E006300680061006E006700650064001A0052006F0077005000720069006F
      0072005300740061007400650010004F0072006900670069006E0061006C0018
      00520065006C006100740069006F006E004C006900730074001C005500700064
      0061007400650073004A006F00750072006E0061006C00120053006100760065
      0050006F0069006E0074000E004300680061006E00670065007300}
    object tblWhiteListEnabled: TBooleanField
      FieldName = 'Enabled'
      Origin = 'Enabled'
    end
    object tblWhiteListHAB: TBooleanField
      FieldName = 'HAB'
      Origin = 'HAB'
    end
    object tblWhiteListSonde: TBooleanField
      FieldName = 'Sonde'
      Origin = 'Sonde'
    end
    object tblWhiteListRemote: TBooleanField
      FieldName = 'Remote'
      Origin = 'Remote'
    end
    object tblWhiteListMask: TStringField
      FieldName = 'Mask'
      Origin = 'Mask'
    end
    object tblWhiteListDistance: TFloatField
      FieldName = 'Distance'
      Origin = 'Distance'
    end
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
  object srcSettings: TDataSource
    DataSet = tblSettings
    Left = 312
    Top = 112
  end
end
