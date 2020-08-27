unit DK_Math;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  function Max(const X1, X2: Integer): Integer;
  function Min(const X1, X2: Integer): Integer;

implementation

function Max(const X1, X2: Integer): Integer;
begin
  Result:= X1;
  if X2>X1 then
    Result:= X2;
end;

function Min(const X1, X2: Integer): Integer;
begin
  Result:= X1;
  if X2<X1 then
    Result:= X2;
end;

end.

