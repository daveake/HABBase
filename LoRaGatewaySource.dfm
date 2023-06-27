inherited frmLoRaGatewaySource: TfrmLoRaGatewaySource
  Caption = 'LoRa Gateway Source'
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited pnlTop: TPanel
      inherited pnlTitle: TPanel
        inherited lblTitle: TLabel
          Width = 239
          Height = 23
        end
      end
    end
    inherited PageControl1: TPageControl
      ActivePage = tabSignal
      object tabSignal: TTabSheet [1]
        Caption = 'Channel 0'
        ImageIndex = 2
        object pnlCommon0: TAdvPanel
          Left = 0
          Top = 0
          Width = 374
          Height = 276
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
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
          Version = '2.6.3.1'
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
            Left = 32
            Top = 42
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Current RSSI:'
          end
          object Label1: TLabel
            Left = 37
            Top = 69
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'Packet RSSI:'
          end
          object Label2: TLabel
            Left = 206
            Top = 69
            Width = 57
            Height = 13
            Alignment = taRightJustify
            Caption = 'Freq. Error:'
          end
          object Label3: TLabel
            Left = 183
            Top = 11
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
            Version = '2.2.3.1'
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
            Version = '2.2.3.1'
            ModalResult = 2
            TMSStyle = 8
          end
          object edtCurrentRSSI0: TEdit
            Left = 108
            Top = 39
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 2
          end
          object edtPacketRSSI0: TEdit
            Left = 108
            Top = 66
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 3
          end
          object AdvGauge0: TAdvGauge
            Left = 5
            Top = 128
            Width = 353
            Height = 137
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
            Maximum = -80.000000000000000000
            MaxText = 'Right'
            Position = -150.000000000000000000
            SplitArcColor = clGreen
            SplitPosition = -130.000000000000000000
            TextPosition = tpNone
            TopPosition = 100.000000000000000000
            Version = '1.2.1.0'
          end
          object edtFrequencyError0: TEdit
            Left = 269
            Top = 66
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 5
          end
          object VrMediaButton1: TVrMediaButton
            Left = 209
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btNext
            TabOrder = 6
            OnClick = VrMediaButton1Click
          end
          object VrMediaButton2: TVrMediaButton
            Left = 5
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btBack
            TabOrder = 7
            OnClick = VrMediaButton2Click
          end
          object VrMediaButton3: TVrMediaButton
            Left = 53
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btPrev
            TabOrder = 8
            OnClick = VrMediaButton3Click
          end
          object VrMediaButton4: TVrMediaButton
            Left = 258
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btStep
            TabOrder = 9
            OnClick = VrMediaButton4Click
          end
          object edtFrequency0: TEdit
            Left = 108
            Top = 4
            Width = 69
            Height = 21
            Alignment = taCenter
            TabOrder = 10
            OnExit = edtFrequency0Exit
          end
          object chkAFC0: TAdvOfficeCheckBox
            Left = 233
            Top = 42
            Width = 49
            Height = 20
            TabOrder = 11
            OnClick = chkAFC0Click
            Alignment = taRightJustify
            Caption = 'AFC:'
            ReturnIsTab = False
            Version = '1.8.1.0'
          end
          object ProgressBar0: TProgressBar
            Left = 9
            Top = 94
            Width = 240
            Height = 27
            Max = 21
            BarColor = clNavy
            TabOrder = 12
          end
          object btnSearch1: TButton
            Left = 260
            Top = 94
            Width = 102
            Height = 27
            Caption = 'Search +/- 10kHz'
            TabOrder = 13
            OnClick = btnSearch1Click
          end
        end
      end
      object TabSheet1: TTabSheet [2]
        Caption = 'Channel 1'
        ImageIndex = 3
        object pnlCommon1: TAdvPanel
          Left = 0
          Top = 0
          Width = 374
          Height = 276
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
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
          Version = '2.6.3.1'
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
          object Label4: TLabel
            Left = 32
            Top = 42
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Current RSSI:'
          end
          object Label5: TLabel
            Left = 37
            Top = 69
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'Packet RSSI:'
          end
          object Label6: TLabel
            Left = 206
            Top = 69
            Width = 57
            Height = 13
            Alignment = taRightJustify
            Caption = 'Freq. Error:'
          end
          object Label7: TLabel
            Left = 183
            Top = 11
            Width = 20
            Height = 13
            Alignment = taRightJustify
            Caption = 'MHz'
          end
          object AdvSmoothButton1: TAdvSmoothButton
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
            Version = '2.2.3.1'
            TMSStyle = 8
          end
          object AdvSmoothButton2: TAdvSmoothButton
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
            Version = '2.2.3.1'
            ModalResult = 2
            TMSStyle = 8
          end
          object edtCurrentRSSI1: TEdit
            Left = 108
            Top = 39
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 2
          end
          object edtPacketRSSI1: TEdit
            Left = 108
            Top = 66
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 3
          end
          object edtFrequencyError1: TEdit
            Left = 269
            Top = 66
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 4
          end
          object VrMediaButton5: TVrMediaButton
            Tag = 1
            Left = 209
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btNext
            TabOrder = 5
            OnClick = VrMediaButton1Click
          end
          object VrMediaButton6: TVrMediaButton
            Tag = 1
            Left = 5
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btBack
            TabOrder = 6
            OnClick = VrMediaButton2Click
          end
          object VrMediaButton7: TVrMediaButton
            Tag = 1
            Left = 53
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btPrev
            TabOrder = 7
            OnClick = VrMediaButton3Click
          end
          object VrMediaButton8: TVrMediaButton
            Tag = 1
            Left = 258
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btStep
            TabOrder = 8
            OnClick = VrMediaButton4Click
          end
          object edtFrequency1: TEdit
            Tag = 1
            Left = 108
            Top = 4
            Width = 69
            Height = 21
            Alignment = taCenter
            TabOrder = 9
            OnExit = edtFrequency0Exit
          end
          object chkAFC1: TAdvOfficeCheckBox
            Tag = 1
            Left = 233
            Top = 42
            Width = 49
            Height = 20
            TabOrder = 10
            OnClick = chkAFC0Click
            Alignment = taRightJustify
            Caption = 'AFC:'
            ReturnIsTab = False
            Version = '1.8.1.0'
          end
          object btnSearch2: TButton
            Tag = 1
            Left = 260
            Top = 94
            Width = 102
            Height = 27
            Caption = 'Search +/- 10kHz'
            TabOrder = 11
            OnClick = btnSearch1Click
          end
          object ProgressBar1: TProgressBar
            Left = 9
            Top = 94
            Width = 240
            Height = 27
            Max = 21
            BarColor = clNavy
            TabOrder = 12
          end
          object AdvGauge1: TAdvGauge
            Left = 5
            Top = 128
            Width = 353
            Height = 137
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
            Maximum = -80.000000000000000000
            MaxText = 'Right'
            Position = -150.000000000000000000
            SplitArcColor = clGreen
            SplitPosition = -130.000000000000000000
            TextPosition = tpNone
            TopPosition = 100.000000000000000000
            Version = '1.2.1.0'
          end
        end
      end
      inherited tabUplink: TTabSheet
        TabVisible = True
        inherited lblUploadPayload: TLabel
          Top = 18
          ExplicitTop = 18
        end
        inherited lblUploadType: TLabel
          Top = 120
          ExplicitTop = 120
        end
        object lblUploadChannel: TLabel [2]
          Left = 41
          Top = 56
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'LoRa Channel:'
        end
        inherited edtUploadPayload: TEdit
          Top = 15
          ExplicitTop = 15
        end
        inherited btnSendUpload: TButton
          Top = 197
          ExplicitTop = 197
        end
        object cmbUploadChannel: TComboBox [5]
          Left = 128
          Top = 53
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 3
          Text = '0'
          OnCloseUp = cmbUploadCommandCloseUp
          Items.Strings = (
            '0'
            '1')
        end
        inherited PageControl2: TPageControl
          Top = 100
          ActivePage = tabCutdown
          ExplicitTop = 100
        end
      end
    end
  end
  inherited tblPositions: TFDMemTable
    Left = 316
    Top = 304
  end
  inherited srcPositions: TDataSource
    Left = 204
    Top = 248
  end
  object tmrSearch: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrSearchTimer
    Left = 328
    Top = 79
  end
end
