object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'HAB Base Station Manager'
  ClientHeight = 847
  ClientWidth = 1039
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvSplitter1: TAdvSplitter
    Left = 329
    Top = 0
    Width = 17
    Height = 798
    Appearance.BorderColor = clNone
    Appearance.BorderColorHot = clNone
    Appearance.Color = clWhite
    Appearance.ColorTo = clSilver
    Appearance.ColorHot = clWhite
    Appearance.ColorHotTo = clGray
    GripStyle = sgDots
    ExplicitLeft = 259
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 798
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object AdvSplitter2: TAdvSplitter
      Left = 0
      Top = 361
      Width = 329
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 193
      ExplicitWidth = 265
    end
    object AdvSplitter3: TAdvSplitter
      Left = 0
      Top = 602
      Width = 329
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 434
      ExplicitWidth = 265
    end
    object AdvSplitter6: TAdvSplitter
      Left = 0
      Top = 169
      Width = 329
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitLeft = 32
      ExplicitWidth = 265
    end
    object plMiddleLeft: TPanel
      Left = 0
      Top = 377
      Width = 329
      Height = 225
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 265
      object lstLog: TListBox
        Left = 0
        Top = 0
        Width = 329
        Height = 225
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        ExplicitWidth = 265
      end
    end
    object pnlWhiteList: TPanel
      Left = 0
      Top = 185
      Width = 329
      Height = 176
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 265
      object DBAdvGrid2: TDBAdvGrid
        Left = 0
        Top = 0
        Width = 329
        Height = 176
        Cursor = crDefault
        Align = alClient
        ColCount = 6
        DrawingStyle = gdsClassic
        FixedColor = clWhite
        FixedCols = 0
        RowCount = 2
        FixedRows = 1
        ScrollBars = ssBoth
        TabOrder = 0
        GridLineColor = 13948116
        GridFixedLineColor = 11250603
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = 4474440
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 11565130
        ActiveCellColorTo = 11565130
        BorderColor = 11250603
        ControlLook.FixedGradientFrom = clWhite
        ControlLook.FixedGradientTo = clWhite
        ControlLook.FixedGradientMirrorFrom = clWhite
        ControlLook.FixedGradientMirrorTo = clWhite
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientHoverMirrorFrom = clWhite
        ControlLook.FixedGradientHoverMirrorTo = clWhite
        ControlLook.FixedGradientHoverBorder = 11645361
        ControlLook.FixedGradientDownFrom = clWhite
        ControlLook.FixedGradientDownTo = clWhite
        ControlLook.FixedGradientDownMirrorFrom = clWhite
        ControlLook.FixedGradientDownMirrorTo = clWhite
        ControlLook.FixedGradientDownBorder = 11250603
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedColWidth = 45
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = 3881787
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glCustom
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.ColorTo = clWhite
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SearchFooter.ResultFormat = '(%d of %d)'
        SelectionColor = 13744549
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.HeaderColor = clWhite
        SortSettings.HeaderColorTo = clWhite
        SortSettings.HeaderMirrorColor = clWhite
        SortSettings.HeaderMirrorColorTo = clWhite
        UIStyle = tsCustom
        Version = '2.5.0.6'
        AutoCreateColumns = True
        AutoRemoveColumns = True
        Columns = <
          item
            Borders = []
            BorderPen.Color = clSilver
            ButtonHeight = 18
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            FieldName = 'Enabled'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 45
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            ButtonHeight = 18
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            FieldName = 'HAB'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 35
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            ButtonHeight = 18
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            FieldName = 'Sonde'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 38
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            ButtonHeight = 18
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            FieldName = 'Local'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 38
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            ButtonHeight = 18
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            EditLength = 20
            FieldName = 'Mask'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 49
          end
          item
            Alignment = taRightJustify
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
            HeaderFont.Color = 3881787
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 52
          end>
        DataSource = DataModule1.srcWhiteList
        InvalidPicture.Data = {
          055449636F6E0000010001002020200000000000A81000001600000028000000
          2000000040000000010020000000000000100000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000004000000020000000000000022
          0000002C0000002C000000220000000000000002000000040000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000020000002000000082484848C8707070F4
          707070FE707070F4606060C80000008200000020000000000000002000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000A1808080FEC0C0C0FF8080A0FF404080FF202000FF
          101080FF022080FF505090FF989888FFE0E0E8FF808080FE202020A200000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000084808080FF414180FF020004FF000000FF000008FF000000FF000080FF
          000080FF000080FF0000A0FF000098FF000080FF000080FF8484A4FFA0A0A0FF
          0808088500000000000000020000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000200000000808080E4
          C0C0C0FF010000FF000000FF000000FF000088FF00008CFF000092FF000098FF
          0404A0FF0800A0FF0808A0FF0D0CB0FF000082FF0000C0FF000080FF0000A0FF
          E2E2D2FF040404E5000000000000000A00000002000000000000000000000000
          00000000000000000000000000000000000000000000000A808080F94F404AFF
          000000FF000000FF000080FF000084FF000088FF00008CFF000090FF000098FF
          040482FF0000A0FF0808A0FF0C0CB0FF0E0E80FF0000C1FF1010C8FF0000C0FF
          000080FF5151A3FF818181F90000003000000008000000000000000000000000
          0000000000000000000000000000000000000010808080F9505080FF000000FF
          000000FF000080FF000080FF000080FF000088FF000081FF000090FF000098FF
          000480FF0406A0FF0800A8FF0808B0FF0C0CB0FF000080FF1010C0FF1210C0FF
          1010D1FF000080FF303090FF818181F900000004000000000000000000000000
          00000000000000000000000000000004808080E4494989FF000004FF000084FF
          000080FF000080FF000084FF000080FF000088FF00008DFF000090FF000090FF
          00009CFF0404A0FF0000A0FF0808A0FF0808B0FF0C0CB2FF000080FF1010C0FF
          1010C0FF1010C0FF000080FF707090FF000000E5000000010000000000000000
          00000000000000000000000080808080808080FF000000FF000088FF000088FF
          000080FF000084FF000080FF000000FF000080FF00008CFF000090FF000090FF
          000098FF040480FF0404A0FF0000A8FF0800A0FF000080FF020280FF000081FF
          0000C0FF1010C0FF1000C8FF020280FFE0E0E0FF080808850000000000000000
          000000000000000000000000818181FF000002FF000000FF000080FF000088FF
          000088FF000080FF000080FF000084FF000000FF000088FF000090FF000094FF
          000098FF000080FF0404A2FF0200A0FF000080FF212080FF000080FF000090FF
          0C0C80FF000080FF0100C0FF000081FF000080FFA0A0A0FF0000000000000000
          0000000000000000888888A0C0C0C4FF000009FF000090FF000092FF000080FF
          000088FF000080FFA0A0A0FF828280FF101094FF000000FF000080FF000090FF
          000090FF000098FF000080FF000080FF818182FFC0C0C0FFC0C0E0FF000080FF
          000090FF0C0CB0FF0C0C80FF000080FF000080FFC0C0C0FF080808A100000006
          0000000000000000808080FE000000FF040480FF000090FF000094FF000090FF
          000080FF8888A0FFA0A0A0FFA0A0A0FF808080FF181890FF000000FF000080FF
          000090FF000098FF000080FF8080A2FF808080FFC0C0C0FFC4C4C4FFC0C0C0FF
          000080FF0808B0FF0808B3FF080CB0FF0000A0FF000080FF808080FE00000002
          0000000000000000C0C0C0FF040480FF2828A0FF000080FF000090FF000090FF
          000094FF010190FF8080A0FFA0A0A0FFA0A0A0FF808080FF000094FF000004FF
          000084FF000080FF202080FFA0A0A0FFB0B0B0FF808080FFC0C0C0FF0000A0FF
          0000A8FF0000ABFF0801A0FF0808A0FF0808A0FF000080FFC0C0C0FF00000020
          0000000090909080C0C0C0FF040400FF2C2CA0FF2C28A6FF000080FF000098FF
          000090FF000090FF020296FF8080A0FFA2A2A2FFA0A0A0FF808080FF181894FF
          000000FF000080FF989898FF808080FFA1A1A1FF808080FF000098FF000080FF
          0404A0FF0504A0FF0604A1FF0606A0FF0000A2FF000080FFC0C0C0FF20202081
          00000002808080C1808080FF000080FF2E2EA8FF2C2CA8FF2C2CA0FF000080FF
          000098FF000098FF000090FF020296FF8181A1FFA8A8A8FFA0A0A0FF808080FF
          80808CFF989898FF999999FF999999FF888880FF000084FF000098FF020280FF
          000281FF0000A0FF0000A0FF0404A0FF0404A0FF000080FF808084FF484848CA
          00000008808080F1707080FF101080FF3030A0FF2020A8FF2C2CA8FF2C2CA0FF
          000080FF000080FF000098FF000080FF000080FF8080A0FFA0A0A0FFA1A1A1FF
          A0A0A0FF9C9C9CFF989898FF808090FF000090FF000090FF000098FF000098FF
          000098FF000099FF02009AFF000098FF020299FF000080FF484880FF404040F2
          0000000D909090FE606080FF1010A0FF3232B0FF3030B0FF2020A0FF2E20A8FF
          2C2CA8FF0000A0FF000080FF00009CFF000081FF202080FFB0B0B0FFA0A0A0FF
          A0A0A0FFA0A0A0FF909088FF000000FF000080FF000096FF000090FF000090FF
          000090FF000090FF000090FF000090FF000095FF000080FF404080FF585858FE
          00000008A0A0A0F1020292FF1414A8FF3434B2FF3130B4FF3232B1FF3030B0FF
          2020A0FF202EA8FF2C2CA8FF0000A0FF000080FF828280FF808080FFB0B0B0FF
          A0A0A0FFA0A0A0FFA0A080FF202080FF000004FF000084FF000094FF000094FF
          000094FF000090FF000090FF000090FF000082FF000001FF404080FF505050F2
          00000002808080C1808080FF101081FF3038B8FF3030B2FF3435B0FF3031B1FF
          3230B0FF3130A0FF2020A0FF202080FF8282C0FFC0C0C0FF848484FF808080FF
          B0B0B0FFA2A2A2FFA0A0A0FF828282FF202080FF000004FF000084FF000090FF
          000092FF000090FF000080FF000080FF00008CFF000000FF808080FF404040CA
          0000000084848481E0E0E0FF10008AFF383880FF3838BCFF3038B8FF3030B0FF
          3434B0FF3030B0FF222080FFA0A0C0FFC0C0C0FFD0D0D0FFD0D0D0FFC0C0C0FF
          808080FF808080FFA1A1A1FFA0A0A0FFA0A082FF000080FF000000FF000080FF
          000090FF000081FF00008EFF00008CFF000088FF000000FFC0C080FF00000096
          0000000000000000E0E0E0FF000080FF3D3DC0FF393CC0FF383880FF3838BCFF
          3030B9FF0000A0FFC0C0E1FFE0E0E0FFE0E0E0FFC0C0C0FFD0D0D0FF202080FF
          0000A0FF000080FF888880FFB0B0B0FFA2A2A2FFA0A0A0FF000080FF000001FF
          000080FF000082FF000080FF00008CFF000088FF000000FFC0C0C0FF00000000
          0000000000000000C0C0C0FE000080FF404080FF4040C4FF0000C0FF3C3CC0FF
          0808A0FFC7C7EDFFFAFAFAFFF0F0F0FFE0E0E2FFE2E2E0FF282884FF2020A0FF
          3030A8FF2020A0FF040480FF888884FFB0B0B0FFA2A2A2FFA0A0A0FF000180FF
          000081FF202090FF222090FF1E1E81FF000082FF000000FF808080FE00000004
          000000000000000080808098EAEAEAFF000180FF4042C8FF4142C0FF4040C0FF
          000080FFB3B4EEFFFFFFFFFFFDFDFDFFF8F8F0FF080094FF3020B0FF3434B1FF
          3030B0FF3230A0FF2020A0FF000080FF909085FFB0B0B0FFA4A4B0FF000080FF
          212180FF202498FF242090FF202090FF000000FF808180FF101010A000000000
          000000000000000000000000C0C0C0FF202090FF00008AFF4444C8FF4040C8FF
          0200C0FF3030C2FFB5B5F0FFFFFFFFFF0000A0FF2828B2FF3A38B8FF3838B2FF
          3030B0FF3434B0FF3034B0FF2020A0FF010182FF808080FF000080FF000080FF
          2828A0FF282880FF202080FF000182FF000000FF808080FF0000000000000000
          00000000000000000000000080808081F8F8F8FF000081FF0404CAFF4444C0FF
          4444CAFF4041C8FF0001C0FF0909C2FF000080FF0000C0FF3C3C81FF383CBCFF
          3838B8FF3838B2FF3830B4FF3030B0FF2020B0FF050480FF202080FF3030A8FF
          2020A0FF2C2CA0FF0C0C80FF000000FF8C8C8CFF000000800000000000000000
          00000000000000000000000000000000929292E0D0D0D0FF020080FF0808C0FF
          4040C0FF4640C0FF4444C8FF4444C8FF4040C0FF4240C0FF4040C4FF0040C0FF
          000080FF3C3CBCFF3839B8FF3A38B0FF3838B0FF3030B0FF3036B0FF3034A1FF
          3030A9FF2020A8FF000881FF808080FF808080E2000000000000000000000000
          0000000000000000000000000000000000000000C0C0C0F9C2C2C2FF000280FF
          0808C0FF4848D0FF4848C0FF4040C0FF4446C8FF4444C8FF4040C0FF4040C0FF
          4041C0FF4040C0FF000080FF3D3DBCFF3C3CB8FF3838B0FF3838B0FF3838B0FF
          2022A0FF000084FF808080FF808080F900000000000000000000000000000000
          000000000000000000000000000000000000000000000000C0C0C0F9E0E0E0FF
          0000A0FF000080FF4040D0FF4848D0FF4848C0FF4040C0FF4640CAFF4444CAFF
          4444C0FF4040C0FF4242C4FF4040C0FF400080FF0000BDFF003CB8FF0810A6FF
          101080FF808180FF808080F90000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000909090E0
          F0F0F0FF8A8A82FF101080FF000080FF4040C0FF4848D2FF4A48C0FF4048C0FF
          4040C8FF4646C8FF4444C8FF4444C4FF4040C4FF000080FF000080FF020084FF
          808080FF808080E1000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          80808080C0C0C0FFE6E6E6FF818189FF404080FF000080FF4040C0FF0000C4FF
          0000C2FF000080FF000480FF101080FF000080FF020080FF808080FF808080FF
          8080808000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000080808098C0C0C0FEE0E0E0FFE2E2E2FFC0C0C0FFA4A4A4FF
          A0A0A0FFA8A8A8FFA0A0A0FFC0C0C0FFC0C0C0FF808080FE8080809800000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000080808081808080C0A0A0A0F1
          A0A0A0FEA0A0A0F1808080C08080808100000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FF8001FFFE00007FF800001FF000000FE0000007C0000003C0000003
          8000000180000001000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000080000001
          8000000180000003C0000003E0000007F000000FF800001FFC00007FFE0000FF
          FFC007FF}
        ShowUnicode = False
        ExplicitWidth = 265
        ColWidths = (
          45
          35
          38
          38
          49
          52)
      end
    end
    object pnlSources: TPanel
      Left = 0
      Top = 618
      Width = 329
      Height = 180
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitWidth = 265
      object DBAdvGrid1: TDBAdvGrid
        Left = 0
        Top = 0
        Width = 329
        Height = 180
        Cursor = crDefault
        Align = alClient
        ColCount = 5
        DrawingStyle = gdsClassic
        FixedColor = clWhite
        FixedCols = 0
        RowCount = 2
        FixedRows = 1
        ScrollBars = ssBoth
        TabOrder = 0
        GridLineColor = 13948116
        GridFixedLineColor = 11250603
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = 4474440
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 11565130
        ActiveCellColorTo = 11565130
        BorderColor = 11250603
        ControlLook.FixedGradientFrom = clWhite
        ControlLook.FixedGradientTo = clWhite
        ControlLook.FixedGradientMirrorFrom = clWhite
        ControlLook.FixedGradientMirrorTo = clWhite
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientHoverMirrorFrom = clWhite
        ControlLook.FixedGradientHoverMirrorTo = clWhite
        ControlLook.FixedGradientHoverBorder = 11645361
        ControlLook.FixedGradientDownFrom = clWhite
        ControlLook.FixedGradientDownTo = clWhite
        ControlLook.FixedGradientDownMirrorFrom = clWhite
        ControlLook.FixedGradientDownMirrorTo = clWhite
        ControlLook.FixedGradientDownBorder = 11250603
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedColWidth = 20
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = 3881787
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glCustom
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.ColorTo = clWhite
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SearchFooter.ResultFormat = '(%d of %d)'
        SelectionColor = 13744549
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.HeaderColor = clWhite
        SortSettings.HeaderColorTo = clWhite
        SortSettings.HeaderMirrorColor = clWhite
        SortSettings.HeaderMirrorColorTo = clWhite
        UIStyle = tsCustom
        Version = '2.5.0.6'
        AutoCreateColumns = True
        AutoRemoveColumns = True
        Columns = <
          item
            Alignment = taRightJustify
            Borders = []
            BorderPen.Color = clSilver
            ButtonHeight = 18
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            FieldName = 'ID'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 20
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            ButtonHeight = 18
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            EditLength = 3
            FieldName = 'Code'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
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
            EditLength = 20
            FieldName = 'Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
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
            FieldName = 'LastPacket'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
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
            EditLength = 20
            FieldName = 'Payload'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = 3881787
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
          end>
        DataSource = DataModule1.srcSources
        InvalidPicture.Data = {
          055449636F6E0000010001002020200000000000A81000001600000028000000
          2000000040000000010020000000000000100000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000006A6A6B256A6A6B606A6A6B946A6A6BC06A6A6BE1
          6A6A6BF86A6A6BF86A6A6BE16A6A6BC06A6A6B946A6A6B606A6A6B2500000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000006A6A6B407575769E787879F19F9F9FF6C0C0C0FDDADADAFFEDEDEEFF
          FBFBFBFFFBFBFBFFEDEDEEFFDADADAFFC0C0C0FD9F9F9FF6787879F17575769E
          6A6A6B4000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000006A6A6B22
          7C7C7C98888889F0BDBDBDFCE9E9EBFED9D9E9FEB5B5DDFE8B8BCDFE595AB7FF
          3739A8FF2B2CA4FF4A49B1FF7171C1FFA1A2D7FFD3D3E8FFEAEAEBFEBEBEBFFC
          888889F07C7C7C986A6A6B220000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000006A6A6B43838383D8
          B7B7B8FAECECEFFEC0C0DFFF7977C4FF2221A0FF12129BFF1010A4FF0C0CA8FF
          0A0AACFF0A0AB4FF0A0AB9FF0D0DBEFF0F0FB1FF1111A6FF5656B8FFAEADDCFF
          ECECEFFEB7B7B8FA838383D86A6A6B4300000000000000000000000000000000
          00000000000000000000000000000000000000006A6A6B4E878788EAD3D3D3FE
          CACAE8FF4443B0FF171799FF11119CFF0C0C98FF0B0B9BFF0B0BA0FF0A0AA6FF
          0909ACFF0909B2FF0808BAFF0707BFFF0B09C8FF0D0DCEFF1111CCFF1010AFFF
          4A49B2FFCFCFEBFFD3D3D3FE878788EA6A6A6B4E000000000000000000000000
          000000000000000000000000000000006A6A6B43878788EAE1E1E1FFA8A8DAFF
          2323A0FF15159CFF0D0D92FF0C0C95FF0C0C99FF0B0B9EFF0B0BA0FF0A0AA6FF
          0909ACFF0909B2FF0808B8FF0808BCFF0808C3FF0C0CC9FF0C0CD0FF0D0DD6FF
          1313CFFF2222A9FFAFAFDEFFE1E1E1FF878788EA6A6A6B430000000000000000
          0000000000000000000000006A6A6B22838383D8D3D3D3FEA8A8D9FF2020A4FF
          13139BFF0C0C92FF0C0C95FF0C0C97FF0C0C99FF0B0B9EFF0B0BA0FF0A0AA4FF
          0A0AA9FF0909B0FF0808B4FF0808BBFF0707C0FF0A0AC6FF0909CCFF0C0CD3FF
          0D0DD8FF1313D3FF1A1AA8FFAEADDEFFD4D4D4FE838383D86A6A6B2200000000
          0000000000000000000000007C7C7C98B7B7B8FACACAE8FF2524A3FF13139FFF
          0C0C97FF0C0C95FF0C0C95FF0C0C91FF0C0C95FF0B0B9EFF0B0BA0FF0A0AA4FF
          0A0AA8FF0909ADFF0909B2FF0808B8FF0808BCFF0707C0FF0808BCFF0707C5FF
          0C0CD3FF0D0DD7FF1212D1FF2020A7FFCDCDEBFFB8B8B9FA7C7C7C9800000000
          00000000000000006A6A6B40888889F0ECECEFFE4545B1FF1616A4FF0B0B9BFF
          0C0C99FF0C0C96FF3333A2FFB9B9D0FF393A9BFF0C0C95FF0B0BA1FF0A0AA4FF
          0A0AA7FF0A0AABFF0909B0FF0808B4FF0808B7FF2F2FC2FFAEAEE2FF4B4BBFFF
          0707BEFF0B0BD1FF0C0CD3FF1413CCFF4848B1FFECECEFFE888889F06A6A6B40
          00000000000000007575769EBFBFBFFD9B9BD5FF1C1CA6FF0C0CA1FF0B0B9FFF
          0B0B9AFF3535A7FFB5B5BEFFE6E6DFFFEDEDEFFF3C3C9CFF0C0C97FF0A0AA4FF
          0A0AA6FF0A0AA9FF0909ADFF0909B0FF2626B5FFCECEDEFFFFFFFBFFEEEEF1FF
          4848BAFF0808BCFF0A0ACDFF0B0BCEFF1111ABFFBEC0E0FFBFC0BFFD7575769E
          000000006A6A6B25787879F1E3E3E5FE4646B2FF1414A8FF0A0AA4FF0B0BA0FF
          2121A9FFBDBDCAFFD0D0C8FFC5C5C5FFE3E3E1FFEDEDEFFF3E3E9EFF0C0C98FF
          0A0AA6FF0A0AA8FF0A0AA9FF2B2BB0FFC0C0CDFFEAEAE2FFEBEBEBFFFEFEF8FF
          EDEDEEFF2828BDFF0707C4FF0809C7FF0F0FC4FF8788CBFFEBEBECFE79797AF1
          6A6A6B256A6A6B609D9E9DF6D6D7E4FF3A3AB3FF1212ADFF0A0AA8FF0A0AA4FF
          1313AAFFABABCFFFD6D6CBFFCACACAFFC6C6C6FFE4E4E0FFEEEEEFFF3F3FA0FF
          0C0C99FF0A0AA6FF2828ABFFB2B2BFFFD8D8CEFFD6D6D8FFE0E0E0FFF6F5EDFF
          D1D1EDFF1E1CC0FF0707BEFF0707BFFF0707C0FF2120AAFFD3D5E9FE9FA0A0F6
          6A6A6B606A6A6B94BDBDBDFBBABBDCFF3A39B7FF2F2FB8FF0909ADFF0A0AA9FF
          0A0AA6FF1515ACFFADADCFFFD6D6CBFFCBCBCAFFC6C6C6FFE4E4E1FFEEEEEFFF
          3838A1FF2222A2FFACABB8FFC8C8C0FFC7C7C8FFCDCDCDFFE1E1D9FFC8CAE1FF
          2424BCFF0808B4FF0808B9FF0808BAFF0808BBFF0F0EABFFA1A2D5FEC0C0C0FC
          6A6A6B946A6A6BC0D9D8D7FE9999D1FF3838BBFF3636BCFF2C2CB7FF0909ADFF
          0A0AA9FF0A0AA4FF1C1CAFFFB1B1CFFFD6D6CBFFCCCCCBFFC7C7C7FFE4E4E1FF
          ECECEEFFACACB7FFC2C2BCFFBEBEBFFFC0C0C0FFCFCFC6FFC1C1D5FF2727B8FF
          0909ACFF0909B2FF0909B2FF0909B4FF0808B4FF0E0EB5FF6E6EBFFFD9D9D9FE
          6A6A6BC06A6A6BE1EBEAEBFF7D7CC7FF3838BFFF3434BEFF3536BEFF2A2AB8FF
          0909B0FF0909ACFF0A0AA8FF1C1CB1FFB2B2D0FFD7D7CCFFCBCBCBFFC7C7C8FF
          C8C8C3FFC6C6C3FFBFBFC1FFBDBDBDFFC5C5BCFFB8B8CEFF2929B5FF0A0AA8FF
          0909ACFF0909ADFF0909AFFF0909AFFF0909AFFF0C0CB0FF4747AFFFECECEDFF
          6A6A6BE16A6A6BF8F9F9F9FF6666C1FF3838C4FF3535C2FF3434C0FF3535BEFF
          3030BCFF1313B4FF0909ADFF0A0AA8FF1E1EB3FFAAAAD0FFD3D3CDFFCCCCCCFF
          C8C8C8FFC3C3C3FFC2C2C1FFC4C4BFFFB2B2CBFF2B2BB4FF0A0AA4FF0A0AA8FF
          0A0AA8FF0A0AA9FF0A0AA9FF0A0AA9FF0A0AA9FF0B0BA9FF3131A6FFFAFAFAFF
          6A6A6BF86A6A6BF8FBFBFBFF5959BEFF3B3BCAFF3A3AC8FF3737C4FF3535C2FF
          3636C0FF3636BEFF2323B8FF0909B1FF0A0AA7FF4949BEFFD6D6D4FFD3D3D1FF
          CDCDCDFFC8C8C8FFC4C4C3FFEDEDEDFF5F5FB3FF0C0C98FF0A0AA7FF0A0AA6FF
          0A0AA6FF0A0AA6FF0A0AA4FF0A0AA6FF0A0AA4FF0B0BA4FF2D2DA6FFFBFBFBFF
          6A6A6BF86A6A6BE1EDEDEEFF7F80CBFF4041CCFF3C3CCAFF3A3AC8FF383AC8FF
          3838C4FF3636C2FF3939C0FF2123B7FF4A4AC2FFCBCBDEFFE0E0DCFFD6D6D6FF
          D2D2D3FFCDCDCEFFC9C9C9FFE2E2E1FFF1F1F2FF4242A3FF0C0C99FF0A0AA4FF
          0A0AA4FF0A0AA4FF0B0BA3FF0B0BA3FF0B0BA1FF0E0EA1FF4443B0FFEDEDEEFF
          6A6A6BE16A6A6BC0DADADAFF9C9BD5FE4949CDFF3E3DD0FF3C3DCEFF3C3CCAFF
          3A3AC8FF3B39C7FF2828BDFF5C5CCCFFE5E5EDFFF4F4EDFFE5E5E6FFDEDEDEFF
          DCDCD9FFD9D9D3FFCDCDCDFFC8C8C8FFE5E5E1FFF1F1F3FF3F3FA0FF0C0C99FF
          0A0AA4FF0B0BA1FF0B0BA0FF0B0BA0FF0B0B9FFF1313A2FF6B6BC0FFDADADAFF
          6A6A6BC06A6A6B94C0C0C0FDBDBAE1FE5655CFFF4141D4FF3F3FD2FF3F3FCEFF
          3D3DCCFF2C2AC3FF5E5ED3FFEBEBF6FFFFFFFAFFF1F1F1FFEDEDEEFFF0F0E9FF
          D2D2E6FFBDBDD6FFDADAD3FFCFCFCFFFC9C9CAFFE5E5E2FFF1F1F3FF3A3AA0FF
          0C0C98FF0B0BA3FF0B0B9FFF0B0B9EFF0B0B9EFF1C1CA4FF9C9CD3FFC1C1C1FD
          6A6A6B946A6A6B609F9F9FF6DAD9EAFF6B6BCFFF4444D7FF4143D6FF4242D3FF
          3434CDFF6464DBFFEFEFFFFFFFFFFFFFFCFCFCFFF6F6F6FFFCFCF4FFE2E1F0FF
          5050CCFF4040C1FFC3C3DBFFE1E1D8FFD4D4D5FFCFCFCFFFE8E8E5FFF2F2F4FF
          4040A2FF0C0C99FF0F0FA2FF0F0FA0FF0F0F9DFF302FA9FFD1D1E8FEA0A0A0F6
          6A6A6B606A6A6B25787879F1E9E9EBFEA7A7DAFF6060DBFF4547DBFF3C3CD6FF
          5857DEFFF2F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E8F8FF5B5BD4FF
          2828BDFF2A2BBDFF4949C5FFC3C3DBFFE4E4DAFFD5D5D5FFCECED0FFE8E8E5FF
          F4F4F4FF4949AFFF2121A6FF2A2AA6FF2C2BA9FF5557B8FFEAEAECFE787879F1
          6A6A6B25000000007575769EBEBEBEFDC9CAE6FF7A79DBFF4C4CDFFF4141DBFF
          5757E0FFEAEAFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E7FFFF5B5BD7FF2E2EC6FF
          3E3EC9FF3A3AC5FF2C2EC1FF4A49C8FFC2C2DDFFE3E3DAFFD5D5D4FFDADAD3FF
          CACBD9FF4747BBFF2525ADFF2C2BACFF3332AEFFA5A4D8FFBFBFBFFD7575769E
          00000000000000006A6A6B40888889F0ECECEFFE9696D6FF7B7BE3FF4D4BE0FF
          4141DBFF5F5FE6FFE7E7FFFFFFFFFFFFE9E9FFFF5A5ADCFF3333CAFF4242CFFF
          4040CBFF3D3DC9FF3D3EC8FF3030C2FF4848C9FFC0C0DDFFECEEDEFFD0D0E0FF
          5554C7FF2828B3FF3232B4FF3434B1FF5453B7FFECECEFFE888889F06A6A6B40
          0000000000000000000000007C7C7C98B7B7B8FAD0D0ECFF8F8FDBFF6868E3FF
          4E4EE2FF3E40DBFF6565E9FFB2B2F7FF6565E4FF393BD2FF4646D7FF4343D4FF
          4343D1FF4242CFFF4040CBFF3F3FCAFF3333C4FF4E4ECBFF9E9EE2FF5C5BCFFF
          292ABAFF3636BCFF3938B8FF3F3EB1FFCBCBE9FFB7B7B8FA7C7C7C9800000000
          0000000000000000000000006A6A6B22838383D8D3D3D3FEB5B5E2FF9E9EE4FF
          6766E2FF4E50E6FF4646E0FF3D3DDAFF4444DCFF4B4BDCFF4848DBFF4847D9FF
          4646D5FF4443D3FF4343D1FF4242CFFF4143CDFF3A3AC8FF312FC5FF3535C3FF
          3C3CC3FF3D3DBEFF403FB5FFACACDCFFD3D3D3FE838383D86A6A6B2200000000
          000000000000000000000000000000006A6A6B43878788EAE1E1E1FFB5B5E2FF
          A7A6E4FF7877E5FF5151E5FF4F4FE4FF4E4EE2FF4D4DE0FF4C4CDEFF4B4BDCFF
          4949DBFF4848D7FF4747D5FF4545D3FF4545D1FF4343CFFF4242CCFF3F3FCBFF
          4343C2FF4645B6FFADADDCFFE1E1E1FF878788EA6A6A6B430000000000000000
          00000000000000000000000000000000000000006A6A6B4E878788EAD3D3D3FE
          D0D0ECFFAAA9DFFFA2A2ECFF6565E3FF5151E6FF4F4FE4FF4F4DE4FF4D4DE0FF
          4D4DDFFF4D4DDCFF4C49DBFF4A4AD8FF4749D6FF4747D4FF4949CBFF4B4BC3FF
          8E8ED0FFCDCCE8FFD3D3D3FE878788EA6A6A6B4E000000000000000000000000
          0000000000000000000000000000000000000000000000006A6A6B43838383D8
          B7B7B8FAECECEFFEC3C2E5FFADAEE1FF9E9DE8FF6F6FE0FF5C5CE1FF5452E2FF
          5051E1FF4F4FDFFF4F4FDBFF5150D6FF5151CFFF5F5FC8FFA1A1D3FEC7C8E0FE
          E4E4E7FEB7B7B8FA838383D86A6A6B4300000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000006A6A6B22
          7C7C7C98888889F0BFBFBFFDEBEBECFED8D9EBFEBDBDE4FEA8A7DCFF9695D7FF
          8886D4FF7F7DCEFF8C8BD2FFA1A2D9FFC0BEE1FED9D9EAFEEAEAECFEBFBFBFFD
          888889F07C7C7C986A6A6B220000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000006A6A6B407575769E787879F19F9F9FF6C0C0C0FDDADADAFFEDEDEEFF
          FBFBFBFFFBFBFBFFEDEDEEFFDADADAFFC0C0C0FD9F9F9FF6787879F17575769E
          6A6A6B4000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000006A6A6B256A6A6B606A6A6B946A6A6BC06A6A6BE1
          6A6A6BF86A6A6BF86A6A6BE16A6A6BC06A6A6B946A6A6B606A6A6B2500000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FFC003FFFF0000FFFC00003FF800001FF000000FE0000007C0000003
          C000000380000001800000010000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000080000001
          80000001C0000003C0000003E0000007F000000FF800001FFC00003FFF0000FF
          FFC003FF}
        ShowUnicode = False
        ExplicitWidth = 265
        ColWidths = (
          20
          64
          64
          64
          64)
      end
    end
    object pnlPayloads: TPanel
      Left = 0
      Top = 0
      Width = 329
      Height = 169
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      ExplicitLeft = -6
      ExplicitWidth = 265
    end
  end
  object pnlMain: TPanel
    Left = 346
    Top = 0
    Width = 693
    Height = 798
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 282
    ExplicitWidth = 757
    object AdvSplitter4: TAdvSplitter
      Left = 0
      Top = 281
      Width = 693
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 193
      ExplicitWidth = 265
    end
    object AdvSplitter5: TAdvSplitter
      Left = 0
      Top = 522
      Width = 693
      Height = 16
      Cursor = crVSplit
      Align = alTop
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      GripStyle = sgDots
      ExplicitTop = 434
      ExplicitWidth = 265
    end
    object pnlMiddle: TPanel
      Left = 0
      Top = 297
      Width = 693
      Height = 225
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 757
    end
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 693
      Height = 281
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 757
    end
    object pnlBottom: TPanel
      Left = 0
      Top = 538
      Width = 693
      Height = 260
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitWidth = 757
    end
  end
  object pnlStatus: TAdvPanel
    Left = 0
    Top = 798
    Width = 1039
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Color = 15395562
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    UseDockManager = True
    Version = '2.5.10.2'
    BorderColor = clGray
    Caption.Color = 15722471
    Caption.ColorTo = 11176072
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clBlack
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Height = 24
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clHighlight
    CollapsDelay = 0
    ColorTo = 13948116
    ColorMirror = 13948116
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
    FullHeight = 42
    object pnlHidden: TPanel
      Left = 1039
      Top = 0
      Width = 0
      Height = 49
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
  end
end
