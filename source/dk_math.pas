unit DK_Math;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  //Min - меньшее из двух значений}
  function Min(const AValue1, AValue2: Double): Double;
  function Min(const AValue1, AValue2: Integer): Integer;
  function Min(const AValue1, AValue2: Int64): Int64;

  //Max - большее из двух значений
  function Max(const AValue1, AValue2: Double): Double;
  function Max(const AValue1, AValue2: Integer): Integer;
  function Max(const AValue1, AValue2: Int64): Int64;

  //IsInRange - проверка вхождения значения в диапазон (включая значения границ)
  function IsInRange(const AValue, AMinValue, AMaxValue: Double): Boolean;
  function IsInRange(const AValue, AMinValue, AMaxValue: Integer): Boolean;
  function IsInRange(const AValue, AMinValue, AMaxValue: Int64): Boolean;

  //CastInRange - приведение значения к диапазону
  //если AValue выходит за диапазон, то Result присваивается значение ближайшей границы
  //иначе AValue
  function CastInRange(const AValue, AMinValue, AMaxValue: Double): Double;
  function CastInRange(const AValue, AMinValue, AMaxValue: Integer): Integer;
  function CastInRange(const AValue, AMinValue, AMaxValue: Int64): Int64;

  function IsValidPercent(const APercent: Double): Boolean;
  function Percent(const AValue, APercent: Double): Double;

  function Part(const AValue, ATotal: Double): Double;
  function PartRound(const AValue, ATotal: Double): Integer;

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

function Min(const AValue1, AValue2: Int64): Int64;
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

function Max(const AValue1, AValue2: Int64): Int64;
begin
  Result:= AValue1;
  if AValue2>AValue1 then
    Result:= AValue2;
end;

function IsInRange(const AValue, AMinValue, AMaxValue: Double): Boolean;
begin
  Result:= (AValue>=AMinValue) and (AValue<=AMaxValue);
end;

function IsInRange(const AValue, AMinValue, AMaxValue: Integer): Boolean;
begin
  Result:= (AValue>=AMinValue) and (AValue<=AMaxValue);
end;

function IsInRange(const AValue, AMinValue, AMaxValue: Int64): Boolean;
begin
  Result:= (AValue>=AMinValue) and (AValue<=AMaxValue);
end;

function CastInRange(const AValue, AMinValue, AMaxValue: Double): Double;
begin
  if AValue<AMinValue then
    Result:= AMinValue
  else if AValue>AMaxValue then
    Result:= AMaxValue
  else
    Result:= AValue;
end;

function CastInRange(const AValue, AMinValue, AMaxValue: Integer): Integer;
begin
  if AValue<AMinValue then
    Result:= AMinValue
  else if AValue>AMaxValue then
    Result:= AMaxValue
  else
    Result:= AValue;
end;

function CastInRange(const AValue, AMinValue, AMaxValue: Int64): Int64;
begin
  if AValue<AMinValue then
    Result:= AMinValue
  else if AValue>AMaxValue then
    Result:= AMaxValue
  else
    Result:= AValue;
end;

function IsValidPercent(const APercent: Double): Boolean;
begin
  Result:= IsInRange(APercent, 0, 100);
end;

function Percent(const AValue, APercent: Double): Double;
begin
  Result:= AValue*APercent/100;
end;

function Part(const AValue, ATotal: Double): Double;
begin
  Result:= 0;
  if ATotal=0 then Exit;
  Result:= AValue/ATotal;
end;

function PartRound(const AValue, ATotal: Double): Integer;
begin
  Result:= Round(Part(AValue, ATotal));
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

