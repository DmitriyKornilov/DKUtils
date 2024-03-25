unit DK_Color;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, GraphUtil;

var
  DefaultSelectionBGColor: TColor;

  function ColorIncLightness(const AColor: TColor; const LightnessIncrement: Integer): TColor;

implementation

function ColorIncLightness(const AColor: TColor; const LightnessIncrement: Integer): TColor;
var
  H, L, S: Byte;
  Lightness: Integer;
begin
  ColorToHLS(AColor, H, L, S);
  Lightness:= L + LightnessIncrement;
  if Lightness<0 then
    L:= 0
  else if Lightness>255 then
    L:= 255
  else
    L:= Lightness;
  Result:= HLSToColor(H, L, S);
end;

initialization

DefaultSelectionBGColor:= ColorIncLightness(clHighlight, 110);

end.

