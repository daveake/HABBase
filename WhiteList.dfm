inherited frmWhiteList: TfrmWhiteList
  Caption = 'Balloon Filter - Which Balloons To Show'
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlStatus: TAdvPanel
    FullHeight = 42
    inherited pnlHidden: TPanel
      ExplicitLeft = 383
    end
    inherited AdvSmoothButton1: TAdvSmoothButton
      Caption = 'Close'
      ExplicitLeft = 512
      ExplicitTop = 3
      ExplicitHeight = 43
      TMSStyle = 8
    end
    inherited AdvSmoothButton2: TAdvSmoothButton
      Visible = False
      ExplicitLeft = 386
      ExplicitTop = 3
      ExplicitHeight = 43
      TMSStyle = 8
    end
    object btnAppend: TAdvSmoothButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 54
      Height = 43
      Align = alLeft
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -24
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = []
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
      Caption = '+'
      ParentFont = False
      Shadow = True
      TabOrder = 3
      ShowFocus = False
      Version = '2.2.1.2'
      OnClick = btnAppendClick
      TMSStyle = 8
    end
    object btnDelete: TAdvSmoothButton
      AlignWithMargins = True
      Left = 63
      Top = 3
      Width = 54
      Height = 43
      Align = alLeft
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -32
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = []
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
      Caption = '-'
      ParentFont = False
      Shadow = True
      TabOrder = 4
      ShowFocus = False
      Version = '2.2.1.2'
      OnClick = btnDeleteClick
      TMSStyle = 8
    end
    object btnSave: TAdvSmoothButton
      AlignWithMargins = True
      Left = 123
      Top = 3
      Width = 54
      Height = 43
      Align = alLeft
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -32
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = []
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
      Caption = #10003
      ParentFont = False
      Shadow = True
      TabOrder = 5
      ShowFocus = False
      Version = '2.2.1.2'
      OnClick = btnSaveClick
      TMSStyle = 8
    end
    object btnCancel: TAdvSmoothButton
      AlignWithMargins = True
      Left = 183
      Top = 3
      Width = 54
      Height = 43
      Align = alLeft
      Appearance.Font.Charset = DEFAULT_CHARSET
      Appearance.Font.Color = 2303013
      Appearance.Font.Height = -32
      Appearance.Font.Name = 'Tahoma'
      Appearance.Font.Style = []
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
      Caption = #10008
      ParentFont = False
      Shadow = True
      TabOrder = 6
      ShowFocus = False
      Version = '2.2.1.2'
      OnClick = btnCancelClick
      TMSStyle = 8
    end
  end
  inherited pnlMain: TPanel
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 635
    ExplicitHeight = 250
    object Label1: TLabel
      Left = 367
      Top = 171
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Payload Mask:'
    end
    object Label2: TLabel
      Left = 368
      Top = 211
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'Max Distance:'
    end
    object Label3: TLabel
      Left = 551
      Top = 211
      Width = 13
      Height = 13
      Caption = 'km'
    end
    object DBAdvGrid2: TDBAdvGrid
      Left = 0
      Top = 0
      Width = 337
      Height = 250
      Cursor = crDefault
      Align = alLeft
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
      FixedColWidth = 60
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
          Width = 60
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
          Width = 45
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
          Width = 42
        end
        item
          Borders = []
          BorderPen.Color = clSilver
          ButtonHeight = 18
          CheckFalse = 'N'
          CheckTrue = 'Y'
          Color = clWindow
          FieldName = 'Remote'
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
          Width = 74
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
          Width = 67
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
      ColWidths = (
        60
        45
        42
        45
        74
        67)
    end
    object DBCheckBox1: TDBCheckBox
      Left = 368
      Top = 24
      Width = 97
      Height = 25
      Caption = ' Enabled'
      DataField = 'Enabled'
      DataSource = DataModule1.srcWhiteList
      TabOrder = 1
      OnClick = DBCheckBox1Click
    end
    object DBCheckBox2: TDBCheckBox
      Left = 368
      Top = 64
      Width = 97
      Height = 17
      Caption = ' Include HABs'
      DataField = 'HAB'
      DataSource = DataModule1.srcWhiteList
      TabOrder = 2
      OnClick = DBCheckBox1Click
    end
    object DBCheckBox3: TDBCheckBox
      Left = 368
      Top = 96
      Width = 97
      Height = 17
      Caption = ' Include Sondes'
      DataField = 'Sonde'
      DataSource = DataModule1.srcWhiteList
      TabOrder = 3
      OnClick = DBCheckBox1Click
    end
    object DBCheckBox4: TDBCheckBox
      Left = 368
      Top = 128
      Width = 201
      Height = 17
      Caption = 'Include Remotely Received'
      DataField = 'Remote'
      DataSource = DataModule1.srcWhiteList
      TabOrder = 4
      OnClick = DBCheckBox1Click
    end
    object DBEdit1: TDBEdit
      Left = 448
      Top = 168
      Width = 121
      Height = 21
      DataField = 'Mask'
      DataSource = DataModule1.srcWhiteList
      TabOrder = 5
      OnChange = DBEdit1Change
    end
    object DBEdit2: TDBEdit
      Left = 448
      Top = 208
      Width = 73
      Height = 21
      DataField = 'Distance'
      DataSource = DataModule1.srcWhiteList
      TabOrder = 6
      OnChange = DBEdit1Change
    end
  end
  object tmrInit: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrInitTimer
    Left = 560
    Top = 48
  end
end
