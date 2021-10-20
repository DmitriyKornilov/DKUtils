unit DK_Matrix;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, DK_Const, DK_Vector;

type
  TIntMatrix   = array of TIntVector;
  TInt64Matrix = array of TInt64Vector;
  TStrMatrix   = array of TStrVector;
  TDblMatrix   = array of TDblVector;
  TDateMatrix  = type TDblMatrix;
  TBoolMatrix  = array of TBoolVector;

  {РАЗМЕРЫ}
  procedure MDim(var M: TIntMatrix;   const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
  procedure MDim(var M: TInt64Matrix; const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT64_DEFAULT_VALUE);
  procedure MDim(var M: TStrMatrix;   const Size1, Size2: Integer; const DefaultValue: String = VECTOR_STR_DEFAULT_VALUE);
  procedure MDim(var M: TDblMatrix;   const Size1, Size2: Integer; const DefaultValue: Double = VECTOR_DBL_DEFAULT_VALUE);
  procedure MDim(var M: TBoolMatrix;  const Size1, Size2: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);

  procedure MDim(var M: TIntMatrix;   const Size: Integer; const DefaultVector: TIntVector = nil);
  procedure MDim(var M: TInt64Matrix; const Size: Integer; const DefaultVector: TInt64Vector = nil);
  procedure MDim(var M: TStrMatrix;   const Size: Integer; const DefaultVector: TStrVector = nil);
  procedure MDim(var M: TDblMatrix;   const Size: Integer; const DefaultVector: TDateVector = nil);
  procedure MDim(var M: TBoolMatrix;  const Size: Integer; const DefaultVector: TBoolVector = nil);

  procedure MReDim(var M: TIntMatrix;   const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
  procedure MReDim(var M: TInt64Matrix; const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT64_DEFAULT_VALUE);
  procedure MReDim(var M: TStrMatrix;   const Size1, Size2: Integer; const DefaultValue: String = VECTOR_STR_DEFAULT_VALUE);
  procedure MReDim(var M: TDblMatrix;   const Size1, Size2: Integer; const DefaultValue: Double = VECTOR_DBL_DEFAULT_VALUE);
  procedure MReDim(var M: TBoolMatrix;  const Size1, Size2: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);

  procedure MReDim(var M: TIntMatrix;   const Size: Integer; const DefaultVector: TIntVector = nil);
  procedure MReDim(var M: TInt64Matrix; const Size: Integer; const DefaultVector: TInt64Vector = nil);
  procedure MReDim(var M: TStrMatrix;   const Size: Integer; const DefaultVector: TStrVector = nil);
  procedure MReDim(var M: TDblMatrix;   const Size: Integer; const DefaultVector: TDateVector = nil);
  procedure MReDim(var M: TBoolMatrix;  const Size: Integer; const DefaultVector: TBoolVector = nil);

  {ПЕРЕСТАНОВКА МЕСТАМИ ДВУХ ВЕКТОРОВ}
  procedure MSwap(var M: TIntMatrix;   const Index1, Index2: Integer);
  procedure MSwap(var M: TInt64Matrix; const Index1, Index2: Integer);
  procedure MSwap(var M: TStrMatrix;   const Index1, Index2: Integer);
  procedure MSwap(var M: TDblMatrix;   const Index1, Index2: Integer);
  procedure MSwap(var M: TBoolMatrix;  const Index1, Index2: Integer);

  {УДАЛЕНИЕ ВЕКТОРОВ}
  procedure MDel(var M: TIntMatrix;   const Index1: Integer; Index2: Integer = -1);
  procedure MDel(var M: TInt64Matrix; const Index1: Integer; Index2: Integer = -1);
  procedure MDel(var M: TStrMatrix;   const Index1: Integer; Index2: Integer = -1);
  procedure MDel(var M: TDblMatrix;   const Index1: Integer; Index2: Integer = -1);
  procedure MDel(var M: TBoolMatrix;  const Index1: Integer; Index2: Integer = -1);

  {СРЕЗ}
  function MCut(const M: TIntMatrix;   FromIndex: Integer=-1; ToIndex: Integer=-1): TIntMatrix;
  function MCut(const M: TInt64Matrix; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Matrix;
  function MCut(const M: TStrMatrix;   FromIndex: Integer=-1; ToIndex: Integer=-1): TStrMatrix;
  function MCut(const M: TDblMatrix;   FromIndex: Integer=-1; ToIndex: Integer=-1): TDblMatrix;
  function MCut(const M: TBoolMatrix;  FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolMatrix;

  {СЦЕПЛЕНИЕ}
  function MAdd(var M1,M2: TIntMatrix)  : TIntMatrix;
  function MAdd(var M1,M2: TInt64Matrix): TInt64Matrix;
  function MAdd(var M1,M2: TStrMatrix)  : TStrMatrix;
  function MAdd(var M1,M2: TDblMatrix)  : TDblMatrix;
  function MAdd(var M1,M2: TBoolMatrix) : TBoolMatrix;

  {ДОБАВЛЕНИЕ ВЕКТОРА}
  procedure MAppend(var M: TIntMatrix;   const V: TIntVector);
  procedure MAppend(var M: TInt64Matrix; const V: TInt64Vector);
  procedure MAppend(var M: TStrMatrix;   const V: TStrVector);
  procedure MAppend(var M: TDblMatrix;   const V: TDblVector);
  procedure MAppend(var M: TBoolMatrix;  const V: TBoolVector);

  {ПОИСК В МАТРИЦЕ}
  function MIndexOf(const M: TIntMatrix;   const FindValue: Integer; out Index1, Index2: Integer): Boolean;
  function MIndexOf(const M: TInt64Matrix; const FindValue: Int64;   out Index1, Index2: Integer): Boolean;
  function MIndexOf(const M: TStrMatrix;   const FindValue: String;  out Index1, Index2: Integer): Boolean;
  function MIndexOf(const M: TDateMatrix;  const FindValue: TDate;   out Index1, Index2: Integer): Boolean;
  function MIndexOf(const M: TBoolMatrix;  const FindValue: Boolean; out Index1, Index2: Integer): Boolean;

  {ПРЕОБРАЗОВАНИЕ МАТРИЦЫ В ВЕКТОР ПОСЛЕДОВАТЕЛЬНО ИДУЩИХ ЗНАЧЕНИЙ}
  function MToVector(const M: TIntMatrix)  : TIntVector;
  function MToVector(const M: TInt64Matrix): TInt64Vector;
  function MToVector(const M: TStrMatrix)  : TStrVector;
  function MToVector(const M: TDblMatrix)  : TDblVector;
  function MToVector(const M: TBoolMatrix) : TBoolVector;

  {ПРЕОБРАЗОВАНИЕ МАТРИЦЫ В ВЕКТОР ПОСЛЕДОВАТЕЛЬНО ИДУЩИХ ЗНАЧЕНИЙ С УСЛОВИЕМ ВХОЖДЕНИЯ ЭЛЕМЕНТОВ}
  function MToVector(const M: TIntMatrix;   const Used: TBoolMatrix): TIntVector;
  function MToVector(const M: TInt64Matrix; const Used: TBoolMatrix): TInt64Vector;
  function MToVector(const M: TStrMatrix;   const Used: TBoolMatrix): TStrVector;
  function MToVector(const M: TDblMatrix;   const Used: TBoolMatrix): TDblVector;
  function MToVector(const M: TBoolMatrix;  const Used: TBoolMatrix): TBoolVector;

  {НАИМЕНЬШЕЕ ЗНАЧЕНИЕ ЭЛЕМЕНТА}
  function MMin(const M: TIntMatrix)  : Integer;
  function MMin(const M: TInt64Matrix): Int64;
  function MMin(const M: TStrMatrix)  : String;
  function MMin(const M: TDateMatrix) : TDate;

  {НАИБОЛЬШЕЕ ЗНАЧЕНИЕ ЭЛЕМЕНТА}
  function MMax(const M: TIntMatrix)  : Integer;
  function MMax(const M: TInt64Matrix): Int64;
  function MMax(const M: TStrMatrix)  : String;
  function MMax(const M: TDateMatrix) : TDate;

  {НАЛИЧИЕ ДАННЫХ}
  function MIsNil(const M: TIntMatrix): Boolean;
  function MIsNil(const M: TInt64Matrix): Boolean;
  function MIsNil(const M: TStrMatrix): Boolean;
  function MIsNil(const M: TDblMatrix): Boolean;
  function MIsNil(const M: TBoolMatrix): Boolean;

  {НАИБОЛЬШАЯ ДЛИНА ВЕКТОРА}
  function MMaxLength(const M: TIntMatrix): Integer;
  function MMaxLength(const M: TInt64Matrix): Integer;
  function MMaxLength(const M: TStrMatrix): Integer;
  function MMaxLength(const M: TDblMatrix): Integer;
  function MMaxLength(const M: TBoolMatrix): Integer;

implementation


procedure MDim(var M: TIntMatrix; const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VDim(M[i], Size2, DefaultValue);
end;

procedure MDim(var M: TInt64Matrix; const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT64_DEFAULT_VALUE);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VDim(M[i], Size2, DefaultValue);
end;

procedure MDim(var M: TStrMatrix; const Size1, Size2: Integer; const DefaultValue: String = VECTOR_STR_DEFAULT_VALUE);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VDim(M[i], Size2, DefaultValue);
end;

procedure MDim(var M: TDblMatrix; const Size1, Size2: Integer; const DefaultValue: Double = VECTOR_DBL_DEFAULT_VALUE);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VDim(M[i], Size2, DefaultValue);
end;

procedure MDim(var M: TBoolMatrix; const Size1, Size2: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VDim(M[i], Size2, DefaultValue);
end;

procedure MDim(var M: TIntMatrix; const Size: Integer; const DefaultVector: TIntVector = nil);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size);
  for i:=0 to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MDim(var M: TInt64Matrix; const Size: Integer; const DefaultVector: TInt64Vector = nil);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size);
  for i:=0 to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MDim(var M: TStrMatrix; const Size: Integer; const DefaultVector: TStrVector = nil);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size);
  for i:=0 to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MDim(var M: TDblMatrix; const Size: Integer; const DefaultVector: TDateVector = nil);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size);
  for i:=0 to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MDim(var M: TBoolMatrix; const Size: Integer; const DefaultVector: TBoolVector = nil);
var
  i: Integer;
begin
  M:= nil;
  SetLength(M, Size);
  for i:=0 to Size-1 do
    M[i]:= VCut(DefaultVector);
end;


procedure MReDim(var M: TIntMatrix; const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
var
  i: Integer;
begin
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VReDim(M[i], Size2, DefaultValue);
end;

procedure MReDim(var M: TInt64Matrix; const Size1, Size2: Integer; const DefaultValue: Integer = VECTOR_INT64_DEFAULT_VALUE);
var
  i: Integer;
begin
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VReDim(M[i], Size2, DefaultValue);
end;

procedure MReDim(var M: TStrMatrix; const Size1, Size2: Integer; const DefaultValue: String = VECTOR_STR_DEFAULT_VALUE);
var
  i: Integer;
begin
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VReDim(M[i], Size2, DefaultValue);
end;

procedure MReDim(var M: TDblMatrix; const Size1, Size2: Integer; const DefaultValue: Double = VECTOR_DBL_DEFAULT_VALUE);
var
  i: Integer;
begin
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VReDim(M[i], Size2, DefaultValue);
end;

procedure MReDim(var M: TBoolMatrix; const Size1, Size2: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);
var
  i: Integer;
begin
  SetLength(M, Size1);
  for i:=0 to Size1-1 do
    VReDim(M[i], Size2, DefaultValue);
end;

procedure MReDim(var M: TIntMatrix; const Size: Integer; const DefaultVector: TIntVector = nil);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(M);
  SetLength(M,Size);
  for i:= OldSize to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MReDim(var M: TInt64Matrix; const Size: Integer; const DefaultVector: TInt64Vector = nil);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(M);
  SetLength(M,Size);
  for i:= OldSize to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MReDim(var M: TStrMatrix; const Size: Integer; const DefaultVector: TStrVector = nil);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(M);
  SetLength(M,Size);
  for i:= OldSize to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MReDim(var M: TDblMatrix; const Size: Integer; const DefaultVector: TDateVector = nil);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(M);
  SetLength(M,Size);
  for i:= OldSize to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

procedure MReDim(var M: TBoolMatrix; const Size: Integer; const DefaultVector: TBoolVector = nil);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(M);
  SetLength(M,Size);
  for i:= OldSize to Size-1 do
    M[i]:= VCut(DefaultVector);
end;

//Swap

procedure MSwap(var M:TIntMatrix; const Index1, Index2: Integer);
var
  TmpVector: TIntVector;
begin
  if not CheckIndexes(High(M), Index1, Index2) then Exit;
  TmpVector:= M[Index1];
  M[Index1]:= M[Index2];
  M[Index2]:= TmpVector;
end;

procedure MSwap(var M:TInt64Matrix; const Index1, Index2: Integer);
var
  TmpVector: TInt64Vector;
begin
  if not CheckIndexes(High(M), Index1, Index2) then Exit;
  TmpVector:= M[Index1];
  M[Index1]:= M[Index2];
  M[Index2]:= TmpVector;
end;

procedure MSwap(var M:TStrMatrix; const Index1, Index2: Integer);
var
  TmpVector: TStrVector;
begin
  if not CheckIndexes(High(M), Index1, Index2) then Exit;
  TmpVector:= M[Index1];
  M[Index1]:= M[Index2];
  M[Index2]:= TmpVector;
end;

procedure MSwap(var M:TDblMatrix; const Index1, Index2: Integer);
var
  TmpVector: TDateVector;
begin
  if not CheckIndexes(High(M), Index1, Index2) then Exit;
  TmpVector:= M[Index1];
  M[Index1]:= M[Index2];
  M[Index2]:= TmpVector;
end;

procedure MSwap(var M:TBoolMatrix; const Index1, Index2: Integer);
var
  TmpVector: TBoolVector;
begin
  if not CheckIndexes(High(M), Index1, Index2) then Exit;
  TmpVector:= M[Index1];
  M[Index1]:= M[Index2];
  M[Index2]:= TmpVector;
end;

//MDel

procedure MDel(var M: TIntMatrix; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  if Index2<Index1 then Index2:= Index1;
  i:= High(M);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  OldSize:= Length(M);
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    M:= nil;
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  M[i-DelLength]:= M[i];
  MReDim(M, OldSize - DelLength);
end;

procedure MDel(var M: TInt64Matrix;   const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  if Index2<Index1 then Index2:= Index1;
  i:= High(M);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  OldSize:= Length(M);
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    M:= nil;
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  M[i-DelLength]:= M[i];
  MReDim(M, OldSize - DelLength);
end;

procedure MDel(var M: TStrMatrix;   const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  if Index2<Index1 then Index2:= Index1;
  i:= High(M);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  OldSize:= Length(M);
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    M:= nil;
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  M[i-DelLength]:= M[i];
  MReDim(M, OldSize - DelLength);
end;

procedure MDel(var M: TDblMatrix; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  if Index2<Index1 then Index2:= Index1;
  i:= High(M);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  OldSize:= Length(M);
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    M:= nil;
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  M[i-DelLength]:= M[i];
  MReDim(M, OldSize - DelLength);
end;

procedure MDel(var M: TBoolMatrix; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  if Index2<Index1 then Index2:= Index1;
  i:= High(M);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  OldSize:= Length(M);
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    M:= nil;
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  M[i-DelLength]:= M[i];
  MReDim(M, OldSize - DelLength);
end;

//MCut

function MCut(const M: TIntMatrix;   FromIndex: Integer=-1; ToIndex: Integer=-1): TIntMatrix;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(M), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  MDim(Result, x+1);
  for i:= 0 to x do Result[i]:= VCut(M[FromIndex+i]);
end;

function MCut(const M: TInt64Matrix; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Matrix;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(M), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  MDim(Result, x+1);
  for i:= 0 to x do Result[i]:= VCut(M[FromIndex+i]);
end;

function MCut(const M: TStrMatrix;   FromIndex: Integer=-1; ToIndex: Integer=-1): TStrMatrix;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(M), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  MDim(Result, x+1);
  for i:= 0 to x do Result[i]:= VCut(M[FromIndex+i]);
end;

function MCut(const M: TDblMatrix;   FromIndex: Integer=-1; ToIndex: Integer=-1): TDblMatrix;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(M), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  MDim(Result, x+1);
  for i:= 0 to x do Result[i]:= VCut(M[FromIndex+i]);
end;

function MCut(const M: TBoolMatrix;  FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolMatrix;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(M), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  MDim(Result, x+1);
  for i:= 0 to x do Result[i]:= VCut(M[FromIndex+i]);
end;

//MAdd

function MAdd(var M1,M2: TIntMatrix): TIntMatrix;
var
  i: Integer;
begin
  Result:= MCut(M1);
  for i:= 0 to High(M2) do
    MAppend(Result, M2[i]);
end;

function MAdd(var M1,M2: TInt64Matrix): TInt64Matrix;
var
  i: Integer;
begin
  Result:= MCut(M1);
  for i:= 0 to High(M2) do
    MAppend(Result, M2[i]);
end;

function MAdd(var M1,M2: TStrMatrix): TStrMatrix;
var
  i: Integer;
begin
  Result:= MCut(M1);
  for i:= 0 to High(M2) do
    MAppend(Result, M2[i]);
end;

function MAdd(var M1,M2: TDblMatrix): TDblMatrix;
var
  i: Integer;
begin
  Result:= MCut(M1);
  for i:= 0 to High(M2) do
    MAppend(Result, M2[i]);
end;

function MAdd(var M1,M2: TBoolMatrix): TBoolMatrix;
var
  i: Integer;
begin
  Result:= MCut(M1);
  for i:= 0 to High(M2) do
    MAppend(Result, M2[i]);
end;

//MAppend

procedure MAppend(var M: TIntMatrix; const V: TIntVector);
begin
  MReDim(M, Length(M)+1, V);
end;

procedure MAppend(var M: TInt64Matrix; const V: TInt64Vector);
begin
  MReDim(M, Length(M)+1, V);
end;

procedure MAppend(var M: TStrMatrix; const V: TStrVector);
begin
  MReDim(M, Length(M)+1, V);
end;

procedure MAppend(var M: TDblMatrix; const V: TDblVector);
begin
  MReDim(M, Length(M)+1, V);
end;

procedure MAppend(var M: TBoolMatrix; const V: TBoolVector);
begin
  MReDim(M, Length(M)+1, V);
end;

//MIndexOf
function MIndexOf(const M: TIntMatrix; const FindValue: Integer; out Index1, Index2: Integer): Boolean;
var
  i,j: Integer;
begin
  Index1:= -1;
  Index2:= -1;
  Result:= False;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if M[i,j]=FindValue then
  begin
    Index1:= i;
    Index2:= j;
    Result:= True;
    Exit;
  end;
end;

function MIndexOf(const M: TInt64Matrix; const FindValue: Int64; out Index1, Index2: Integer): Boolean;
var
  i,j: Integer;
begin
  Index1:= -1;
  Index2:= -1;
  Result:= False;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if M[i,j]=FindValue then
  begin
    Index1:= i;
    Index2:= j;
    Result:= True;
    Exit;
  end;
end;

function MIndexOf(const M: TStrMatrix; const FindValue: String; out Index1, Index2: Integer): Boolean;
var
  i,j: Integer;
begin
  Index1:= -1;
  Index2:= -1;
  Result:= False;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if M[i,j]=FindValue then
  begin
    Index1:= i;
    Index2:= j;
    Result:= True;
    Exit;
  end;
end;

function MIndexOf(const M: TDateMatrix; const FindValue: TDate;  out Index1, Index2: Integer): Boolean;
var
  i,j: Integer;
begin
  Index1:= -1;
  Index2:= -1;
  Result:= False;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if Trunc(M[i,j]) = Trunc(FindValue) then
  begin
    Index1:= i;
    Index2:= j;
    Result:= True;
    Exit;
  end;
end;

function MIndexOf(const M: TBoolMatrix;  const FindValue: Boolean; out Index1, Index2: Integer): Boolean;
var
  i,j: Integer;
begin
  Index1:= -1;
  Index2:= -1;
  Result:= False;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
       if M[i,j]=FindValue then
  begin
    Index1:= i;
    Index2:= j;
    Result:= True;
    Exit;
  end;
end;

//MToVector
function MToVector(const M: TIntMatrix): TIntVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      VAppend(Result, M[i,j]);
end;

function MToVector(const M: TInt64Matrix): TInt64Vector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      VAppend(Result, M[i,j]);
end;

function MToVector(const M: TStrMatrix): TStrVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      VAppend(Result, M[i,j]);
end;

function MToVector(const M: TDblMatrix): TDblVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      VAppend(Result, M[i,j]);
end;

function MToVector(const M: TBoolMatrix): TBoolVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      VAppend(Result, M[i,j]);
end;

function MToVector(const M: TIntMatrix; const Used: TBoolMatrix): TIntVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if Used[i,j] then
        VAppend(Result, M[i,j]);
end;

function MToVector(const M: TInt64Matrix; const Used: TBoolMatrix): TInt64Vector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if Used[i,j] then
        VAppend(Result, M[i,j]);
end;

function MToVector(const M: TStrMatrix; const Used: TBoolMatrix): TStrVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if Used[i,j] then
        VAppend(Result, M[i,j]);
end;

function MToVector(const M: TDblMatrix; const Used: TBoolMatrix): TDblVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if Used[i,j] then
        VAppend(Result, M[i,j]);
end;

function MToVector(const M: TBoolMatrix; const Used: TBoolMatrix): TBoolVector;
var
  i,j: Integer;
begin
  Result:= nil;
  for i:= 0 to High(M) do
    for j:= 0 to High(M[i]) do
      if Used[i,j] then
        VAppend(Result, M[i,j]);
end;

//MMax
function MMax(const M: TIntMatrix): Integer;
var
  i,X: Integer;
begin
  Result:= 0;
  if MIsNil(M) then Exit;
  Result:= VMax(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMax(M[i]);
    if X>Result then Result:= X;
  end;
end;

function MMax(const M: TInt64Matrix): Int64;
var
  i: Integer;
  X: Int64;
begin
  Result:= 0;
  if MIsNil(M) then Exit;
  Result:= VMax(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMax(M[i]);
    if X>Result then Result:= X;
  end;
end;

function MMax(const M: TStrMatrix): String;
var
  i: Integer;
  X: String;
begin
  Result:= EmptyStr;
  if MIsNil(M) then Exit;
  Result:= VMax(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMax(M[i]);
    if X>Result then Result:= X;
  end;
end;

function MMax(const M: TDateMatrix): TDate;
var
  i: Integer;
  X: TDate;
begin
  Result:= 0;
  if MIsNil(M) then Exit;
  Result:= VMax(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMax(M[i]);
    if CompareDate(X,Result)>0 then Result:= X;
  end;
end;

function MMin(const M: TIntMatrix): Integer;
var
  i,X: Integer;
begin
  Result:= 0;
  if MIsNil(M) then Exit;
  Result:= VMin(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMin(M[i]);
    if X<Result then Result:= X;
  end;
end;

function MMin(const M: TInt64Matrix): Int64;
var
  i: Integer;
  X: Int64;
begin
  Result:= 0;
  if MIsNil(M) then Exit;
  Result:= VMin(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMin(M[i]);
    if X<Result then Result:= X;
  end;
end;

function MMin(const M: TStrMatrix): String;
var
  i: Integer;
  X: String;
begin
  Result:= EmptyStr;
  if MIsNil(M) then Exit;
  Result:= VMin(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMin(M[i]);
    if X<Result then Result:= X;
  end;
end;

function MMin(const M: TDateMatrix): TDate;
var
  i: Integer;
  X: TDate;
begin
  Result:= 0;
  if MIsNil(M) then Exit;
  Result:= VMin(M[0]);
  for i:=1 to High(M) do
  begin
    X:= VMin(M[i]);
    if CompareDate(X,Result)<0 then Result:= X;
  end;
end;

function MIsNil(const M: TIntMatrix): Boolean;
begin
  Result:= Length(M)=0;
end;

function MIsNil(const M: TInt64Matrix): Boolean;
begin
  Result:= Length(M)=0;
end;

function MIsNil(const M: TStrMatrix): Boolean;
begin
  Result:= Length(M)=0;
end;

function MIsNil(const M: TDblMatrix): Boolean;
begin
  Result:= Length(M)=0;
end;

function MIsNil(const M: TBoolMatrix): Boolean;
begin
  Result:= Length(M)=0;
end;

function MMaxLength(const M: TIntMatrix): Integer;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to High(M) do
    if Length(M[i])>Result then
      Result:= Length(M[i]);
end;

function MMaxLength(const M: TInt64Matrix): Integer;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to High(M) do
    if Length(M[i])>Result then
      Result:= Length(M[i]);
end;

function MMaxLength(const M: TStrMatrix): Integer;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to High(M) do
    if Length(M[i])>Result then
      Result:= Length(M[i]);
end;

function MMaxLength(const M: TDblMatrix): Integer;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to High(M) do
    if Length(M[i])>Result then
      Result:= Length(M[i]);
end;

function MMaxLength(const M: TBoolMatrix): Integer;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to High(M) do
    if Length(M[i])>Result then
      Result:= Length(M[i]);
end;

end.

