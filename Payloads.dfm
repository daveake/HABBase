inherited frmPayloads: TfrmPayloads
  Caption = 'Payloads'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited grdMain: TDBAdvGrid
      ColCount = 7
      RowCount = 7
      FixedColWidth = 117
      Columns = <
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'PayloadID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 117
        end
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'TimeStamp'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 122
        end
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'Latitude'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 64
        end
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'Longitude'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 64
        end
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'Altitude'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 64
        end
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'Distance'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 64
        end
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'DocID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
          PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
          PrintFont.Charset = DEFAULT_CHARSET
          PrintFont.Color = clWindowText
          PrintFont.Height = -11
          PrintFont.Name = 'Tahoma'
          PrintFont.Style = []
          Width = 213
        end>
      ColWidths = (
        117
        122
        64
        64
        64
        64
        213)
    end
  end
  inherited qryMain: TFDQuery
    Active = True
    SQL.Strings = (
      'select * from payloads')
    object qryMainID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryMainPayloadID: TWideStringField
      FieldName = 'PayloadID'
      Origin = 'PayloadID'
      Required = True
      Size = 32767
    end
    object qryMainDocID: TWideStringField
      FieldName = 'DocID'
      Origin = 'DocID'
      Size = 32767
    end
    object qryMainTimeStamp: TWideStringField
      FieldName = 'TimeStamp'
      Origin = 'TimeStamp'
      Size = 32767
    end
    object qryMainLatitude: TFloatField
      FieldName = 'Latitude'
      Origin = 'Latitude'
    end
    object qryMainLongitude: TFloatField
      FieldName = 'Longitude'
      Origin = 'Longitude'
    end
    object qryMainAltitude: TIntegerField
      FieldName = 'Altitude'
      Origin = 'Altitude'
    end
    object qryMainSources: TWideStringField
      FieldName = 'Sources'
      Origin = 'Sources'
      Size = 32767
    end
    object qryMainCallsigns: TWideStringField
      FieldName = 'Callsigns'
      Origin = 'Callsigns'
      Size = 32767
    end
    object qryMainEnabled: TIntegerField
      FieldName = 'Enabled'
      Origin = 'Enabled'
    end
    object qryMainNoDelete: TIntegerField
      FieldName = 'NoDelete'
      Origin = 'NoDelete'
    end
    object qryMainFieldList: TWideStringField
      FieldName = 'FieldList'
      Origin = 'FieldList'
      Size = 32767
    end
    object qryMainFieldValues: TWideStringField
      FieldName = 'FieldValues'
      Origin = 'FieldValues'
      Size = 32767
    end
    object qryMainSentence: TWideStringField
      FieldName = 'Sentence'
      Origin = 'Sentence'
      Size = 32767
    end
    object qryMainDistance: TIntegerField
      FieldName = 'Distance'
      Origin = 'Distance'
    end
  end
end
