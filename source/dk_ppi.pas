unit DK_PPI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Controls, Forms, LCLType;

const
  DEFAULT_PPI = 96;

  function ControlDesignTimePPI(const AControl: TControl): Integer;

  function SizeFromPPIToPPI(const ASize, AFromPPI, AToPPI: Integer): Integer;

  function SizeFromDefaultToDesignTime(const ASize, ADesignTimePPI: Integer): Integer;
  function SizeFromDesignTimeToDefault(const ASize, ADesignTimePPI: Integer): Integer;

  //Height --------------------------------------------------------------------

  function HeightFromScreenToDefault(const AHeight: Integer): Integer;
  function HeightFromDefaultToScreen(const AHeight: Integer): Integer;

  function HeightFromScreenToDesignTime(const AHeight, ADesignTimePPI: Integer): Integer;
  function HeightFromDesignTimeToScreen(const AHeight, ADesignTimePPI: Integer): Integer;

  //Width ---------------------------------------------------------------------

  function WidthFromScreenToDefault(const AWidth: Integer): Integer;
  function WidthFromDefaultToScreen(const AWidth: Integer): Integer;

  function WidthFromScreenToDesignTime(const AWidth, ADesignTimePPI: Integer): Integer;
  function WidthFromDesignTimeToScreen(const AWidth, ADesignTimePPI: Integer): Integer;

  //Factors -------------------------------------------------------------------

  function XFactorScreenDivDefault: Double;
  function YFactorScreenDivDefault: Double;

  function XFactorDefaultDivScreen: Double;
  function YFactorDefaultDivScreen: Double;

implementation

function ControlDesignTimePPI(const AControl: TControl): Integer;
var
  C: TControl;
begin
  C:= AControl;
  while not (C is TForm) do
    C:= C.Parent;
  Result:= (C as TForm).DesignTimePPI;
end;

function SizeFromPPIToPPI(const ASize, AFromPPI, AToPPI: Integer): Integer;
begin
  Result:= MulDiv(ASize, AToPPI, AFromPPI);
end;

function SizeFromDefaultToDesignTime(const ASize, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(ASize, DEFAULT_PPI, ADesignTimePPI);
end;

function SizeFromDesignTimeToDefault(const ASize, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(ASize, ADesignTimePPI, DEFAULT_PPI);
end;

//Height -----------------------------------------------------------------------

function HeightFromScreenToDefault(const AHeight: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, ScreenInfo.PixelsPerInchY, DEFAULT_PPI);
end;

function HeightFromDefaultToScreen(const AHeight: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, DEFAULT_PPI, ScreenInfo.PixelsPerInchY);
end;

function HeightFromScreenToDesignTime(const AHeight, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, ScreenInfo.PixelsPerInchY, ADesignTimePPI);
end;

function HeightFromDesignTimeToScreen(const AHeight, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, ADesignTimePPI, ScreenInfo.PixelsPerInchY);
end;

//Width ------------------------------------------------------------------------

function WidthFromScreenToDefault(const AWidth: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AWidth, ScreenInfo.PixelsPerInchX, DEFAULT_PPI);
end;

function WidthFromDefaultToScreen(const AWidth: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AWidth, DEFAULT_PPI, ScreenInfo.PixelsPerInchX);
end;

function WidthFromScreenToDesignTime(const AWidth, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AWidth, ScreenInfo.PixelsPerInchX, ADesignTimePPI);
end;

function WidthFromDesignTimeToScreen(const AWidth, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AWidth, ADesignTimePPI, ScreenInfo.PixelsPerInchX);
end;

//Factors -------------------------------------------------------------------

function XFactorScreenDivDefault: Double;
begin
  Result:= ScreenInfo.PixelsPerInchX/DEFAULT_PPI;
end;

function YFactorScreenDivDefault: Double;
begin
  Result:= ScreenInfo.PixelsPerInchY/DEFAULT_PPI;
end;

function XFactorDefaultDivScreen: Double;
begin
  Result:= DEFAULT_PPI/ScreenInfo.PixelsPerInchX;
end;

function YFactorDefaultDivScreen: Double;
begin
  Result:= DEFAULT_PPI/ScreenInfo.PixelsPerInchY;
end;

end.

