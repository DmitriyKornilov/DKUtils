unit DK_Color;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, GraphUtil;

const
  COLOR_AQUA       = $00E3E2A8;
  COLOR_PURPLE     = $00E6D5E6;
  COLOR_BEIGE      = $00C0EDED;
  COLOR_RED        = $00CECEFF;
  COLOR_GRAY       = $00E0E0E0;
  COLOR_BLACK      = $00000000;
  COLOR_WHITE      = $00FFFFFF;
  COLOR_ORANGE     = $0097CBFF;
  COLOR_GREEN      = $00CCE3CC;
  COLOR_YELLOW     = $00B3FFFF;
  COLOR_BLUE       = $00FBD69B;
  COLOR_BROWN      = $00B4B4D9;

var
  DefaultSelectionBGColor: TColor;
  DefaultSelectionBGExtraColor: TColor;

  function ColorIncLightness(const AColor: TColor; const ALightnessIncrement: Integer): TColor;
  function ColorSetLightness(const AColor: TColor; const ALightnessValue: Integer): TColor;

implementation

function ColorIncLightness(const AColor: TColor; const ALightnessIncrement: Integer): TColor;
var
  H, L, S: Byte;
  Lightness: Integer;
begin
  ColorToHLS(AColor, H, L, S);
  Lightness:= L + ALightnessIncrement;
  if Lightness<0 then
    L:= 0
  else if Lightness>255 then
    L:= 255
  else
    L:= Lightness;
  Result:= HLSToColor(H, L, S);
end;

function ColorSetLightness(const AColor: TColor; const ALightnessValue: Integer): TColor;
var
  H, L, S: Byte;
begin
  ColorToHLS(AColor, H, L, S);
  if ALightnessValue<0 then
    L:= 0
  else if ALightnessValue>255 then
    L:= 255
  else
    L:= ALightnessValue;
  Result:= HLSToColor(H, L, S);
end;

initialization

DefaultSelectionBGColor:= ColorSetLightness(clHighlight, 220);
DefaultSelectionBGExtraColor:= ColorSetLightness(clHighlight, 180);

end.

