unit DK_PPI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, LCLType;

const
  DEFAULT_PPI = 96;

  function HeightFromScreenToDefault(const AHeight: Integer): Integer;
  function HeightFromDefaultToScreen(const AHeight: Integer): Integer;

  function WidthFromScreenToDefault(const AWidth: Integer): Integer;
  function WidthFromDefaultToScreen(const AWidth: Integer): Integer;

implementation

function SizeFromPPIToPPI(const ASize, AFromPPI, AToPPI: Integer): Integer;
begin
  Result:= MulDiv(ASize, AToPPI, AFromPPI);
end;

function HeightFromScreenToDefault(const AHeight: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, ScreenInfo.PixelsPerInchY, DEFAULT_PPI);
end;

function HeightFromDefaultToScreen(const AHeight: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AHeight, DEFAULT_PPI, ScreenInfo.PixelsPerInchY);
end;

function WidthFromScreenToDefault(const AWidth: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AWidth, ScreenInfo.PixelsPerInchX, DEFAULT_PPI);
end;

function WidthFromDefaultToScreen(const AWidth: Integer): Integer;
begin
  Result:= SizeFromPPIToPPI(AWidth, DEFAULT_PPI, ScreenInfo.PixelsPerInchX);
end;

end.

