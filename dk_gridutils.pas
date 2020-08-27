unit DK_GridUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, fpspreadsheetgrid, rxdbgrid, DK_Fonts, fpstypes;

const
  DEFAULT_GRID_FONTLIKE  =  flArial;
  DEFAULT_GRID_FONTSIZE  =  8;
  DEFAULT_GRID_FONTSTYLE =  [];
  DEFAULT_GRID_FONTCOLOR =  clBlack;
  DEFAULT_GRID_COLOR     =  clWhite;

  procedure SetGridDefaultFontAndColor(const AGrid: TsWorksheetGrid);
  procedure SetGridDefaultFontAndColor(const AGrid: TRxDBGrid);
  procedure LoadFontFromGrid(const AGrid: TsWorksheetGrid;
                             out AFontName: String; out AFontSize: Single);
  procedure LoadFontFromGrid(const AGrid: TRxDBGrid;
                             out AFontName: String; out AFontSize: Single);
  procedure DrawFrozenBorders(const AGrid: TsWorksheetGrid;
                              const ACol, ARow,AFrozenCol1, AFrozenRow1, AFrozenCol2, AFrozenRow2: Integer;
                              const ARect: TRect;
                              const ALineColor: TColor = clBlack);
  function CalcWorksheetGridColumnWidth(const ATotalWidth, AOtherWidth: Integer): Integer;
  function HorAlignmentRxToXls(const A: TAlignment): TsHorAlignment;

implementation

function CalcWorksheetGridColumnWidth(const ATotalWidth, AOtherWidth: Integer): Integer;
begin
  Result:= ATotalWidth - AOtherWidth;
  Result:= Result - (ATotalWidth div 20) - 25;
end;

procedure DrawFrozenBorders(const AGrid: TsWorksheetGrid;
                            const ACol, ARow, AFrozenCol1, AFrozenRow1, AFrozenCol2, AFrozenRow2: Integer;
                            const ARect: TRect;
                            const ALineColor: TColor = clBlack);
begin
  if (ACol=AFrozenCol1-1)and
     ((ARow>=AFrozenRow1) and (ARow<=AFrozenRow2)) then
  begin
    AGrid.Canvas.Pen.Color:= ALineColor;
    AGrid.Canvas.MoveTo(ARect.Right-1, ARect.Top);
    AGrid.Canvas.LineTo(ARect.Right-1, ARect.Bottom);
  end;
  if ((ACol>=AFrozenCol1) and (ACol<=AFrozenCol2)) and
     ((ARow>=AFrozenRow1) and (ARow<=AFrozenRow2)) then
  begin
    AGrid.Canvas.Pen.Color:= ALineColor;
    AGrid.Canvas.MoveTo(ARect.Left-1, ARect.Top);
    AGrid.Canvas.LineTo(ARect.Right-1, ARect.Top);
    AGrid.Canvas.LineTo(ARect.Right-1, ARect.Bottom);
    AGrid.Canvas.LineTo(ARect.Left-1, ARect.Bottom);
    AGrid.Canvas.LineTo(ARect.Left-1, ARect.Top);
  end;
end;

procedure LoadFontFromGrid(const AGrid: TRxDBGrid;
                           out AFontName: String; out AFontSize: Single);
begin
  FontParamsLoad(AGrid.Font.Reference.Handle, AGrid.Font.PixelsPerInch, AFontName, AFontSize);
end;

procedure SetGridDefaultFontAndColor(const AGrid: TsWorksheetGrid);
begin
  AGrid.Font.Name:= FontLikeToName(DEFAULT_GRID_FONTLIKE);
  AGrid.Font.Size:= DEFAULT_GRID_FONTSIZE {$IFDEF LINUX} -2 {$ENDIF};
  AGrid.Font.Color:= DEFAULT_GRID_FONTCOLOR;
  AGrid.Font.Style:= DEFAULT_GRID_FONTSTYLE;
  AGrid.Color:= DEFAULT_GRID_COLOR;
end;

procedure SetGridDefaultFontAndColor(const AGrid: TRxDBGrid);
begin
  AGrid.Font.Name:= FontLikeToName(DEFAULT_GRID_FONTLIKE);
  AGrid.Font.Size:= DEFAULT_GRID_FONTSIZE {$IFDEF LINUX} -2 {$ENDIF};
  AGrid.Font.Color:= DEFAULT_GRID_FONTCOLOR;
  AGrid.Font.Style:= DEFAULT_GRID_FONTSTYLE;
  AGrid.Color:= DEFAULT_GRID_COLOR;
end;

procedure LoadFontFromGrid(const AGrid: TsWorksheetGrid;
                           out AFontName: String; out AFontSize: Single);
begin
  FontParamsLoad(AGrid.Font.Reference.Handle, AGrid.Font.PixelsPerInch, AFontName, AFontSize);
end;

function HorAlignmentRxToXls(const A: TAlignment): TsHorAlignment;
begin
  case A of
    taCenter: Result:= haCenter;
    taLeftJustify: Result:= haLeft;
    taRightJustify: Result:= haRight;
  end;
end;

end.

