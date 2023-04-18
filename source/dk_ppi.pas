unit DK_PPI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Math;

const
  DEFAULT_PPI = 96;

  function SizeFromPPIToPPI(const ASize, AFromPPI, AToPPI: Integer): Integer;

  function SizeFromDefaultToDesignTime(const AHeight, ADesignTimePPI: Integer): Integer;
  function SizeFromDesignTimeToDefault(const AHeight, ADesignTimePPI: Integer): Integer;

  //Height -----------------------------------------------------------------------

  function HeightFromScreenToDefault(const AHeight: Integer): Integer;
  function HeightFromDefaultToScreen(const AHeight: Integer): Integer;

  function HeightFromScreenToDesignTime(const AHeight, ADesignTimePPI: Integer): Integer;
  function HeightFromDesignTimeToScreen(const AHeight, ADesignTimePPI: Integer): Integer;

  //Width ------------------------------------------------------------------------

  function WidthFromScreenToDefault(const AWidth: Integer): Integer;
  function WidthFromDefaultToScreen(const AWidth: Integer): Integer;

  function WidthFromScreenToDesignTime(const AWidth, ADesignTimePPI: Integer): Integer;
  function WidthFromDesignTimeToScreen(const AWidth, ADesignTimePPI: Integer): Integer;


implementation

function SizeFromPPIToPPI(const ASize, AFromPPI, AToPPI: Integer): Integer;
begin
  Result:= Ceil(ASize*AToPPI/AFromPPI);
end;

function SizeFromDefaultToDesignTime(const AHeight, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, DEFAULT_PPI, ADesignTimePPI);
end;

function SizeFromDesignTimeToDefault(const AHeight, ADesignTimePPI: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, ADesignTimePPI, DEFAULT_PPI);
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

end.

