inherited frmLoRaSerialSource: TfrmLoRaSerialSource
  Caption = 'LoRa Serial Source'
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
            Top = 39
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Current RSSI:'
          end
          object Label1: TLabel
            Left = 37
            Top = 66
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'Packet RSSI:'
          end
          object Label2: TLabel
            Left = 206
            Top = 61
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
          object Label5: TLabel
            Left = 239
            Top = 39
            Width = 24
            Height = 13
            Alignment = taRightJustify
            Caption = 'SNR:'
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
          object edtCurrentRSSI: TEdit
            Left = 108
            Top = 36
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 2
          end
          object edtPacketRSSI: TEdit
            Left = 108
            Top = 63
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 3
          end
          object edtFrequencyError: TEdit
            Left = 269
            Top = 58
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 4
          end
          object VrMediaButton1: TVrMediaButton
            Left = 209
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btNext
            TabOrder = 5
            OnClick = VrMediaButton1Click
          end
          object VrMediaButton2: TVrMediaButton
            Left = 5
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btBack
            TabOrder = 6
            OnClick = VrMediaButton2Click
          end
          object VrMediaButton3: TVrMediaButton
            Left = 53
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btPrev
            TabOrder = 7
            OnClick = VrMediaButton3Click
          end
          object VrMediaButton4: TVrMediaButton
            Left = 258
            Top = 4
            Width = 49
            Height = 26
            ButtonType = btStep
            TabOrder = 8
            OnClick = VrMediaButton4Click
          end
          object edtFrequency: TEdit
            Left = 108
            Top = 4
            Width = 69
            Height = 21
            Alignment = taCenter
            TabOrder = 9
            OnExit = edtFrequencyExit
          end
          object chkAFC: TAdvOfficeCheckBox
            Left = 313
            Top = 10
            Width = 49
            Height = 20
            TabOrder = 10
            Alignment = taRightJustify
            Caption = 'AFC:'
            ReturnIsTab = False
            Version = '1.8.1.0'
          end
          object ProgressBar1: TProgressBar
            Left = 5
            Top = 90
            Width = 240
            Height = 27
            Max = 21
            BarColor = clNavy
            TabOrder = 11
          end
          object Button2: TButton
            Left = 256
            Top = 90
            Width = 102
            Height = 27
            Caption = 'Search +/- 10kHz'
            TabOrder = 12
            OnClick = Button2Click
          end
          object AdvGauge1: TAdvGauge
            Left = 8
            Top = 123
            Width = 350
            Height = 140
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
          object edtSNR: TEdit
            Left = 269
            Top = 36
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 14
          end
        end
      end
      inherited tabUplink: TTabSheet
        TabVisible = True
        inherited lblUploadPayload: TLabel
          Left = 42
          Top = 10
          ExplicitLeft = 42
          ExplicitTop = 10
        end
        inherited lblUploadType: TLabel
          Left = 26
          Top = 90
          ExplicitLeft = 26
          ExplicitTop = 90
        end
        object Label4: TLabel [2]
          Left = 69
          Top = 37
          Width = 50
          Height = 13
          Alignment = taRightJustify
          Caption = 'Password:'
        end
        object lblWhenType: TLabel [3]
          Left = 42
          Top = 152
          Width = 74
          Height = 13
          Alignment = taRightJustify
          Caption = 'When To Send:'
        end
        object lblWhenSeconds: TLabel [4]
          Left = 10
          Top = 184
          Width = 112
          Height = 13
          Alignment = taRightJustify
          Caption = 'Seconds after minute@'
          Visible = False
        end
        object lblVersionInfo: TLabel [5]
          AlignWithMargins = True
          Left = 3
          Top = 260
          Width = 368
          Height = 13
          Align = alBottom
          Alignment = taCenter
          Caption = '**** Uplink Needs Firmware V2.00 or later ****'
          ExplicitWidth = 231
        end
        inherited edtUploadPayload: TEdit
          Top = 7
          ExplicitTop = 7
        end
        inherited btnSendUpload: TButton
          Top = 214
          ExplicitTop = 214
        end
        inherited PageControl2: TPageControl
          Left = 125
          Top = 61
          ActivePage = tabCutdown
          TabOrder = 3
          ExplicitLeft = 125
          ExplicitTop = 61
        end
        object edtPassword: TEdit
          Left = 128
          Top = 34
          Width = 121
          Height = 21
          TabOrder = 2
          OnKeyPress = edtUploadPayloadKeyPress
        end
        object cmbUploadWhen: TComboBox
          Left = 125
          Top = 149
          Width = 121
          Height = 21
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 4
          Text = 'Now'
          OnCloseUp = cmbUploadWhenCloseUp
          Items.Strings = (
            'Now'
            'At seconds'
            'After Rx')
        end
        object edtWhenSeconds: TEdit
          Left = 128
          Top = 180
          Width = 121
          Height = 21
          TabOrder = 5
          Text = '5'
          Visible = False
          OnKeyPress = edtUploadPayloadKeyPress
        end
      end
    end
  end
  inherited tblPositions: TFDMemTable
    Left = 264
    Top = 248
  end
  inherited srcPositions: TDataSource
    Left = 204
    Top = 248
  end
  inherited PopupMenu1: TPopupMenu
    Left = 336
    Top = 224
  end
  object tmrSearch: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrSearchTimer
    Left = 328
    Top = 231
  end
end
