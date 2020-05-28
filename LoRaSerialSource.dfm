inherited frmLoRaSerialSource: TfrmLoRaSerialSource
  Caption = 'LoRa Serial Source'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited PageControl1: TPageControl
      ActivePage = tabSignal
      object tabSignal: TTabSheet [1]
        Caption = 'Signal'
        ImageIndex = 2
        object pnlCommon: TAdvPanel
          Left = 0
          Top = 0
          Width = 374
          Height = 276
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clSilver
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          UseDockManager = True
          Version = '2.5.10.2'
          BorderColor = clGray
          Caption.Color = 15722471
          Caption.ColorTo = 11176072
          Caption.Font.Charset = DEFAULT_CHARSET
          Caption.Font.Color = clWindowText
          Caption.Font.Height = -16
          Caption.Font.Name = 'Tahoma'
          Caption.Font.Style = []
          Caption.GradientDirection = gdVertical
          Caption.Height = 14
          Caption.Indent = 2
          Caption.ShadeLight = 255
          CollapsColor = clHighlight
          CollapsDelay = 0
          ColorTo = 14540253
          ColorMirror = 14540253
          ColorMirrorTo = clSilver
          DoubleBuffered = True
          ShadowColor = clBlack
          ShadowOffset = 0
          StatusBar.BorderColor = clNone
          StatusBar.BorderStyle = bsSingle
          StatusBar.Font.Charset = DEFAULT_CHARSET
          StatusBar.Font.Color = clBlack
          StatusBar.Font.Height = -11
          StatusBar.Font.Name = 'Tahoma'
          StatusBar.Font.Style = []
          StatusBar.Color = 12560553
          StatusBar.ColorTo = 14602191
          StatusBar.GradientDirection = gdVertical
          Text = ''
          DesignSize = (
            370
            272)
          FullHeight = 337
          object Label9: TLabel
            Left = 35
            Top = 47
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Current RSSI:'
          end
          object Label1: TLabel
            Left = 40
            Top = 74
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'Packet RSSI:'
          end
          object Label2: TLabel
            Left = 209
            Top = 74
            Width = 57
            Height = 13
            Alignment = taRightJustify
            Caption = 'Freq. Error:'
          end
          object Label3: TLabel
            Left = 186
            Top = 15
            Width = 20
            Height = 13
            Alignment = taRightJustify
            Caption = 'MHz'
          end
          object btnSave: TAdvSmoothButton
            AlignWithMargins = True
            Left = 447
            Top = 122
            Width = 82
            Height = 38
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akRight, akBottom]
            Appearance.Font.Charset = DEFAULT_CHARSET
            Appearance.Font.Color = 2303013
            Appearance.Font.Height = -11
            Appearance.Font.Name = 'Tahoma'
            Appearance.Font.Style = []
            Appearance.SimpleLayout = True
            Appearance.Rounding = 0
            Status.Caption = '0'
            Status.Appearance.Fill.Color = clRed
            Status.Appearance.Fill.ColorMirror = clNone
            Status.Appearance.Fill.ColorMirrorTo = clNone
            Status.Appearance.Fill.GradientType = gtSolid
            Status.Appearance.Fill.GradientMirrorType = gtSolid
            Status.Appearance.Fill.BorderColor = clGray
            Status.Appearance.Fill.Rounding = 0
            Status.Appearance.Fill.ShadowOffset = 0
            Status.Appearance.Fill.Glow = gmNone
            Status.Appearance.Font.Charset = DEFAULT_CHARSET
            Status.Appearance.Font.Color = clWhite
            Status.Appearance.Font.Height = -11
            Status.Appearance.Font.Name = 'Tahoma'
            Status.Appearance.Font.Style = []
            Caption = 'Save'
            Color = clWhite
            ParentFont = False
            TabOrder = 0
            Enabled = False
            Version = '2.2.1.2'
            TMSStyle = 8
          end
          object btnCancel: TAdvSmoothButton
            AlignWithMargins = True
            Left = 541
            Top = 122
            Width = 82
            Height = 38
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akRight, akBottom]
            Appearance.Font.Charset = DEFAULT_CHARSET
            Appearance.Font.Color = 2303013
            Appearance.Font.Height = -11
            Appearance.Font.Name = 'Tahoma'
            Appearance.Font.Style = []
            Appearance.SimpleLayout = True
            Appearance.Rounding = 0
            Status.Caption = '0'
            Status.Appearance.Fill.Color = clRed
            Status.Appearance.Fill.ColorMirror = clNone
            Status.Appearance.Fill.ColorMirrorTo = clNone
            Status.Appearance.Fill.GradientType = gtSolid
            Status.Appearance.Fill.GradientMirrorType = gtSolid
            Status.Appearance.Fill.BorderColor = clGray
            Status.Appearance.Fill.Rounding = 0
            Status.Appearance.Fill.ShadowOffset = 0
            Status.Appearance.Fill.Glow = gmNone
            Status.Appearance.Font.Charset = DEFAULT_CHARSET
            Status.Appearance.Font.Color = clWhite
            Status.Appearance.Font.Height = -11
            Status.Appearance.Font.Name = 'Tahoma'
            Status.Appearance.Font.Style = []
            Caption = 'Cancel'
            Color = clWhite
            ParentFont = False
            TabOrder = 1
            Version = '2.2.1.2'
            ModalResult = 2
            TMSStyle = 8
          end
          object edtCurrentRSSI: TEdit
            Left = 111
            Top = 44
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 2
          end
          object edtPacketRSSI: TEdit
            Left = 111
            Top = 71
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 3
          end
          object AdvGauge1: TAdvGauge
            Left = 8
            Top = 104
            Width = 353
            Height = 161
            Anchors = [akLeft, akTop, akRight, akBottom]
            ArcColor = clRed
            ArcWidth = 30
            Background.Color = clWhite
            Background.ColorTo = clWhite
            Background.ColorMirror = clNone
            Background.ColorMirrorTo = clNone
            Background.GradientType = gtVertical
            Background.GradientMirrorType = gtSolid
            Background.BorderColor = clWindowFrame
            Background.Rounding = 0
            Background.ShadowOffset = 0
            Background.Glow = gmNone
            EndNeedle.Color = clRed
            EndPosition = 100.000000000000000000
            ExtraNeedles = <>
            MultiRanges = <>
            Kind = gkNone
            Needle.Color = clBlue
            Minimum = -150.000000000000000000
            MinText = 'Left'
            Maximum = -20.000000000000000000
            MaxText = 'Right'
            Position = -150.000000000000000000
            SplitArcColor = clGreen
            SplitPosition = -110.000000000000000000
            TextPosition = tpNone
            TopPosition = 100.000000000000000000
            Version = '1.2.1.0'
          end
          object edtFrequencyError: TEdit
            Left = 272
            Top = 71
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 5
          end
          object VrMediaButton1: TVrMediaButton
            Left = 212
            Top = 8
            Width = 49
            Height = 26
            ButtonType = btNext
            TabOrder = 6
            OnClick = VrMediaButton1Click
          end
          object VrMediaButton2: TVrMediaButton
            Left = 8
            Top = 8
            Width = 49
            Height = 26
            ButtonType = btBack
            TabOrder = 7
            OnClick = VrMediaButton2Click
          end
          object VrMediaButton3: TVrMediaButton
            Left = 56
            Top = 8
            Width = 49
            Height = 26
            ButtonType = btPrev
            TabOrder = 8
            OnClick = VrMediaButton3Click
          end
          object VrMediaButton4: TVrMediaButton
            Left = 261
            Top = 8
            Width = 49
            Height = 26
            ButtonType = btStep
            TabOrder = 9
            OnClick = VrMediaButton4Click
          end
          object edtFrequency: TEdit
            Left = 111
            Top = 8
            Width = 69
            Height = 26
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 10
          end
          object chkAFC: TAdvOfficeCheckBox
            Left = 236
            Top = 40
            Width = 49
            Height = 20
            TabOrder = 11
            Alignment = taRightJustify
            Caption = 'AFC:'
            ReturnIsTab = False
            Version = '1.7.0.2'
          end
        end
      end
    end
  end
  inherited tblPositions: TFDMemTable
    Left = 264
    Top = 276
  end
  inherited srcPositions: TDataSource
    Left = 204
    Top = 248
  end
end
