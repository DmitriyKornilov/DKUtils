unit DK_Math;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;



  function Min(const AValue1, AValue2: Double): Double;
  function Min(const AValue1, AValue2: Integer): Integer;

  function Max(const AValue1, AValue2: Double): Double;
  function Max(const AValue1, AValue2: Integer): Integer;

  function IsInRange(const AValue, AMinValue, AMaxValue: Double): Boolean;
  function IsValidPercent(const APercent: Double): Boolean;

  function Percent(const AValue, APercent: Double): Double;


  function RandomInRange(const AMinValue, AMaxValue: Integer): Integer;
  function RandomInRange(const AValue: Integer;
                         const AMinPercent, AMaxPercent: Double): Integer;

implementation

function Min(const AValue1, AValue2: Double): Double;
begin
  Result:= AValue1;
  if AValue2<AValue1 then
    Result:= AValue2;
end;

function Min(const AValue1, AValue2: Integer): Integer;
begin
  Result:= AValue1;
  if AValue2<AValue1 then
    Result:= AValue2;
end;

function Max(const AValue1, AValue2: Double): Double;
begin
  Result:= AValue1;
  if AValue2>AValue1 then
    Result:= AValue2;
end;

function Max(const AValue1, AValue2: Integer): Integer;
begin
  Result:= AValue1;
  if AValue2>AValue1 then
    Result:= AValue2;
end;

function IsInRange(const AValue, AMinValue, AMaxValue: Double): Boolean;
begin
  Result:= (AValue>=AMinValue) and (AValue<=AMaxValue);
end;

function IsValidPercent(const APercent: Double): Boolean;
begin
  Result:= IsInRange(APercent, 0, 100);
end;

function Percent(const AValue, APercent: Double): Double;
begin
  Result:= AValue*APercent/100;
end;

function RandomInRange(const AMinValue, AMaxValue: Integer): Integer;
begin
  Result:= AMinValue + Random(AMaxValue-AMinValue);
end;

function RandomInRange(const AValue: Integer;
                       const AMinPercent, AMaxPercent: Double): Integer;
var
  MinValue, MaxValue: Integer;
begin
  Result:= 0;
  if (AValue=0) or
     (not IsValidPercent(AMinPercent)) or
     (not IsValidPercent(AMaxPercent)) then Exit;
  MinValue:= Round(Percent(AValue, AMinPercent));
  MaxValue:= Round(Percent(AValue, AMaxPercent));
  Result:= RandomInRange(MinValue, MaxValue);
end;

initialization
  Randomize;

end.

