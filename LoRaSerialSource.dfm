inherited frmLoRaSerialSource: TfrmLoRaSerialSource
  Caption = 'LoRa Serial Source'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited PageControl1: TPageControl
      ActivePage = TabSheet2
      inherited TabSheet1: TTabSheet
        inherited DBAdvGrid3: TDBAdvGrid
          ControlLook.FixedGradientHoverFrom = clGray
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Signal'
        ImageIndex = 1
        object pnlCommon: TAdvPanel
          Left = 0
          Top = 0
          Width = 374
          Height = 278
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
          ExplicitLeft = 2
          ExplicitTop = -2
          DesignSize = (
            370
            274)
          FullHeight = 337
          object Label9: TLabel
            Left = 35
            Top = 30
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = 'Current RSSI:'
          end
          object Label1: TLabel
            Left = 40
            Top = 70
            Width = 62
            Height = 13
            Alignment = taRightJustify
            Caption = 'Packet RSSI:'
          end
          object btnSave: TAdvSmoothButton
            AlignWithMargins = True
            Left = 447
            Top = 124
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
            Top = 124
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
            Left = 108
            Top = 27
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 2
          end
          object edtPacketRSSI: TEdit
            Left = 108
            Top = 67
            Width = 69
            Height = 21
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 3
          end
        end
      end
    end
  end
end
