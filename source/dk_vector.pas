unit DK_Vector;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Graphics, DK_Const, DK_DateUtils, DK_StrUtils;

type
  TIntVector   = array of Integer;
  TInt64Vector = array of Int64;
  TStrVector   = array of String;
  TDblVector   = array of Double;
  TDateVector  = type TDblVector;
  TBoolVector  = array of Boolean;
  TColorVector = array of TColor;

  {РАЗМЕРЫ ВЕКТОРОВ}
  procedure VDim(var V: TIntVector;   const Size: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
  procedure VDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64   = VECTOR_INT64_DEFAULT_VALUE);
  procedure VDim(var V: TStrVector;   const Size: Integer; const DefaultValue: String  = VECTOR_STR_DEFAULT_VALUE);
  procedure VDim(var V: TDblVector;   const Size: Integer; const DefaultValue: Double  = VECTOR_DBL_DEFAULT_VALUE);
  procedure VDim(var V: TBoolVector;  const Size: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);
  procedure VDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = VECTOR_COLOR_DEFAULT_VALUE);

  procedure VReDim(var V: TIntVector;   const Size: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
  procedure VReDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64 = VECTOR_INT64_DEFAULT_VALUE);
  procedure VReDim(var V: TStrVector;   const Size: Integer; const DefaultValue: String = VECTOR_STR_DEFAULT_VALUE);
  procedure VReDim(var V: TDblVector;   const Size: Integer; const DefaultValue: Double = VECTOR_DBL_DEFAULT_VALUE);
  procedure VReDim(var V: TBoolVector;  const Size: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);
  procedure VReDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = VECTOR_COLOR_DEFAULT_VALUE);

  function VIsNil(const V: TIntVector): Boolean;
  function VIsNil(const V: TInt64Vector): Boolean;
  function VIsNil(const V: TStrVector): Boolean;
  function VIsNil(const V: TDblVector): Boolean;
  function VIsNil(const V: TBoolVector): Boolean;
  function VIsNil(const V: TColorVector): Boolean;

  {СОЗДАНИЕ ВЕКТОРА}
  function VCreateInt(const V: array of Integer): TIntVector;
  function VCreateInt64(const V: array of Int64): TInt64Vector;
  function VCreateStr(const V: array of String): TStrVector;
  function VCreateDbl(const V: array of Double): TDblVector;
  function VCreateDate(const V: array of TDate): TDateVector;
  function VCreateBool(const V: array of Boolean): TBoolVector;
  function VCreateColor(const V: array of TColor): TColorVector;

  {ЗАМЕНА НА НОВОЕ ЗНАЧЕНИЕ}
  procedure VChangeIn(var V: TIntVector;   const NewValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TInt64Vector; const NewValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TStrVector;   const NewValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TDblVector;   const NewValue: Double;  FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TBoolVector;  const NewValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TColorVector; const NewValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1);

  procedure VChangeNotIn(var V: TIntVector;   const NewValue: Integer; FromIndex, ToIndex: Integer);
  procedure VChangeNotIn(var V: TInt64Vector; const NewValue: Int64;   FromIndex, ToIndex: Integer);
  procedure VChangeNotIn(var V: TStrVector;   const NewValue: String;  FromIndex, ToIndex: Integer);
  procedure VChangeNotIn(var V: TDblVector;   const NewValue: Double;  FromIndex, ToIndex: Integer);
  procedure VChangeNotIn(var V: TBoolVector;  const NewValue: Boolean; FromIndex, ToIndex: Integer);
  procedure VChangeNotIn(var V: TColorVector; const NewValue: TColor;  FromIndex, ToIndex: Integer);

  procedure VChangeIf(var V: TIntVector;   const IfValue, NewValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TInt64Vector; const IfValue, NewValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TStrVector;   const IfValue, NewValue: String; FromIndex: Integer=-1; ToIndex: Integer=-1;
                      const ACaseSensitivity: Boolean = True);
  procedure VChangeIf(var V: TDateVector;  const IfValue, NewValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TBoolVector;  const IfValue, NewValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TColorVector; const IfValue, NewValue: TColor; FromIndex: Integer=-1; ToIndex: Integer=-1);

  {ПЕРВЫЙ И ПОСЛЕДНИЙ ЭЛЕМЕНТЫ ВЕКТОРА}
  function VFirst(const V: TIntVector): Integer;
  function VFirst(const V: TInt64Vector): Int64;
  function VFirst(const V: TStrVector): String;
  function VFirst(const V: TDblVector): Double;
  function VFirst(const V: TBoolVector): Boolean;
  function VFirst(const V: TColorVector): TColor;

  function VLast(const V: TIntVector): Integer;
  function VLast(const V: TInt64Vector): Int64;
  function VLast(const V: TStrVector): String;
  function VLast(const V: TDblVector): Double;
  function VLast(const V: TBoolVector): Boolean;
  function VLast(const V: TColorVector): TColor;

  {ПЕРЕСТАНОВКА МЕСТАМИ ДВУХ ЭЛЕМЕНТОВ}
  procedure VSwap(var V: TIntVector;   const Index1, Index2: Integer);
  procedure VSwap(var V: TInt64Vector; const Index1, Index2: Integer);
  procedure VSwap(var V: TStrVector;   const Index1, Index2: Integer);
  procedure VSwap(var V: TDblVector;   const Index1, Index2: Integer);
  procedure VSwap(var V: TBoolVector;  const Index1, Index2: Integer);
  procedure VSwap(var V: TColorVector; const Index1, Index2: Integer);

  {УДАЛЕНИЕ ЭЛЕМЕНТОВ}
  procedure VDel(var V: TIntVector;   const Index1: Integer; Index2: Integer = -1);
  procedure VDel(var V: TInt64Vector; const Index1: Integer; Index2: Integer = -1);
  procedure VDel(var V: TStrVector;   const Index1: Integer; Index2: Integer = -1);
  procedure VDel(var V: TDblVector;   const Index1: Integer; Index2: Integer = -1);
  procedure VDel(var V: TBoolVector;  const Index1: Integer; Index2: Integer = -1);
  procedure VDel(var V: TColorVector; const Index1: Integer; Index2: Integer = -1);

  {КОПИРОВАНИЕ}
  procedure VCopy(const Source: TIntVector;   var Dest: TIntVector;   const FromIndex: Integer = 0);
  procedure VCopy(const Source: TInt64Vector; var Dest: TInt64Vector; const FromIndex: Integer = 0);
  procedure VCopy(const Source: TStrVector;   var Dest: TStrVector;   const FromIndex: Integer = 0);
  procedure VCopy(const Source: TDblVector;   var Dest: TDblVector;   const FromIndex: Integer = 0);
  procedure VCopy(const Source: TBoolVector;  var Dest: TBoolVector;  const FromIndex: Integer = 0);
  procedure VCopy(const Source: TColorVector; var Dest: TColorVector; const FromIndex: Integer = 0);

  {СРЕЗ}
  function VCut(const V: TIntVector;   FromIndex: Integer=-1; ToIndex: Integer=-1): TIntVector;
  function VCut(const V: TInt64Vector; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Vector;
  function VCut(const V: TStrVector;   FromIndex: Integer=-1; ToIndex: Integer=-1): TStrVector;
  function VCut(const V: TDblVector;   FromIndex: Integer=-1; ToIndex: Integer=-1): TDblVector;
  function VCut(const V: TBoolVector;  FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolVector;
  function VCut(const V: TColorVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TColorVector;

  {СРЕЗ С УСЛОВИЕМ ВХОЖДЕНИЯ ЭЛЕМЕНТОВ ВЕКТОРА}
  function VCut(const V: TIntVector;   const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TIntVector;
  function VCut(const V: TInt64Vector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Vector;
  function VCut(const V: TStrVector;   const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TStrVector;
  function VCut(const V: TDblVector;   const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TDblVector;
  function VCut(const V: TBoolVector;  const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolVector;
  function VCut(const V: TColorVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TColorVector;

  {СЦЕПЛЕНИЕ}
  function VAdd(const V1,V2: TIntVector):   TIntVector;
  function VAdd(const V1,V2: TInt64Vector): TInt64Vector;
  function VAdd(const V1,V2: TStrVector):   TStrVector;
  function VAdd(const V1,V2: TDblVector):   TDblVector;
  function VAdd(const V1,V2: TBoolVector):  TBoolVector;
  function VAdd(const V1,V2: TColorVector): TColorVector;

  {ДОБАВЛЕНИЕ ЭЛЕМЕНТА В КОНЕЦ ВЕКТОРА}
  procedure VAppend(var V: TIntVector;   const Value: Integer);
  procedure VAppend(var V: TInt64Vector; const Value: Int64);
  procedure VAppend(var V: TStrVector;   const Value: String);
  procedure VAppend(var V: TDblVector;   const Value: Double);
  procedure VAppend(var V: TBoolVector;  const Value: Boolean);
  procedure VAppend(var V: TColorVector; const Value: TColor);

  {ВСТАВКА}
  procedure VIns(var V: TIntVector;   const Ind: Integer; const Value: Integer);
  procedure VIns(var V: TInt64Vector; const Ind: Integer; const Value: Int64);
  procedure VIns(var V: TStrVector;   const Ind: Integer; const Value: String);
  procedure VIns(var V: TDblVector;   const Ind: Integer; const Value: Double);
  procedure VIns(var V: TBoolVector;  const Ind: Integer; const Value: Boolean);
  procedure VIns(var V: TColorVector; const Ind: Integer; const Value: TColor);

  procedure VIns(var V: TIntVector;   const Ind: Integer; const Source: TIntVector);
  procedure VIns(var V: TInt64Vector; const Ind: Integer; const Source: TInt64Vector);
  procedure VIns(var V: TStrVector;   const Ind: Integer; const Source: TStrVector);
  procedure VIns(var V: TDblVector;   const Ind: Integer; const Source: TDblVector);
  procedure VIns(var V: TBoolVector;  const Ind: Integer; const Source: TBoolVector);
  procedure VIns(var V: TColorVector; const Ind: Integer; const Source: TColorVector);

  {ПОИСК В ВЕКТОРЕ}
  function VIndexOf(const V: TIntVector;   const FindValue: Integer): Integer;
  function VIndexOf(const V: TInt64Vector; const FindValue: Int64):   Integer;
  function VIndexOf(const V: TStrVector;   const FindValue: String;
                    const ACaseSensitivity: Boolean = True):  Integer;
  function VIndexOf(const V: TDateVector;  const FindValue: TDate):   Integer;
  function VIndexOf(const V: TBoolVector;  const FindValue: Boolean): Integer;
  function VIndexOf(const V: TColorVector; const FindValue: TColor):  Integer;

  {УНИКАЛЬНЫЕ ЗНАЧЕНИЯ}
  function VUnique(const V: TIntVector): TIntVector;
  function VUnique(const V: TInt64Vector): TInt64Vector;
  function VUnique(const V: TStrVector;
                   const ACaseSensitivity: Boolean = True): TStrVector;
  function VUnique(const V: TDateVector): TDateVector;
  function VUnique(const V: TColorVector): TColorVector;

  {ОБЪЕДИНЕНИЕ}
  function VUnion(const V1,V2: TIntVector): TIntVector;
  function VUnion(const V1,V2: TInt64Vector): TInt64Vector;
  function VUnion(const V1,V2: TStrVector): TStrVector;
  function VUnion(const V1,V2: TDateVector): TDateVector;
  function VUnion(const V1,V2: TColorVector): TColorVector;

  {НАИМЕНЬШЕЕ ЗНАЧЕНИЕ}
  function VMin(const V: TIntVector):   Integer;
  function VMin(const V: TInt64Vector): Int64;
  function VMin(const V: TStrVector;
                const ACaseSensitivity: Boolean = True):   String;
  function VMin(const V: TDateVector):  TDate;

  {НАИБОЛЬШЕЕ ЗНАЧЕНИЕ}
  function VMax(const V: TIntVector):   Integer;
  function VMax(const V: TInt64Vector): Int64;
  function VMax(const V: TStrVector;
                const ACaseSensitivity: Boolean = True):   String;
  function VMax(const V: TDateVector):  TDate;

  {КОЛ-ВО ЗНАЧЕНИЙ, РАВНЫХ ЗАДАННОМУ}
  function VCountIf(const V: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                    const ACaseSensitivity: Boolean = True): Integer;
  function VCountIf(const V: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;

  {КОЛ-ВО ЗНАЧЕНИЙ, НЕ РАВНЫХ ЗАДАННОМУ}
  function VCountIfNot(const V: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                       const ACaseSensitivity: Boolean = True): Integer;
  function VCountIfNot(const V: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;

  {ПРЕОБРАЗОВНИЕ К СТРОКОВОМУ ВЕКТОРУ}
  function VIntToStr(const V: TIntVector): TStrVector;
  function VIntToStr(const V: TInt64Vector): TStrVector;
  function VBoolToStr(const V: TBoolVector): TStrVector;
  function VFloatToStr(const V: TDblVector): TStrVector;
  function VDateToStr(const V: TDateVector): TStrVector;
  function VFormatDateTime(const FormatStr: String; const V: TDateVector; Options: TFormatDateTimeOptions = []): TStrVector;
  function VTrim(const V: TStrVector): TStrVector;

  {СТРОКОВЫЙ ВЕКТОР И СПИСОК}
  function VFromStrings(const S: TStrings): TStrVector;
  procedure VToStrings(const V: TStrVector; const S: TStrings);

  {СТРОКОВЫЙ ВЕКТОР И СТРОКА}
  function VStrToVector(const Str, Delimiter: String): TStrVector;
  function VVectorToStr(const V: TStrVector; const Delimiter: String): String;

  {СУММА/КОНКАТЕНАЦИЯ}
  function VSum(const V1,V2: TIntVector)  : TIntVector;
  function VSum(const V1,V2: TInt64Vector): TInt64Vector;
  function VSum(const V1,V2: TStrVector): TStrVector;
  function VSum(const V1,V2: TDblVector): TDblVector;

  function VSum(const V: TIntVector;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSum(const V: TInt64Vector; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSum(const V: TStrVector; FromIndex: Integer=-1; ToIndex: Integer=-1): String;
  function VSum(const V: TDblVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Double;

  function VSumIf(const V: TIntVector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                  const ACaseSensitivity: Boolean = True): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                  const ACaseSensitivity: Boolean = True): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;

  function VSumIfNot(const V: TIntVector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                     const ACaseSensitivity: Boolean = True): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                     const ACaseSensitivity: Boolean = True): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;

  function VMult(const V1,V2: TIntVector): TIntVector;
  function VMult(const V1,V2: TInt64Vector): TInt64Vector;
  function VMult(const V1: TStrVector; const V2: TIntVector): TStrVector;

  {ДЛЯ ЦЕЛОЧИСЛЕННОГО ВЕКТОРА}
  function VOrder(const MaxValue: Integer): TIntVector; //{1,2,3,...,MaxValue}

  {ДЛЯ УПОРЯДОЧЕННОГО ВЕКТОРА ДАТ}
  function VCrossInd(const V: TDateVector; const ABeginDate, AEndDate: TDate; out I1,I2: Integer): Boolean;
  function VCut(const V: TDateVector; const ABeginDate, AEndDate: TDate): TDateVector;
  function VCountIn(const V: TDateVector; const ABeginDate, AEndDate: TDate): Integer;
  function VCountBefore(const V: TDateVector; const ADate: TDate): Integer;
  function VCountAfter(const V: TDateVector; const ADate: TDate): Integer;

  {СОРТИРОВКА}
  procedure VSort(const V: TStrVector; out Indexes: TIntVector;
                  const Desc: Boolean = False);
  procedure VSort(const V: TIntVector; out Indexes: TIntVector;
                  const Desc: Boolean = False);
  procedure VSort(const V: TInt64Vector; out Indexes: TIntVector;
                  const Desc: Boolean = False);
  procedure VSort(const V: TDateVector; out Indexes: TIntVector;
                  const Desc: Boolean = False);
  procedure VSort(var V: TStrVector; const Desc: Boolean = False);
  procedure VSort(var V: TIntVector; const Desc: Boolean = False);
  procedure VSort(var V: TInt64Vector; const Desc: Boolean = False);
  procedure VSort(var V: TDateVector; const Desc: Boolean = False);

  {ПЕРЕСТАНОВКА ПО ВЕКТОРУ ИНДЕКСОВ}
  procedure VReplace(var V: TStrVector; const Indexes: TIntVector);
  procedure VReplace(var V: TIntVector; const Indexes: TIntVector);
  procedure VReplace(var V: TInt64Vector; const Indexes: TIntVector);
  procedure VReplace(var V: TDateVector; const Indexes: TIntVector);

  {ПРОВЕРКА И КОРРЕКТИРОВКА ИНДЕКСОВ}
  function CheckFromToIndexes(MaxIndex: Integer; var FromIndex, ToIndex: Integer): Boolean;
  function CheckIndex(const MaxIndex, Ind: Integer): Boolean;
  function CheckIndexes(const MaxIndex, Ind1, Ind2: Integer): Boolean;

implementation

//проверка диапазона индексов
function CheckFromToIndexes(MaxIndex: Integer; var FromIndex, ToIndex: Integer): Boolean;
begin
  if MaxIndex<0 then
    Result:= False
  else begin
    if FromIndex<0 then FromIndex:= 0;
    if (ToIndex<0) or (ToIndex>MaxIndex) then ToIndex:= MaxIndex;
    Result:= FromIndex<=ToIndex;
  end;
end;

//проверка корректности индекса
function CheckIndex(const MaxIndex, Ind: Integer): Boolean;
begin
  Result:= (Ind>=0) and (Ind<=MaxIndex);
end;

//проверка корректности и неравных значений индексов
function CheckIndexes(const MaxIndex, Ind1, Ind2: Integer): Boolean;
begin
  Result:= CheckIndex(MaxIndex, Ind1) and CheckIndex(MaxIndex, Ind2) and (Ind1<>Ind2);
end;

//VDim

procedure VDim(var V: TIntVector; const Size: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64 = VECTOR_INT_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TStrVector; const Size: Integer; const DefaultValue: String = VECTOR_STR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TDblVector; const Size: Integer; const DefaultValue: Double = VECTOR_DBL_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TBoolVector; const Size: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = VECTOR_COLOR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;


//VReDim

procedure VReDim(var V: TIntVector; const Size: Integer; const DefaultValue: Integer = VECTOR_INT_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64 = VECTOR_INT_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TStrVector; const Size: Integer; const DefaultValue: String = VECTOR_STR_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TDblVector; const Size: Integer; const DefaultValue: Double = VECTOR_DBL_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TBoolVector; const Size: Integer; const DefaultValue: Boolean = VECTOR_BOOL_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = VECTOR_COLOR_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

//VIsNil

function VIsNil(const V: TIntVector): Boolean;
begin
  Result:= Length(V)=0;
end;

function VIsNil(const V: TInt64Vector): Boolean;
begin
  Result:= Length(V)=0;
end;

function VIsNil(const V: TStrVector): Boolean;
begin
  Result:= Length(V)=0;
end;

function VIsNil(const V: TDblVector): Boolean;
begin
  Result:= Length(V)=0;
end;

function VIsNil(const V: TBoolVector): Boolean;
begin
  Result:= Length(V)=0;
end;

function VIsNil(const V: TColorVector): Boolean;
begin
  Result:= Length(V)=0;
end;

//VCreate

function VCreateInt(const V: array of Integer): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= Low(V) to High(V) do
    VAppend(Result, V[i]);
end;

function VCreateInt64(const V: array of Int64): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= Low(V) to High(V) do
    VAppend(Result, V[i]);
end;

function VCreateStr(const V: array of String): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= Low(V) to High(V) do
    VAppend(Result, V[i]);
end;

function VCreateDbl(const V: array of Double): TDblVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= Low(V) to High(V) do
    VAppend(Result, V[i]);
end;

function VCreateDate(const V: array of TDate): TDateVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= Low(V) to High(V) do
    VAppend(Result, V[i]);
end;

function VCreateBool(const V: array of Boolean): TBoolVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= Low(V) to High(V) do
    VAppend(Result, V[i]);
end;

function VCreateColor(const V: array of TColor): TColorVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= Low(V) to High(V) do
    VAppend(Result, V[i]);
end;

//VChangeIn

procedure VChangeIn(var V: TIntVector; const NewValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do V[i]:= NewValue;
end;

procedure VChangeIn(var V: TInt64Vector; const NewValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do V[i]:= NewValue;
end;

procedure VChangeIn(var V: TStrVector; const NewValue: String; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do V[i]:= NewValue;
end;

procedure VChangeIn(var V: TDblVector; const NewValue: Double; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do V[i]:= NewValue;
end;

procedure VChangeIn(var V: TBoolVector; const NewValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do V[i]:= NewValue;
end;

procedure VChangeIn(var V: TColorVector; const NewValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do V[i]:= NewValue;
end;

//VChangeIf
procedure VChangeIf(var V: TIntVector;  const IfValue, NewValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if V[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TInt64Vector; const IfValue, NewValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if V[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TStrVector;
                   const IfValue, NewValue: String;
                   FromIndex: Integer=-1; ToIndex: Integer=-1;
                   const ACaseSensitivity: Boolean = True);
var
  i: Integer;
  S1, S2: String;
begin
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  S2:= IfValue;
  if not ACaseSensitivity then
    S2:= SUpper(S2);
  for i:= FromIndex to ToIndex do
  begin
    S1:= V[i];
    if not ACaseSensitivity then
      S1:= SUpper(S1);
    if S1=S2 then
      V[i]:= NewValue;
  end;
end;

procedure VChangeIf(var V: TDateVector;  const IfValue, NewValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if SameDate(V[i],IfValue) then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TBoolVector;  const IfValue, NewValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if V[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TColorVector; const IfValue, NewValue: TColor; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if V[i]=IfValue then V[i]:= NewValue;
end;

//VChangeNotIn

procedure VChangeNotIn(var V: TIntVector; const NewValue: Integer; FromIndex, ToIndex: Integer);
var
  i, n: Integer;
begin
  n:= High(V);
  if not CheckFromToIndexes(n, FromIndex, ToIndex) then Exit;
  for i:= 0 to FromIndex-1 do V[i]:= NewValue;
  for i:= ToIndex+1 to n do V[i]:= NewValue;
end;

procedure VChangeNotIn(var V: TInt64Vector; const NewValue: Int64; FromIndex, ToIndex: Integer);
var
  i, n: Integer;
begin
  n:= High(V);
  if not CheckFromToIndexes(n, FromIndex, ToIndex) then Exit;
  for i:= 0 to FromIndex-1 do V[i]:= NewValue;
  for i:= ToIndex+1 to n do V[i]:= NewValue;
end;

procedure VChangeNotIn(var V: TStrVector; const NewValue: String; FromIndex, ToIndex: Integer);
var
  i, n: Integer;
begin
  n:= High(V);
  if not CheckFromToIndexes(n, FromIndex, ToIndex) then Exit;
  for i:= 0 to FromIndex-1 do V[i]:= NewValue;
  for i:= ToIndex+1 to n do V[i]:= NewValue;
end;

procedure VChangeNotIn(var V: TDblVector; const NewValue: Double; FromIndex, ToIndex: Integer);
var
  i, n: Integer;
begin
  n:= High(V);
  if not CheckFromToIndexes(n, FromIndex, ToIndex) then Exit;
  for i:= 0 to FromIndex-1 do V[i]:= NewValue;
  for i:= ToIndex+1 to n do V[i]:= NewValue;
end;

procedure VChangeNotIn(var V: TBoolVector; const NewValue: Boolean; FromIndex, ToIndex: Integer);
var
  i, n: Integer;
begin
  n:= High(V);
  if not CheckFromToIndexes(n, FromIndex, ToIndex) then Exit;
  for i:= 0 to FromIndex-1 do V[i]:= NewValue;
  for i:= ToIndex+1 to n do V[i]:= NewValue;
end;

procedure VChangeNotIn(var V: TColorVector; const NewValue: TColor;  FromIndex, ToIndex: Integer);
var
  i, n: Integer;
begin
  n:= High(V);
  if not CheckFromToIndexes(n, FromIndex, ToIndex) then Exit;
  for i:= 0 to FromIndex-1 do V[i]:= NewValue;
  for i:= ToIndex+1 to n do V[i]:= NewValue;
end;

//VFirst
function VFirst(const V: TIntVector): Integer;
begin
  Result:= V[0];
end;

function VFirst(const V: TInt64Vector): Int64;
begin
  Result:= V[0];
end;

function VFirst(const V: TStrVector): String;
begin
  Result:= V[0];
end;

function VFirst(const V: TDblVector): Double;
begin
  Result:= V[0];
end;

function VFirst(const V: TBoolVector): Boolean;
begin
  Result:= V[0];
end;

function VFirst(const V: TColorVector): TColor;
begin
  Result:= V[0];
end;

//VLast

function VLast(const V: TIntVector): Integer;
begin
  Result:= V[High(V)];
end;

function VLast(const V: TInt64Vector): Int64;
begin
  Result:= V[High(V)];
end;

function VLast(const V: TStrVector): String;
begin
  Result:= V[High(V)];
end;

function VLast(const V: TDblVector): Double;
begin
  Result:= V[High(V)];
end;

function VLast(const V: TBoolVector): Boolean;
begin
  Result:= V[High(V)];
end;

function VLast(const V: TColorVector): TColor;
begin
  Result:= V[High(V)];
end;

//VSwap

procedure VSwap(var V:TIntVector; const Index1, Index2: Integer);
var
  TmpValue: Integer;
begin
  //проверка индексов
  if not CheckIndexes(High(V), Index1, Index2) then Exit;
  //запоминаем значение элемента с индексом Index1
  TmpValue:= V[Index1];
  //записываем в позицию первого элемента значение второго элемента
  V[Index1]:= V[Index2];
  //записываем в позицию второго элемента сохраненное значение первого элемента
  V[Index2]:= TmpValue;
end;

procedure VSwap(var V:TInt64Vector; const Index1, Index2: Integer);
var
  TmpValue: Int64;
begin
  if not CheckIndexes(High(V), Index1, Index2) then Exit;
  TmpValue:= V[Index1];
  V[Index1]:= V[Index2];
  V[Index2]:= TmpValue;
end;

procedure VSwap(var V:TStrVector; const Index1, Index2: Integer);
var
  TmpValue: String;
begin
  if not CheckIndexes(High(V), Index1, Index2) then Exit;
  TmpValue:= V[Index1];
  V[Index1]:= V[Index2];
  V[Index2]:= TmpValue;
end;

procedure VSwap(var V:TDblVector; const Index1, Index2: Integer);
var
  TmpValue: Double;
begin
  if not CheckIndexes(High(V), Index1, Index2) then Exit;
  TmpValue:= V[Index1];
  V[Index1]:= V[Index2];
  V[Index2]:= TmpValue;
end;

procedure VSwap(var V:TBoolVector; const Index1, Index2: Integer);
var
  TmpValue: Boolean;
begin
  if not CheckIndexes(High(V), Index1, Index2) then Exit;
  TmpValue:= V[Index1];
  V[Index1]:= V[Index2];
  V[Index2]:= TmpValue;
end;

procedure VSwap(var V: TColorVector; const Index1, Index2: Integer);
var
  TmpValue: TColor;
begin
  if not CheckIndexes(High(V), Index1, Index2) then Exit;
  TmpValue:= V[Index1];
  V[Index1]:= V[Index2];
  V[Index2]:= TmpValue;
end;

//VDel

procedure VDel(var V:TIntVector; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  //старый размер вектора
  OldSize:= Length(V);
  if OldSize=0 then Exit;
  //если второй индекс меньше первого - операция сводится к удалению одного элемента
  if Index2< Index1 then Index2:= Index1;
  //проверка корректности индексов
  i:= High(V);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  //длина удаляемого сегмента
  DelLength:= Index2 - Index1 + 1;
  //если удаляются все элементы
  if OldSize=DelLength then
  begin
    SetLength(V, 0);
    Exit;
  end;
  //сдвигаем элементы, расположенные после удаляемого сегмента в начало этого сегмента
  for i := Index2+1 to OldSize-1 do  V[i-DelLength]:= V[i];
  //усекаем вектор
  VReDim(V, OldSize - DelLength);
end;

procedure VDel(var V:TInt64Vector; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  OldSize:= Length(V);
  if OldSize=0 then Exit;
  if Index2< Index1 then Index2:= Index1;
  i:= High(V);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    SetLength(V, 0);
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  V[i-DelLength]:= V[i];
  VReDim(V, OldSize - DelLength);
end;

procedure VDel(var V:TStrVector; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  OldSize:= Length(V);
  if OldSize=0 then Exit;
  if Index2< Index1 then Index2:= Index1;
  i:= High(V);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    SetLength(V, 0);
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  V[i-DelLength]:= V[i];
  VReDim(V, OldSize - DelLength);
end;

procedure VDel(var V:TDblVector; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  OldSize:= Length(V);
  if OldSize=0 then Exit;
  if Index2< Index1 then Index2:= Index1;
  i:= High(V);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    SetLength(V, 0);
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  V[i-DelLength]:= V[i];
  VReDim(V, OldSize - DelLength);
end;

procedure VDel(var V:TBoolVector; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  OldSize:= Length(V);
  if OldSize=0 then Exit;
  if Index2< Index1 then Index2:= Index1;
  i:= High(V);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    SetLength(V, 0);
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  V[i-DelLength]:= V[i];
  VReDim(V, OldSize - DelLength);
end;

procedure VDel(var V: TColorVector; const Index1: Integer; Index2: Integer = -1);
var
  i, OldSize, DelLength: Integer;
begin
  OldSize:= Length(V);
  if OldSize=0 then Exit;
  if Index2< Index1 then Index2:= Index1;
  i:= High(V);
  if not (CheckIndex(i, Index1) and CheckIndex(i, Index2)) then Exit;
  DelLength:= Index2 - Index1 + 1;
  if OldSize=DelLength then
  begin
    SetLength(V, 0);
    Exit;
  end;
  for i := Index2+1 to OldSize-1 do  V[i-DelLength]:= V[i];
  VReDim(V, OldSize - DelLength);
end;

//VCopy

procedure VCopy(const Source: TIntVector; var Dest: TIntVector; const FromIndex: Integer = 0);
var
   i, SSize, DSize: Integer;
begin
   if VIsNil(Source) then Exit;
   //размер вектора-источника
   SSize:= Length(Source);
   //размер вектора-приемника
   DSize:= Length(Dest);
   //необходимый минимальный размер вектора-приемника
   i:= SSize + FromIndex;
   //если размер вектора-приемника недостаточный, увеличиваем его
   if DSize < i then  VReDim(Dest, i);
   //копируем Source в Dest с позиции FromIndex
   for i := 0 to SSize - 1 do
       Dest[FromIndex+i]:= Source[i];
end;

procedure VCopy(const Source: TInt64Vector; var Dest: TInt64Vector; const FromIndex: Integer = 0);
var
   i, SSize, DSize: Integer;
begin
   if VIsNil(Source) then Exit;
   SSize:= Length(Source);
   DSize:= Length(Dest);
   i:= SSize + FromIndex;
   if DSize < i then  VReDim(Dest, i);
   for i := 0 to SSize - 1 do
     Dest[FromIndex+i]:= Source[i];
end;

procedure VCopy(const Source: TStrVector; var Dest: TStrVector; const FromIndex: Integer = 0);
var
   i, SSize, DSize: Integer;
begin
   if VIsNil(Source) then Exit;
   SSize:= Length(Source);
   DSize:= Length(Dest);
   i:= SSize + FromIndex;
   if DSize < i then  VReDim(Dest, i);
   for i := 0 to SSize - 1 do
     Dest[FromIndex+i]:= Source[i];
end;

procedure VCopy(const Source: TDblVector; var Dest: TDblVector; const FromIndex: Integer = 0);
var
   i, SSize, DSize: Integer;
begin
   if VIsNil(Source) then Exit;
   SSize:= Length(Source);
   DSize:= Length(Dest);
   i:= SSize + FromIndex;
   if DSize < i then  VReDim(Dest, i);
   for i := 0 to SSize - 1 do
     Dest[FromIndex+i]:= Source[i];
end;

procedure VCopy(const Source: TBoolVector; var Dest: TBoolVector; const FromIndex: Integer = 0);
var
   i, SSize, DSize: Integer;
begin
   if VIsNil(Source) then Exit;
   SSize:= Length(Source);
   DSize:= Length(Dest);
   i:= SSize + FromIndex;
   if DSize < i then  VReDim(Dest, i);
   for i := 0 to SSize - 1 do
     Dest[FromIndex+i]:= Source[i];
end;

procedure VCopy(const Source: TColorVector; var Dest: TColorVector; const FromIndex: Integer = 0);
var
   i, SSize, DSize: Integer;
begin
   if VIsNil(Source) then Exit;
   SSize:= Length(Source);
   DSize:= Length(Dest);
   i:= SSize + FromIndex;
   if DSize < i then  VReDim(Dest, i);
   for i := 0 to SSize - 1 do
     Dest[FromIndex+i]:= Source[i];
end;

//VCut

function VCut(const V: TIntVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TIntVector;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(Result, x+1);
  for i:= 0 to x do Result[i]:= V[FromIndex+i];
end;

function VCut(const V: TInt64Vector; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Vector;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(Result, x+1);
  for i:= 0 to x do Result[i]:= V[FromIndex+i];
end;

function VCut(const V: TStrVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TStrVector;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(Result, x+1);
  for i:= 0 to x do Result[i]:= V[FromIndex+i];
end;

function VCut(const V: TDblVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TDblVector;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(Result, x+1);
  for i:= 0 to x do Result[i]:= V[FromIndex+i];
end;

function VCut(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolVector;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(Result, x+1);
  for i:= 0 to x do Result[i]:= V[FromIndex+i];
end;

function VCut(const V: TColorVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TColorVector;
var
  i, x: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(Result, x+1);
  for i:= 0 to x do Result[i]:= V[FromIndex+i];
end;

function VCut(const V: TIntVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(Result, V[i]);
end;

function VCut(const V: TInt64Vector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(Result, V[i]);
end;

function VCut(const V: TStrVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(Result, V[i]);
end;

function VCut(const V: TDblVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TDblVector;
var
  i: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(Result, V[i]);
end;

function VCut(const V: TBoolVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolVector;
var
  i: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(Result, V[i]);
end;

function VCut(const V: TColorVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TColorVector;
var
  i: Integer;
begin
  Result:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(Result, V[i]);
end;


//VAdd

function VAdd(const V1,V2: TIntVector): TIntVector;
begin
  Result:= nil;
  //копируем первый вектор в начало результирующего
  VCopy(V1, Result);
  //копируем второй вектор в результирующий после окончания первого вектора
  VCopy(V2, Result, Length(V1));
end;

function VAdd(const V1,V2: TInt64Vector): TInt64Vector;
begin
  Result:= nil;
  VCopy(V1, Result);
  VCopy(V2, Result, Length(V1));
end;

function VAdd(const V1,V2: TStrVector): TStrVector;
begin
  Result:= nil;
  VCopy(V1, Result);
  VCopy(V2, Result, Length(V1));
end;

function VAdd(const V1,V2: TDblVector): TDblVector;
begin
  Result:= nil;
  VCopy(V1, Result);
  VCopy(V2, Result, Length(V1));
end;

function VAdd(const V1,V2: TBoolVector): TBoolVector;
begin
  Result:= nil;
  VCopy(V1, Result);
  VCopy(V2, Result, Length(V1));
end;

function VAdd(const V1,V2: TColorVector): TColorVector;
begin
  Result:= nil;
  VCopy(V1, Result);
  VCopy(V2, Result, Length(V1));
end;


//VAppend

procedure VAppend(var V: TIntVector; const Value: Integer);
begin
  VReDim(V, Length(V)+1, Value);
end;

procedure VAppend(var V: TInt64Vector; const Value: Int64);
begin
  VReDim(V, Length(V)+1, Value);
end;

procedure VAppend(var V: TStrVector; const Value: String);
begin
  VReDim(V, Length(V)+1, Value);
end;

procedure VAppend(var V: TDblVector; const Value: Double);
begin
  VReDim(V, Length(V)+1, Value);
end;

procedure VAppend(var V: TBoolVector; const Value: Boolean);
begin
  VReDim(V, Length(V)+1, Value);
end;

procedure VAppend(var V: TColorVector; const Value: TColor);
begin
  VReDim(V, Length(V)+1, Value);
end;

//VIns

procedure VIns(var V: TIntVector; const Ind: Integer; const Value: Integer);
var
  V1, V2: TIntVector;
begin
  if Ind=Length(V) then
  begin
    VAppend(V, Value);
    Exit;
  end;
  if not CheckIndex(High(V), Ind) then Exit;

  V1:= nil;
  if Ind>0 then
    V1:= VCut(V, 0, Ind-1);
  VAppend(V1, Value);
  V2:= VCut(V, Ind, High(V));
  V:= VAdd(V1,V2);
end;

procedure VIns(var V: TInt64Vector; const Ind: Integer; const Value: Int64);
var
  V1, V2: TInt64Vector;
begin
  if Ind=Length(V) then
  begin
    VAppend(V, Value);
    Exit;
  end;
  if not CheckIndex(High(V), Ind) then Exit;
  V1:= nil;
  if Ind>0 then
    V1:= VCut(V, 0, Ind-1);
  VAppend(V1, Value);
  V2:= VCut(V, Ind, High(V));
  V:= VAdd(V1,V2);
end;

procedure VIns(var V: TStrVector; const Ind: Integer; const Value: String);
var
  V1, V2: TStrVector;
begin
  if Ind=Length(V) then
  begin
    VAppend(V, Value);
    Exit;
  end;
  if not CheckIndex(High(V), Ind) then Exit;
  V1:= nil;
  if Ind>0 then
    V1:= VCut(V, 0, Ind-1);
  VAppend(V1, Value);
  V2:= VCut(V, Ind, High(V));
  V:= VAdd(V1,V2);
end;

procedure VIns(var V: TDblVector; const Ind: Integer; const Value: Double);
var
  V1, V2: TDateVector;
begin
  if Ind=Length(V) then
  begin
    VAppend(V, Value);
    Exit;
  end;
  if not CheckIndex(High(V), Ind) then Exit;
  V1:= nil;
  if Ind>0 then
    V1:= VCut(V, 0, Ind-1);
  VAppend(V1, Value);
  V2:= VCut(V, Ind, High(V));
  V:= VAdd(V1,V2);
end;

procedure VIns(var V: TBoolVector; const Ind: Integer; const Value: Boolean);
var
  V1, V2: TBoolVector;
begin
  if Ind=Length(V) then
  begin
    VAppend(V, Value);
    Exit;
  end;
  if not CheckIndex(High(V), Ind) then Exit;
  V1:= nil;
  if Ind>0 then
    V1:= VCut(V, 0, Ind-1);
  VAppend(V1, Value);
  V2:= VCut(V, Ind, High(V));
  V:= VAdd(V1,V2);
end;

procedure VIns(var V: TColorVector; const Ind: Integer; const Value: TColor);
var
  V1, V2: TColorVector;
begin
  if Ind=Length(V) then
  begin
    VAppend(V, Value);
    Exit;
  end;
  if not CheckIndex(High(V), Ind) then Exit;
  V1:= nil;
  if Ind>0 then
    V1:= VCut(V, 0, Ind-1);
  VAppend(V1, Value);
  V2:= VCut(V, Ind, High(V));
  V:= VAdd(V1,V2);
end;

procedure VIns(var V: TIntVector; const Ind: Integer; const Source: TIntVector);
var
  TmpV1, TmpV2: TIntVector;
begin
  if VIsNil(Source) then Exit;
  if VIsNil(V) then Exit;
  if not CheckIndex(High(V), Ind) then Exit;
  if Ind=0 then
    V:= VAdd(Source, V)
  else begin
    TmpV1:= VCut(V,0,Ind-1);
    TmpV2:= VCut(V,Ind);
    V:= VAdd(TmpV1, Source);
    V:= VAdd(V, TmpV2);
  end;
end;

procedure VIns(var V: TInt64Vector; const Ind: Integer; const Source: TInt64Vector);
var
  TmpV1, TmpV2: TInt64Vector;
begin
  if VIsNil(Source) then Exit;
  if VIsNil(V) then Exit;
  if not CheckIndex(High(V), Ind) then Exit;
  if Ind=0 then
    V:= VAdd(Source, V)
  else begin
    TmpV1:= VCut(V,0,Ind-1);
    TmpV2:= VCut(V,Ind);
    V:= VAdd(TmpV1, Source);
    V:= VAdd(V, TmpV2);
  end;
end;

procedure VIns(var V: TStrVector; const Ind: Integer; const Source: TStrVector);
var
  TmpV1, TmpV2: TStrVector;
begin
  if VIsNil(Source) then Exit;
  if VIsNil(V) then Exit;
  if not CheckIndex(High(V), Ind) then Exit;
  if Ind=0 then
    V:= VAdd(Source, V)
  else begin
    TmpV1:= VCut(V,0,Ind-1);
    TmpV2:= VCut(V,Ind);
    V:= VAdd(TmpV1, Source);
    V:= VAdd(V, TmpV2);
  end;
end;

procedure VIns(var V: TDblVector; const Ind: Integer; const Source: TDblVector);
var
  TmpV1, TmpV2: TDblVector;
begin
  if VIsNil(Source) then Exit;
  if VIsNil(V) then Exit;
  if not CheckIndex(High(V), Ind) then Exit;
  if Ind=0 then
    V:= VAdd(Source, V)
  else begin
    TmpV1:= VCut(V,0,Ind-1);
    TmpV2:= VCut(V,Ind);
    V:= VAdd(TmpV1, Source);
    V:= VAdd(V, TmpV2);
  end;
end;

procedure VIns(var V: TBoolVector; const Ind: Integer; const Source: TBoolVector);
var
  TmpV1, TmpV2: TBoolVector;
begin
  if VIsNil(Source) then Exit;
  if VIsNil(V) then Exit;
  if not CheckIndex(High(V), Ind) then Exit;
  if Ind=0 then
    V:= VAdd(Source, V)
  else begin
    TmpV1:= VCut(V,0,Ind-1);
    TmpV2:= VCut(V,Ind);
    V:= VAdd(TmpV1, Source);
    V:= VAdd(V, TmpV2);
  end;
end;

procedure VIns(var V: TColorVector; const Ind: Integer; const Source: TColorVector);
var
  TmpV1, TmpV2: TColorVector;
begin
  if VIsNil(Source) then Exit;
  if VIsNil(V) then Exit;
  if not CheckIndex(High(V), Ind) then Exit;
  if Ind=0 then
    V:= VAdd(Source, V)
  else begin
    TmpV1:= VCut(V,0,Ind-1);
    TmpV2:= VCut(V,Ind);
    V:= VAdd(TmpV1, Source);
    V:= VAdd(V, TmpV2);
  end;
end;

//VIndexOf

function VIndexOf(const V: TIntVector; const FindValue: Integer): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TInt64Vector; const FindValue: Int64): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TStrVector; const FindValue: String;
                  const ACaseSensitivity: Boolean = True): Integer;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= -1;
  S1:= FindValue;
  if not ACaseSensitivity then
    S1:= SUpper(S1);
  for i := 0 to High(V) do
  begin
    S2:= V[i];
    if not ACaseSensitivity then
      S2:= SUpper(S2);
    if S1=S2 then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TDateVector; const FindValue: TDate): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if CompareDate(V[i], FindValue)=0 then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TBoolVector; const FindValue: Boolean): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TColorVector; const FindValue: TColor):  Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

//VUnique

function VUnique(const V: TIntVector): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
  begin
    if VIndexOf(Result, V[i])=-1 then
      VAppend(Result, V[i]);
  end;
end;

function VUnique(const V: TInt64Vector): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
  begin
    if VIndexOf(Result, V[i])=-1 then
      VAppend(Result, V[i]);
  end;
end;

function VUnique(const V: TStrVector;
                 const ACaseSensitivity: Boolean = True): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
  begin
    if VIndexOf(Result, V[i], ACaseSensitivity)=-1 then
      VAppend(Result, V[i]);
  end;
end;

function VUnique(const V: TDateVector): TDateVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
  begin
    if VIndexOf(Result, V[i])=-1 then
      VAppend(Result, V[i]);
  end;
end;

function VUnique(const V: TColorVector): TColorVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
  begin
    if VIndexOf(Result, V[i])=-1 then
      VAppend(Result, V[i]);
  end;
end;

//VUnion

function VUnion(const V1, V2: TIntVector): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V1) and VIsNil(V2) then Exit;
  if (not VIsNil(V1)) and (not VIsNil(V2)) then
  begin
    Result:= VCut(V1);
    for i:=0 to High(V2) do
      if VIndexOf(V1, V2[i])<0 then
        VAppend(Result, V2[i]);
  end
  else begin
    if (not VIsNil(V1)) then
      Result:= VCut(V1)
    else
      Result:= VCut(V2);
  end;
end;

function VUnion(const V1,V2: TInt64Vector): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V1) and VIsNil(V2) then Exit;
  if (not VIsNil(V1)) and (not VIsNil(V2)) then
  begin
    Result:= VCut(V1);
    for i:=0 to High(V2) do
      if VIndexOf(V1, V2[i])<0 then
        VAppend(Result, V2[i]);
  end
  else begin
    if (not VIsNil(V1)) then
      Result:= VCut(V1)
    else
      Result:= VCut(V2);
  end;
end;

function VUnion(const V1, V2: TStrVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V1) and VIsNil(V2) then Exit;
  if (not VIsNil(V1)) and (not VIsNil(V2)) then
  begin
    Result:= VCut(V1);
    for i:=0 to High(V2) do
      if VIndexOf(V1, V2[i])<0 then
        VAppend(Result, V2[i]);
  end
  else begin
    if (not VIsNil(V1)) then
      Result:= VCut(V1)
    else
      Result:= VCut(V2);
  end;
end;

function VUnion(const V1, V2: TDateVector): TDateVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V1) and VIsNil(V2) then Exit;
  if (not VIsNil(V1)) and (not VIsNil(V2)) then
  begin
    Result:= VCut(V1);
    for i:=0 to High(V2) do
      if VIndexOf(V1, V2[i])<0 then
        VAppend(Result, V2[i]);
  end
  else begin
    if (not VIsNil(V1)) then
      Result:= VCut(V1)
    else
      Result:= VCut(V2);
  end;
end;

function VUnion(const V1, V2: TColorVector): TColorVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V1) and VIsNil(V2) then Exit;
  if (not VIsNil(V1)) and (not VIsNil(V2)) then
  begin
    Result:= VCut(V1);
    for i:=0 to High(V2) do
      if VIndexOf(V1, V2[i])<0 then
        VAppend(Result, V2[i]);
  end
  else begin
    if (not VIsNil(V1)) then
      Result:= VCut(V1)
    else
      Result:= VCut(V2);
  end;
end;

//VMin

function VMin(const V: TIntVector): Integer;
var
  i: Integer;
begin
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]<Result then Result:= V[i];
end;

function VMin(const V: TInt64Vector): Int64;
var
  i: Integer;
begin
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]<Result then Result:= V[i];
end;


function VMin(const V: TStrVector; const ACaseSensitivity: Boolean = True): String;
var
  i: Integer;
  S1, S2: String;
begin
  //Result:= V[0];
  //for i:=1 to High(V) do
  //  if V[i]<Result then Result:= V[i];
  Result:= V[0];
  for i:=1 to High(V) do
  begin
    S1:= V[i];
    S2:= Result;
    if not ACaseSensitivity then
    begin
      S1:= SUpper(S1);
      S2:= SUpper(S2);
    end;
    if S1<S2 then
      Result:= V[i];
  end;
end;

function VMin(const V: TDateVector): TDate;
var
  i: Integer;
begin
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]<Result then Result:= V[i];
end;

//VMax

function VMax(const V: TIntVector): Integer;
var
  i: Integer;
begin
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]>Result then Result:= V[i];
end;

function VMax(const V: TInt64Vector): Int64;
var
  i: Integer;
begin
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]>Result then Result:= V[i];
end;

function VMax(const V: TStrVector; const ACaseSensitivity: Boolean = True): String;
var
  i: Integer;
  S1, S2: String;
begin
  //Result:= V[0];
  //for i:=1 to High(V) do
  //  if V[i]>Result then Result:= V[i];
  Result:= V[0];
  for i:=1 to High(V) do
  begin
    S1:= V[i];
    S2:= Result;
    if not ACaseSensitivity then
    begin
      S1:= SUpper(S1);
      S2:= SUpper(S2);
    end;
    if S1>S2 then
      Result:= V[i];
  end;
end;

function VMax(const V: TDateVector): TDate;
var
  i: Integer;
begin
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]>Result then Result:= V[i];
end;

//VCountIf

function VCountIf(const V: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(Result);
end;

function VCountIf(const V: TInt64Vector; const IfValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(Result);
end;

function VCountIf(const V: TStrVector; const IfValue: String;
                  FromIndex: Integer=-1; ToIndex: Integer=-1;
                  const ACaseSensitivity: Boolean = True): Integer;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  S2:= IfValue;
  if not ACaseSensitivity then
    S2:= SUpper(S2);
  for i := FromIndex to ToIndex do
  begin
    S1:= V[i];
    if not ACaseSensitivity then
      S1:= SUpper(S1);
    if S1=S2 then
      Inc(Result);
  end;
end;

function VCountIf(const V: TDateVector; const IfValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(Result);
end;

function VCountIf(const V: TBoolVector; const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(Result);
end;

function VCountIf(const V: TColorVector; const IfValue: TColor; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(Result);
end;

//VCountIfNot

function VCountIfNot(const V: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(Result);
end;

function VCountIfNot(const V: TInt64Vector; const IfValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(Result);
end;

function VCountIfNot(const V: TStrVector; const IfValue: String;
                     FromIndex: Integer=-1; ToIndex: Integer=-1;
                     const ACaseSensitivity: Boolean = True): Integer;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  S2:= IfValue;
  if not ACaseSensitivity then
    S2:= SUpper(S2);
  for i := FromIndex to ToIndex do
  begin
    S1:= V[i];
    if not ACaseSensitivity then
      S1:= SUpper(S1);
    if S1<>S2 then
      Inc(Result);
  end;
end;

function VCountIfNot(const V: TDateVector; const IfValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(Result);
end;

function VCountIfNot(const V: TBoolVector; const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(Result);
end;

function VCountIfNot(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(Result);
end;


//VOrder

function VOrder(const MaxValue: Integer): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 1 to MaxValue do
    VAppend(Result, i);
end;

//VMult

function VMult(const V1,V2: TIntVector): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(Result, Length(V1));
  for i := 0 to High(V1) do
    Result[i]:= V1[i] * V2[i];
end;

function VMult(const V1,V2: TInt64Vector): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(Result, Length(V1));
  for i := 0 to High(V1) do
    Result[i]:= V1[i] * V2[i];
end;

function VMult(const V1: TStrVector; const V2: TIntVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(Result, Length(V1));
  for i := 0 to High(V1) do
  begin
    if (V2[i]=0) then
      Result[i]:= EmptyStr
    else
      Result[i]:= V1[i];
  end;
end;

//VSum

function VSum(const V: TIntVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    Result:= Result + V[i];
end;

function VSum(const V: TStrVector; FromIndex: Integer; ToIndex: Integer): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    Result:= Result + V[i];
end;

function VSum(const V: TDblVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Double;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    Result:= Result + V[i];
end;

function VSum(const V: TInt64Vector; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    Result:= Result + V[i];
end;

function VSum(const V1,V2: TStrVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(Result, Length(V1));
  for i := 0 to High(V1) do
    Result[i]:= V1[i] + V2[i];
end;

function VSum(const V1, V2: TDblVector): TDblVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(Result, Length(V1));
  for i := 0 to High(V1) do
    Result[i]:= V1[i] + V2[i];
end;

function VSum(const V1,V2: TIntVector): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(Result, Length(V1));
  for i := 0 to High(V1) do
    Result[i]:= V1[i] + V2[i];
end;

function VSum(const V1,V2: TInt64Vector): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(Result, Length(V1));
  for i := 0 to High(V1) do
    Result[i]:= V1[i] + V2[i];
end;

//VSumIf

function VSumIf(const V: TIntVector; const IfVector: TIntVector; const IfValue: Integer;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TStrVector; const IfValue: String;
                FromIndex: Integer=-1; ToIndex: Integer=-1;
                const ACaseSensitivity: Boolean = True): Integer;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  S2:= IfValue;
  if not ACaseSensitivity then
    S2:= SUpper(S2);
  for i:=FromIndex to ToIndex do
  begin
    S1:= IfVector[i];
    if not ACaseSensitivity then
      S1:= SUpper(S1);
    if S1=S2 then
      Result:= Result + V[i];
  end;
end;

function VSumIf(const V: TIntVector; const IfVector: TDateVector; const IfValue: TDate;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TBoolVector; const IfValue: Boolean;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TIntVector; const IfValue: Integer;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TStrVector; const IfValue: String;
                FromIndex: Integer=-1; ToIndex: Integer=-1;
                const ACaseSensitivity: Boolean = True): Int64;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  S2:= IfValue;
  if not ACaseSensitivity then
    S2:= SUpper(S2);
  for i:=FromIndex to ToIndex do
  begin
    S1:= IfVector[i];
    if not ACaseSensitivity then
      S1:= SUpper(S1);
    if S1=S2 then
      Result:= Result + V[i];
  end;
end;

function VSumIf(const V: TInt64Vector; const IfVector: TDateVector; const IfValue: TDate;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TBoolVector; const IfValue: Boolean;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then Result:= Result + V[i];
end;

//VSumIfNot

function VSumIfNot(const V: TIntVector; const IfVector: TIntVector; const IfValue: Integer;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then Result:= Result + V[i];
end;

function VSumIfNot(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then Result:= Result + V[i];
end;


function VSumIfNot(const V: TIntVector; const IfVector: TStrVector; const IfValue: String;
                   FromIndex: Integer=-1; ToIndex: Integer=-1;
                   const ACaseSensitivity: Boolean = True): Integer;
var
  i: Integer;
  S1, S2: String;
begin
   Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  S2:= IfValue;
  if not ACaseSensitivity then
    S2:= SUpper(S2);
  for i:=FromIndex to ToIndex do
  begin
    S1:= IfVector[i];
    if not ACaseSensitivity then
      S1:= SUpper(S1);
    if S1<>S2 then
      Result:= Result + V[i];
  end;
end;

function VSumIfNot(const V: TIntVector; const IfVector: TDateVector; const IfValue: TDate;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then Result:= Result + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then Result:= Result + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then Result:= Result + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TStrVector; const IfValue: String;
                   FromIndex: Integer=-1; ToIndex: Integer=-1;
                   const ACaseSensitivity: Boolean = True): Int64;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  S2:= IfValue;
  if not ACaseSensitivity then
    S2:= SUpper(S2);
  for i:=FromIndex to ToIndex do
  begin
    S1:= IfVector[i];
    if not ACaseSensitivity then
      S1:= SUpper(S1);
    if S1<>S2 then
      Result:= Result + V[i];
  end;
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TDateVector; const IfValue: TDate;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then Result:= Result + V[i];
end;

{ПРЕОБРАЗОВНИЕ К СТРОКОВОМУ ВЕКТОРУ}
function VIntToStr(const V: TIntVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V)>0 then
  begin
    VDim(Result, Length(V));
    for i:=0 to High(V) do
      Result[i]:= IntToStr(V[i]);
  end;
end;

function VIntToStr(const V: TInt64Vector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V)>0 then
  begin
    VDim(Result, Length(V));
    for i:=0 to High(V) do
      Result[i]:= IntToStr(V[i]);
  end;
end;

function VDateToStr(const V: TDateVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V)>0 then
  begin
    VDim(Result, Length(V));
    for i:=0 to High(V) do
      Result[i]:= DateToStr(V[i]);
  end;
end;

function VBoolToStr(const V: TBoolVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V)>0 then
  begin
    VDim(Result, Length(V));
    for i:=0 to High(V) do
      if V[i] then
        Result[i]:= STR_TRUE
      else
        Result[i]:= STR_FALSE;
  end;
end;

function VFloatToStr(const V: TDblVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V)>0 then
  begin
    VDim(Result, Length(V));
    for i:=0 to High(V) do
      Result[i]:= FloatToStr(V[i]);
  end;
end;

function VFormatDateTime(const FormatStr: String; const V: TDateVector; Options: TFormatDateTimeOptions = []): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if Length(V)>0 then
  begin
    VDim(Result, Length(V));
    for i:=0 to High(V) do
      Result[i]:= FormatDateTime(FormatStr, V[i], Options);
  end;
end;

function VTrim(const V: TStrVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
    VAppend(Result, STrim(V[i]));
end;

{СТРОКОВЫЙ ВЕКТОР И СПИСОК}
function VFromStrings(const S: TStrings): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to S.Count-1 do
    VAppend(Result, S[i]);
end;

procedure VToStrings(const V: TStrVector; const S: TStrings);
var
  i: Integer;
begin
  if not Assigned(S) then Exit;
  S.Clear;
  for i:= 0 to High(V) do
    S.Append(V[i]);
end;

{СТРОКОВЫЙ ВЕКТОР И СТРОКА}

function VStrToVector(const Str, Delimiter: String): TStrVector;
var
  S: String;
  n, LDelimiter: Integer;
begin
  Result:= nil;
  if SLength(Str)=0 then Exit;

  LDelimiter:= SLength(Delimiter);
  if (LDelimiter=0) then
  begin
    VAppend(Result, Str);
    Exit;
  end;

  S:= Str;
  n:= SPos(S, Delimiter);
  while n>0 do
  begin
    if n=1 then
      S:= SDel(S, 1, LDelimiter)
    else begin
      VAppend(Result, SCopy(S, 1, n-1));
      S:= SDel(S, 1, n+LDelimiter-1);
    end;
    n:= SPos(S, Delimiter);
  end;

  if SLength(S)>0 then
    VAppend(Result, S);


end;

function VVectorToStr(const V: TStrVector; const Delimiter: String): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:= 1 to High(V) do
    Result:= Result + Delimiter + V[i];
end;

{ДЛЯ ВЕКТОРА ДАТ}

function VCrossInd(const V: TDateVector; const ABeginDate, AEndDate: TDate; out I1,I2: Integer): Boolean;
var
  BD, ED: TDate;
  n: Integer;
begin
  Result:= False;
  I1:= -1; I2:= -1;
  If Length(V)=0 then Exit;
  BD:=0; ED:=0;
  n:= High(V);
  if IsPeriodIntersect(V[0], V[n], ABeginDate, AEndDate, BD, ED) then
  begin
    I1:= VCountBefore(V, BD);
    I2:= n - VCountAfter(V, ED);
    Result:= True;
  end;
end;

function VCut(const V: TDateVector; const ABeginDate, AEndDate: TDate): TDateVector;
var
  I1, I2: Integer;
begin
  Result:= nil;
  if VCrossInd(V, ABeginDate, AEndDate, I1, I2) then
    Result:= VCut(V, I1, I2);
end;

function VCountIn(const V: TDateVector; const ABeginDate, AEndDate: TDate): Integer;
var
  I1, I2: Integer;
begin
  Result:= 0;
  if VCrossInd(V, ABeginDate, AEndDate, I1, I2) then
    Result:= I2 - I1 + 1;
end;

function VCountBefore(const V: TDateVector; const ADate: TDate): Integer;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to High(V) do
  begin
    if CompareDate(V[i], ADate)<0 then
      Inc(Result);
  end;
end;

function VCountAfter(const V: TDateVector; const ADate: TDate): Integer;
var
  i: Integer;
begin
  Result:= 0;
  for i:= 0 to High(V) do
  begin
    if CompareDate(V[i], ADate)>0 then
      Inc(Result);
  end;
end;



//VSort

procedure VSort(const V: TStrVector; out Indexes: TIntVector;
                const Desc: Boolean = False);
var
  Vec: TStrVector;
  Ind, TmpI: TIntVector;
  x: String;
  i: Integer;
begin
  Indexes:= nil;
  //Vec - исходный вектор
  Vec:= nil;
  VCopy(V, Vec);
  //Ind - исходный вектор индексов
  Ind:= nil;
  for i:= 0 to High(Vec) do VAppend(Ind, i);

  while Length(Vec)<>0 do
  begin
    //определяем граничное значение
    if Desc then
      x:= VMax(Vec)
    else
      x:= VMin(Vec);
    TmpI:= nil;
    //записываем индексы элементов вектора с граничным значением
    for i:= 0 to High(Vec) do
      if Vec[i]=x then
        VAppend(TmpI, i);
    //добавляем индексы в выходной вектор
    for i:= 0 to High(TmpI) do
      VAppend(Indexes, Ind[TmpI[i]]);
    //удаляем эти элементы из исходного вектора
    for i:= High(TmpI) downto 0 do
    begin
      VDel(Vec, TmpI[i]);
      VDel(Ind, TmpI[i]);
    end;
  end;
end;

procedure VSort(const V: TIntVector; out Indexes: TIntVector;
                const Desc: Boolean = False);
var
  Vec: TIntVector;
  Ind, TmpI: TIntVector;
  i, x: Integer;
begin
  Indexes:= nil;
  Vec:= nil;
  VCopy(V, Vec);
  Ind:= nil;

  for i:= 0 to High(Vec) do VAppend(Ind, i);

  while Length(Vec)<>0 do
  begin
    if Desc then
      x:= VMax(Vec)
    else
      x:= VMin(Vec);
    TmpI:= nil;
    for i:= 0 to High(Vec) do
      if Vec[i]=x then
        VAppend(TmpI, i);
    for i:= 0 to High(TmpI) do
      VAppend(Indexes, Ind[TmpI[i]]);
    for i:= High(TmpI) downto 0 do
    begin
      VDel(Vec, TmpI[i]);
      VDel(Ind, TmpI[i]);
    end;
  end;
end;

procedure VSort(const V: TInt64Vector; out Indexes: TIntVector;
                const Desc: Boolean = False);
var
  Vec: TInt64Vector;
  Ind, TmpI: TIntVector;
  x: Int64;
  i: Integer;
begin
  Indexes:= nil;
  Vec:= nil;
  VCopy(V, Vec);
  Ind:= nil;
  for i:= 0 to High(Vec) do VAppend(Ind, i);
  while Length(Vec)<>0 do
  begin
    if Desc then
      x:= VMax(Vec)
    else
      x:= VMin(Vec);
    TmpI:= nil;
    for i:= 0 to High(Vec) do
      if Vec[i]=x then
        VAppend(TmpI, i);
    for i:= 0 to High(TmpI) do
      VAppend(Indexes, Ind[TmpI[i]]);
    for i:= High(TmpI) downto 0 do
    begin
      VDel(Vec, TmpI[i]);
      VDel(Ind, TmpI[i]);
    end;
  end;
end;

procedure VSort(const V: TDateVector; out Indexes: TIntVector;
                const Desc: Boolean = False);
var
  Vec: TDateVector;
  Ind, TmpI: TIntVector;
  x: TDate;
  i: Integer;
begin
  Indexes:= nil;
  Vec:= nil;
  VCopy(V, Vec);
  Ind:= nil;
  for i:= 0 to High(Vec) do VAppend(Ind, i);
  while Length(Vec)<>0 do
  begin
    if Desc then
      x:= VMax(Vec)
    else
      x:= VMin(Vec);
    TmpI:= nil;
    for i:= 0 to High(Vec) do
      if Vec[i]=x then
        VAppend(TmpI, i);
    for i:= 0 to High(TmpI) do
      VAppend(Indexes, Ind[TmpI[i]]);
    for i:= High(TmpI) downto 0 do
    begin
      VDel(Vec, TmpI[i]);
      VDel(Ind, TmpI[i]);
    end;
  end;
end;

procedure VSort(var V: TStrVector; const Desc: Boolean = False);
var
  Indexes: TIntVector;
begin
  VSort(V, Indexes, Desc);
  VReplace(V, Indexes);
end;

procedure VSort(var V: TIntVector; const Desc: Boolean = False);
var
  Indexes: TIntVector;
begin
  VSort(V, Indexes, Desc);
  VReplace(V, Indexes);
end;

procedure VSort(var V: TInt64Vector; const Desc: Boolean = False);
var
  Indexes: TIntVector;
begin
  VSort(V, Indexes, Desc);
  VReplace(V, Indexes);
end;

procedure VSort(var V: TDateVector; const Desc: Boolean = False);
var
  Indexes: TIntVector;
begin
  VSort(V, Indexes, Desc);
  VReplace(V, Indexes);
end;

//VReplace

procedure VReplace(var V: TStrVector; const Indexes: TIntVector);
var
  TmpV: TStrVector;
  i: Integer;
begin
  VCopy(V, TmpV);
  for i:= 0 to High(Indexes) do
    V[i]:= TmpV[Indexes[i]];
end;

procedure VReplace(var V: TIntVector; const Indexes: TIntVector);
var
  TmpV: TIntVector;
  i: Integer;
begin
  VCopy(V, TmpV);
  for i:= 0 to High(Indexes) do
    V[i]:= TmpV[Indexes[i]];
end;

procedure VReplace(var V: TInt64Vector; const Indexes: TIntVector);
var
  TmpV: TInt64Vector;
  i: Integer;
begin
  VCopy(V, TmpV);
  for i:= 0 to High(Indexes) do
    V[i]:= TmpV[Indexes[i]];
end;

procedure VReplace(var V: TDateVector; const Indexes: TIntVector);
var
  TmpV: TDateVector;
  i: Integer;
begin
  VCopy(V, TmpV);
  for i:= 0 to High(Indexes) do
    V[i]:= TmpV[Indexes[i]];
end;

end.

