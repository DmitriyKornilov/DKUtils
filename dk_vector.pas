unit DK_Vector;

{Модуль для работы с векторами

 I. ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ

 Dim(V, Size, DefaultValue) - создает вектор V длиной Size, заполненный значениями DefaultValue
                            (если в V что-то было - информация теряется)
 ReDim(V, Size, DefaultValue) - изменяет длину вектора V до размера Size (если новый
                            размер меньше исходного, вектор усекается, усеченные элементы теряются;
                            если новый размер больше исходного, вектор дополняется элементами
                            со значениями DefaultValue; оставшиеся элементы не изменяются)
 ChangeIn(V, NewValue, FromIndex, ToIndex) - изменяет значения вектора V на  NewValue
                            c индекса  FromIndex до ToIndex  (включительно)
                            FromIndex, ToIndex можно не указывать,
                            тогда будет изменение по всему вектору V;
 ChangeNotIn(V, NewValue, FromIndex, ToIndex) - изменяет значения вектора V,
                            лежащие за пределами диапазона c индекса  FromIndex
                            до ToIndex на  NewValue.
 Swap(V, ValueIndex1, ValueIndex2) - меняет местами в векторе V два элемента с индексами
                                     ValueIndex1 и ValueIndex2
 Del(V, ValueIndex1, ValueIndex2) - удаляет из вектора V элементы с индекса ValueIndex1 по
                                       индекс ValueIndex2 (включительно) (ValueIndex2 можно не указывать -
                                       будет удален только 1 элемент с индексом ValueIndex1)
                                       (если ValueIndex2<ValueIndex1, будет удален только 1 элемент с индексом ValueIndex1)
 Copy(Source, Dest, FromIndex) - копирует целиком вектор Source в вектор Dest, начиная с позиции FromIndex;
                                 если FromIndex не указывать - копирование в начало вектора;
                                 если длина Dest недостаточна для записи вектора Source -
                                 длина увеличивается до необходимого размера
 Cut(V, FromIndex, ToIndex): TIntVector/TInt64Vector/TStrVector/TDateVector - возвращает срез вектора V
                                 от индекса FromIndex до индекса ToIndex (включительно)
                                 FromIndex, ToIndex можно не указывать,
                                 тогда вернется копия всего вектора V;
 Add(V1,V2): TIntVector/TInt64Vector/TStrVector/TDateVector - присоединяет вектор V2 к концу V1
                                 и возвращает получившийся вектор
 Append(V,X)   - присоединяет скаляр X к концу V

 Ins(V,Ind,X) - вставляет скаляр X в позицию Ind вектора V


 IndexOf(V, FindValue): Integer - возвращает индекс элемента вектора V (ближайшего от начала),
                                  значение которого равно FindValue;
                                  если такого элемента нет - возвращает -1
 Min(V): Integer/Int64/String/TDate - возвращает наименьшее значение вектора V
 Max(V): Integer/Int64/String/TDate - возвращает наибольшее значение вектора V
 CountIf(V, IfValue, FromIndex, ToIndex): Integer - возвращает кол-во значений элементов
                                  вектора V равных IfValue, записанных в вектор
                                  с индекса FromIndex до индекса  ToIndex;
                                  FromIndex, ToIndex можно не указывать,
                                  тогда будет счет по всему вектору V;
 CountIfNot(V, IfValue, FromIndex, ToIndex): Integer - возвращает кол-во значений элементов
                                  вектора V НЕ равных IfValue, записанных в вектор
                                  с индекса FromIndex до индекса  ToIndex;
                                  FromIndex, ToIndex можно не указывать,
                                  тогда будет счет по всему вектору V;


 II. ПРОЦЕДУРЫ И ФУНКЦИИ ЦЕЛОЧИСЛЕННОГО ВЕКТОРА

 Sum(V, FromIndex, ToIndex): Integer/Int64  - возвращает сумму значений элементов вектора V
                                        c индекса FromIndex по индекс ToIndex (включительно);
                                        FromIndex, ToIndex можно не указывать,
                                        тогда будет суммирование по всем элементам
 Sum(V1, V2): TIntVector/TInt64Vector  - возваращет вектор, значения элементов которого предстваляют
                           собой сумму соответствующих элементов векторов V1  и  V2
                           (требование: длина V1 = длина V2)
 SumIf(V, IfVector, IfValue, FromIndex, ToIndex): Integer/Int64 - возвращает сумму
                           значений элементов V[n], если в соответствующей
                           позиции n имеет место равенство IfVector[n]=IfValue
                           c идекса FromIndex до индекса ToIndex;
                           FromIndex, ToIndex можно не указывать,
                           тогда будет суммирование по всему вектору V;
                           требование: длина V = длина IfVector
 SumIfNot(V, IfVector, IfValue, FromIndex, ToIndex): Integer/Int64 - возвращает сумму
                           значений элементов V[n], если в соответствующей
                           позиции n имеет место неравенство IfVector[n]<>IfValue
                           c идекса FromIndex до индекса ToIndex;
                           FromIndex, ToIndex можно не указывать,
                           тогда будет суммирование по всему вектору V;
                           требование: длина V = длина IfVector
 Mult(V1,V2): TIntVector/TInt64Vector   - возваращет вектор, значения элементов которого предстваляют
                           собой произведение соответствующих элементов векторов V1  и  V2
                           (требование: длина V1 = длина V2)


 III. ПРОЦЕДУРЫ И ФУНКЦИИ ДЛЯ УПОРЯДОЧЕННОГО ВЕКТОРА ДАТ

 CrossInd(V, ABeginDate, AEndDate, I1, I2): Boolean - определяет, пересекается
                           ли упорядоченный вектор дат V и период с ABeginDate
                           по AEndDate (включительно). Если пересекается, то
                           записывает в I1,I2 соответствующие индексы начального
                           и конечного значений V, принадлежащих периоду,
                           в противном случае I1=I2=-1.
 Cut(V, ABeginDate, AEndDate): TDateVector - возвращает срез упорядоченного
                           вектора дат V, в котором даты ограничены периодом
                           с даты ABeginDate до AEndDate (включительно)
 CountIn(V, ABeginDate, AEndDate): Integer - возвращает кол-во значений
                           упорядоченного вектора V, принадлежащих периоду
                           с ABeginDate по AEndDate (включительно)
 CountBefore(V, ADate): Integer - кол-во элементов упорядоченного вектора V
                           значения которых меньше (строго) даты ADate
 CountAfter(V, ADate): Integer - кол-во элементов упорядоченного вектора V
                           значения которых больше (строго) даты ADate

 }

{$mode objfpc}{$H+}

{H+ ->  String=AnsiString}

interface

uses
  Classes, SysUtils, DateUtils, Graphics, DK_DateUtils;


const
  INT_VECTOR_DEFAULT_VALUE   = 0;
  INT64_VECTOR_DEFAULT_VALUE = 0;
  STR_VECTOR_DEFAULT_VALUE   = '';
  DBL_VECTOR_DEFAULT_VALUE   = 0;
  BOOL_VECTOR_DEFAULT_VALUE  = False;
  COLOR_VECTOR_DEFAULT_VALUE = 0;

type
  TIntVector   = array of Integer;
  TInt64Vector = array of Int64;
  TStrVector   = array of String;
  TDblVector   = array of Double;
  TDateVector  = type TDblVector;
  TBoolVector  = array of Boolean;
  TColorVector = array of TColor;

  {РАЗМЕРЫ ВЕКТОРОВ}
  procedure VDim(var V: TIntVector;   const Size: Integer; const DefaultValue: Integer = INT_VECTOR_DEFAULT_VALUE);
  procedure VDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64   = INT64_VECTOR_DEFAULT_VALUE);
  procedure VDim(var V: TStrVector;   const Size: Integer; const DefaultValue: String  = STR_VECTOR_DEFAULT_VALUE);
  procedure VDim(var V: TDblVector;   const Size: Integer; const DefaultValue: Double  = DBL_VECTOR_DEFAULT_VALUE);
  procedure VDim(var V: TBoolVector;  const Size: Integer; const DefaultValue: Boolean = BOOL_VECTOR_DEFAULT_VALUE);
  procedure VDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = COLOR_VECTOR_DEFAULT_VALUE);
  procedure VReDim(var V: TIntVector;   const Size: Integer; const DefaultValue: Integer = INT_VECTOR_DEFAULT_VALUE);
  procedure VReDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64 = INT64_VECTOR_DEFAULT_VALUE);
  procedure VReDim(var V: TStrVector;   const Size: Integer; const DefaultValue: String = STR_VECTOR_DEFAULT_VALUE);
  procedure VReDim(var V: TDblVector;   const Size: Integer; const DefaultValue: Double = DBL_VECTOR_DEFAULT_VALUE);
  procedure VReDim(var V: TBoolVector;  const Size: Integer; const DefaultValue: Boolean = BOOL_VECTOR_DEFAULT_VALUE);
  procedure VReDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = COLOR_VECTOR_DEFAULT_VALUE);
  function VIsNil(const V: TIntVector): Boolean;
  function VIsNil(const V: TInt64Vector): Boolean;
  function VIsNil(const V: TStrVector): Boolean;
  function VIsNil(const V: TDblVector): Boolean;
  function VIsNil(const V: TBoolVector): Boolean;
  function VIsNil(const V: TColorVector): Boolean;

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
  procedure VChangeIf(var V: TStrVector;   const IfValue, NewValue: String; FromIndex: Integer=-1; ToIndex: Integer=-1);
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

  {ПОИСК В ВЕКТОРЕ}
  function VIndexOf(const V: TIntVector;   const FindValue: Integer): Integer;
  function VIndexOf(const V: TInt64Vector; const FindValue: Int64):   Integer;
  function VIndexOf(const V: TStrVector;   const FindValue: String):  Integer;
  function VIndexOf(const V: TDateVector;  const FindValue: TDate):   Integer;
  function VIndexOf(const V: TBoolVector;  const FindValue: Boolean): Integer;
  function VIndexOf(const V: TColorVector; const FindValue: TColor):  Integer;

  {ОБЪЕДИНЕНИЕ}
  function VUnion(const V1,V2: TInt64Vector): TInt64Vector;

  {НАИМЕНЬШЕЕ ЗНАЧЕНИЕ}
  function VMin(const V: TIntVector):   Integer;
  function VMin(const V: TInt64Vector): Int64;
  function VMin(const V: TStrVector):   String;
  function VMin(const V: TDateVector):  TDate;

  {НАИБОЛЬШЕЕ ЗНАЧЕНИЕ}
  function VMax(const V: TIntVector):   Integer;
  function VMax(const V: TInt64Vector): Int64;
  function VMax(const V: TStrVector):   String;
  function VMax(const V: TDateVector):  TDate;

  {КОЛ-ВО ЗНАЧЕНИЙ, РАВНЫХ ЗАДАННОМУ}
  function VCountIf(const V: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;

  {КОЛ-ВО ЗНАЧЕНИЙ, НЕ РАВНЫХ ЗАДАННОМУ}
  function VCountIfNot(const V: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
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

  {ДЛЯ ВЕКТОРА СТРОК}
  function VSum(const V1,V2: TStrVector): TStrVector;
  function VMult(const V1: TStrVector; const V2: TIntVector): TStrVector;

  function VSum(const V: TDblVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Double;

  {ДЛЯ ЦЕЛОЧИСЛЕННОГО ВЕКТОРА}
  function VMult(const V1,V2: TIntVector): TIntVector;
  function VMult(const V1,V2: TInt64Vector): TInt64Vector;
  function VSum(const V: TIntVector;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSum(const V: TInt64Vector; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSum(const V1,V2: TIntVector)  : TIntVector;
  function VSum(const V1,V2: TInt64Vector): TInt64Vector;
  function VSumIf(const V: TIntVector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TIntVector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;

  {ДЛЯ УПОРЯДОЧЕННОГО ВЕКТОРА ДАТ}
  function VCrossInd(const V: TDateVector; const ABeginDate, AEndDate: TDate; out I1,I2: Integer): Boolean;
  function VCut(const V: TDateVector; const ABeginDate, AEndDate: TDate): TDateVector;
  function VCountIn(const V: TDateVector; const ABeginDate, AEndDate: TDate): Integer;
  function VCountBefore(const V: TDateVector; const ADate: TDate): Integer;
  function VCountAfter(const V: TDateVector; const ADate: TDate): Integer;

  {ПРОВЕРОЧНЫЕ}
  //проверка корректности и неравных значений индексов
  function CheckIndexes(const MaxIndex, Ind1, Ind2: Integer): Boolean;
  //проверка корректности индекса
  function CheckIndex(const MaxIndex, Ind: Integer): Boolean;
  //проверка диапазона индексов
  function CheckFromToIndexes(MaxIndex: Integer; var FromIndex, ToIndex: Integer): Boolean;

implementation

//проверка диапазона индексов
function CheckFromToIndexes(MaxIndex: Integer; var FromIndex, ToIndex: Integer): Boolean;
begin
  if MaxIndex<0 then
    CheckFromToIndexes:= False
  else begin
    if FromIndex<0 then FromIndex:= 0;
    if (ToIndex<0) or (ToIndex>MaxIndex) then ToIndex:= MaxIndex;
    CheckFromToIndexes:= FromIndex<=ToIndex;
  end;
end;
//проверка корректности индекса
function CheckIndex(const MaxIndex, Ind: Integer): Boolean;
begin
  CheckIndex:= (Ind>=0) and (Ind<=MaxIndex);
end;
//проверка корректности и неравных значений индексов
function CheckIndexes(const MaxIndex, Ind1, Ind2: Integer): Boolean;
begin
  CheckIndexes:= CheckIndex(MaxIndex, Ind1) and CheckIndex(MaxIndex, Ind2) and (Ind1<>Ind2);
end;

//VDim

procedure VDim(var V: TIntVector; const Size: Integer; const DefaultValue: Integer = INT_VECTOR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64 = INT_VECTOR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TStrVector; const Size: Integer; const DefaultValue: String = STR_VECTOR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TDblVector; const Size: Integer; const DefaultValue: Double = DBL_VECTOR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TBoolVector; const Size: Integer; const DefaultValue: Boolean = BOOL_VECTOR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = COLOR_VECTOR_DEFAULT_VALUE);
var
  i: Integer;
begin
  V:= nil;
  SetLength(V,Size);
  for i:= 0 to Size-1 do
    V[i]:= DefaultValue;
end;


//VReDim

procedure VReDim(var V: TIntVector; const Size: Integer; const DefaultValue: Integer = INT_VECTOR_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TInt64Vector; const Size: Integer; const DefaultValue: Int64 = INT_VECTOR_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TStrVector; const Size: Integer; const DefaultValue: String = STR_VECTOR_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TDblVector; const Size: Integer; const DefaultValue: Double = DBL_VECTOR_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TBoolVector; const Size: Integer; const DefaultValue: Boolean = BOOL_VECTOR_DEFAULT_VALUE);
var
  i, OldSize: Integer;
begin
  OldSize:= Length(V);
  SetLength(V,Size);
  for i:= OldSize to Size-1 do
    V[i]:= DefaultValue;
end;

procedure VReDim(var V: TColorVector; const Size: Integer; const DefaultValue: TColor = COLOR_VECTOR_DEFAULT_VALUE);
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
  VIsNil:= Length(V)=0;
end;

function VIsNil(const V: TInt64Vector): Boolean;
begin
  VIsNil:= Length(V)=0;
end;

function VIsNil(const V: TStrVector): Boolean;
begin
  VIsNil:= Length(V)=0;
end;

function VIsNil(const V: TDblVector): Boolean;
begin
  VIsNil:= Length(V)=0;
end;

function VIsNil(const V: TBoolVector): Boolean;
begin
  VIsNil:= Length(V)=0;
end;

function VIsNil(const V: TColorVector): Boolean;
begin
  VIsNil:= Length(V)=0;
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

procedure VChangeIf(var V: TStrVector;   const IfValue, NewValue: String; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if V[i]=IfValue then V[i]:= NewValue;
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
  VFirst:= V[0];
end;

function VFirst(const V: TInt64Vector): Int64;
begin
  VFirst:= V[0];
end;

function VFirst(const V: TStrVector): String;
begin
  VFirst:= V[0];
end;

function VFirst(const V: TDblVector): Double;
begin
  VFirst:= V[0];
end;

function VFirst(const V: TBoolVector): Boolean;
begin
  VFirst:= V[0];
end;

function VFirst(const V: TColorVector): TColor;
begin
  VFirst:= V[0];
end;

//VLast

function VLast(const V: TIntVector): Integer;
begin
  VLast:= V[High(V)];
end;

function VLast(const V: TInt64Vector): Int64;
begin
  VLast:= V[High(V)];
end;

function VLast(const V: TStrVector): String;
begin
  VLast:= V[High(V)];
end;

function VLast(const V: TDblVector): Double;
begin
  VLast:= V[High(V)];
end;

function VLast(const V: TBoolVector): Boolean;
begin
  VLast:= V[High(V)];
end;

function VLast(const V: TColorVector): TColor;
begin
  VLast:= V[High(V)];
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
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(VCut, x+1);
  for i:= 0 to x do VCut[i]:= V[FromIndex+i];
end;

function VCut(const V: TInt64Vector; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Vector;
var
  i, x: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(VCut, x+1);
  for i:= 0 to x do VCut[i]:= V[FromIndex+i];
end;

function VCut(const V: TStrVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TStrVector;
var
  i, x: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(VCut, x+1);
  for i:= 0 to x do VCut[i]:= V[FromIndex+i];
end;

function VCut(const V: TDblVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TDblVector;
var
  i, x: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(VCut, x+1);
  for i:= 0 to x do VCut[i]:= V[FromIndex+i];
end;

function VCut(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolVector;
var
  i, x: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(VCut, x+1);
  for i:= 0 to x do VCut[i]:= V[FromIndex+i];
end;

function VCut(const V: TColorVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TColorVector;
var
  i, x: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  x:= ToIndex - FromIndex;
  VDim(VCut, x+1);
  for i:= 0 to x do VCut[i]:= V[FromIndex+i];
end;

function VCut(const V: TIntVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TIntVector;
var
  i: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(VCut, V[i]);
end;

function VCut(const V: TInt64Vector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TInt64Vector;
var
  i: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(VCut, V[i]);
end;

function VCut(const V: TStrVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TStrVector;
var
  i: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(VCut, V[i]);
end;

function VCut(const V: TDblVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TDblVector;
var
  i: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(VCut, V[i]);
end;

function VCut(const V: TBoolVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TBoolVector;
var
  i: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(VCut, V[i]);
end;

function VCut(const V: TColorVector; const Used: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): TColorVector;
var
  i: Integer;
begin
  VCut:= nil;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
    if Used[i] then VAppend(VCut, V[i]);
end;


//VAdd

function VAdd(const V1,V2: TIntVector): TIntVector;
begin
  VAdd:= nil;
  //копируем первый вектор в начало результирующего
  VCopy(V1, VAdd);
  //копируем второй вектор в результирующий после окончания первого вектора
  VCopy(V2, VAdd, Length(V1));
end;

function VAdd(const V1,V2: TInt64Vector): TInt64Vector;
begin
  VAdd:= nil;
  VCopy(V1, VAdd);
  VCopy(V2, VAdd, Length(V1));
end;

function VAdd(const V1,V2: TStrVector): TStrVector;
begin
  VAdd:= nil;
  VCopy(V1, VAdd);
  VCopy(V2, VAdd, Length(V1));
end;

function VAdd(const V1,V2: TDblVector): TDblVector;
begin
  VAdd:= nil;
  VCopy(V1, VAdd);
  VCopy(V2, VAdd, Length(V1));
end;

function VAdd(const V1,V2: TBoolVector): TBoolVector;
begin
  VAdd:= nil;
  VCopy(V1, VAdd);
  VCopy(V2, VAdd, Length(V1));
end;

function VAdd(const V1,V2: TColorVector): TColorVector;
begin
  VAdd:= nil;
  VCopy(V1, VAdd);
  VCopy(V2, VAdd, Length(V1));
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


//VIndexOf

function VIndexOf(const V: TIntVector; const FindValue: Integer): Integer;
var
  i: Integer;
begin
  VIndexOf:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      VIndexOf:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TInt64Vector; const FindValue: Int64): Integer;
var
  i: Integer;
begin
  VIndexOf:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      VIndexOf:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TStrVector; const FindValue: String): Integer;
var
  i: Integer;
begin
  VIndexOf:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      VIndexOf:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TDateVector; const FindValue: TDate): Integer;
var
  i: Integer;
begin
  VIndexOf:= -1;
  for i := 0 to High(V) do
  begin
    if CompareDate(V[i], FindValue)=0 then
    begin
      VIndexOf:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TBoolVector; const FindValue: Boolean): Integer;
var
  i: Integer;
begin
  VIndexOf:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      VIndexOf:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TColorVector; const FindValue: TColor):  Integer;
var
  i: Integer;
begin
  VIndexOf:= -1;
  for i := 0 to High(V) do
  begin
    if V[i]=FindValue then
    begin
      VIndexOf:= i;
      Exit;
    end;
  end;
end;

//VUnion

function VUnion(const V1,V2: TInt64Vector): TInt64Vector;
var
  i: Integer;
begin
  VUnion:= nil;
  if VIsNil(V1) and VIsNil(V2) then Exit;
  if (not VIsNil(V1)) and (not VIsNil(V2)) then
  begin
    VUnion:= VCut(V1);
    for i:=0 to High(V2) do
      if VIndexOf(V1, V2[i])<0 then
        VAppend(VUnion, V2[i]);
  end
  else begin
    if (not VIsNil(V1)) then
      VUnion:= VCut(V1)
    else
      VUnion:= VCut(V2);
  end;
end;

//VMin

function VMin(const V: TIntVector): Integer;
var
  i: Integer;
begin
  VMin:= V[0];
  for i:=1 to High(V) do
    if V[i]<VMin then VMin:= V[i];
end;

function VMin(const V: TInt64Vector): Int64;
var
  i: Integer;
begin
  VMin:= V[0];
  for i:=1 to High(V) do
    if V[i]<VMin then VMin:= V[i];
end;


function VMin(const V: TStrVector): String;
var
  i: Integer;
begin
  VMin:= V[0];
  for i:=1 to High(V) do
    if V[i]<VMin then VMin:= V[i];
end;

function VMin(const V: TDateVector): TDate;
var
  i: Integer;
begin
  VMin:= V[0];
  for i:=1 to High(V) do
    if V[i]<VMin then VMin:= V[i];
end;

//VMax

function VMax(const V: TIntVector): Integer;
var
  i: Integer;
begin
  VMax:= V[0];
  for i:=1 to High(V) do
    if V[i]>VMax then VMax:= V[i];
end;

function VMax(const V: TInt64Vector): Int64;
var
  i: Integer;
begin
  VMax:= V[0];
  for i:=1 to High(V) do
    if V[i]>VMax then VMax:= V[i];
end;

function VMax(const V: TStrVector): String;
var
  i: Integer;
begin
  VMax:= V[0];
  for i:=1 to High(V) do
    if V[i]>VMax then VMax:= V[i];
end;

function VMax(const V: TDateVector): TDate;
var
  i: Integer;
begin
  VMax:= V[0];
  for i:=1 to High(V) do
    if V[i]>VMax then VMax:= V[i];
end;

//VCountIf

function VCountIf(const V: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIf:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(VCountIf);
end;

function VCountIf(const V: TInt64Vector; const IfValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIf:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(VCountIf);
end;

function VCountIf(const V: TStrVector; const IfValue: String; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIf:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(VCountIf);
end;

function VCountIf(const V: TDateVector; const IfValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIf:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(VCountIf);
end;

function VCountIf(const V: TBoolVector; const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIf:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(VCountIf);
end;

function VCountIf(const V: TColorVector; const IfValue: TColor; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIf:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then Inc(VCountIf);
end;

//VCountIfNot

function VCountIfNot(const V: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIfNot:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(VCountIfNot);
end;

function VCountIfNot(const V: TInt64Vector; const IfValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIfNot:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(VCountIfNot);
end;

function VCountIfNot(const V: TStrVector; const IfValue: String; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIfNot:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(VCountIfNot);
end;

function VCountIfNot(const V: TDateVector; const IfValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIfNot:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(VCountIfNot);
end;

function VCountIfNot(const V: TBoolVector; const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIfNot:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(VCountIfNot);
end;

function VCountIfNot(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VCountIfNot:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then Inc(VCountIfNot);
end;


// для TIntVector

function VMult(const V1,V2: TIntVector): TIntVector;
var
  i: Integer;
begin
  VMult:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(VMult, Length(V1));
  for i := 0 to High(V1) do
    VMult[i]:= V1[i] * V2[i];
end;

function VMult(const V1,V2: TInt64Vector): TInt64Vector;
var
  i: Integer;
begin
  VMult:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(VMult, Length(V1));
  for i := 0 to High(V1) do
    VMult[i]:= V1[i] * V2[i];
end;

function VMult(const V1: TStrVector; const V2: TIntVector): TStrVector;
var
  i: Integer;
begin
  VMult:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(VMult, Length(V1));
  for i := 0 to High(V1) do
  begin
    if (V2[i]=0) then
      VMult[i]:= EmptyStr
    else
      VMult[i]:= V1[i];
  end;
end;

function VSum(const V: TIntVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSum:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    VSum:= VSum + V[i];
end;

function VSum(const V: TDblVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Double;
var
  i: Integer;
begin
  VSum:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    VSum:= VSum + V[i];
end;

function VSum(const V: TInt64Vector; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSum:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    VSum:= VSum + V[i];
end;

function VSum(const V1,V2: TStrVector): TStrVector;
var
  i: Integer;
begin
  VSum:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(VSum, Length(V1));
  for i := 0 to High(V1) do
    VSum[i]:= V1[i] + V2[i];
end;

function VSum(const V1,V2: TIntVector): TIntVector;
var
  i: Integer;
begin
  VSum:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(VSum, Length(V1));
  for i := 0 to High(V1) do
    VSum[i]:= V1[i] + V2[i];
end;

function VSum(const V1,V2: TInt64Vector): TInt64Vector;
var
  i: Integer;
begin
  VSum:= nil;
  if Length(V1)<>Length(V2) then Exit;
  VDim(VSum, Length(V1));
  for i := 0 to High(V1) do
    VSum[i]:= V1[i] + V2[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TIntVector; const IfValue: Integer;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TStrVector; const IfValue: String;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TDateVector; const IfValue: TDate;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TIntVector; const IfVector: TBoolVector; const IfValue: Boolean;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TIntVector; const IfValue: Integer;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TStrVector; const IfValue: String;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TDateVector; const IfValue: TDate;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;

function VSumIf(const V: TInt64Vector; const IfVector: TBoolVector; const IfValue: Boolean;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIf:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]=IfValue then VSumIf:= VSumIf + V[i];
end;



function VSumIfNot(const V: TIntVector; const IfVector: TIntVector; const IfValue: Integer;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;

function VSumIfNot(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;


function VSumIfNot(const V: TIntVector; const IfVector: TStrVector; const IfValue: String;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;

function VSumIfNot(const V: TIntVector; const IfVector: TDateVector; const IfValue: TDate;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TStrVector; const IfValue: String;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TDateVector; const IfValue: TDate;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  VSumIfNot:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then VSumIfNot:= VSumIfNot + V[i];
end;

{ПРЕОБРАЗОВНИЕ К СТРОКОВОМУ ВЕКТОРУ}
function VIntToStr(const V: TIntVector): TStrVector;
var
  i: Integer;
begin
  VIntToStr:= nil;
  if Length(V)>0 then
  begin
    VDim(VIntToStr, Length(V));
    for i:=0 to High(V) do
      VIntToStr[i]:= IntToStr(V[i]);
  end;
end;

function VIntToStr(const V: TInt64Vector): TStrVector;
var
  i: Integer;
begin
  VIntToStr:= nil;
  if Length(V)>0 then
  begin
    VDim(VIntToStr, Length(V));
    for i:=0 to High(V) do
      VIntToStr[i]:= IntToStr(V[i]);
  end;
end;

function VDateToStr(const V: TDateVector): TStrVector;
var
  i: Integer;
begin
  VDateToStr:= nil;
  if Length(V)>0 then
  begin
    VDim(VDateToStr, Length(V));
    for i:=0 to High(V) do
      VDateToStr[i]:= DateToStr(V[i]);
  end;
end;

function VBoolToStr(const V: TBoolVector): TStrVector;
var
  i: Integer;
begin
  VBoolToStr:= nil;
  if Length(V)>0 then
  begin
    VDim(VBoolToStr, Length(V));
    for i:=0 to High(V) do
      if V[i] then VBoolToStr[i]:= 'да' else VBoolToStr[i]:= 'нет';
  end;
end;

function VFloatToStr(const V: TDblVector): TStrVector;
var
  i: Integer;
begin
  VFloatToStr:= nil;
  if Length(V)>0 then
  begin
    VDim(VFloatToStr, Length(V));
    for i:=0 to High(V) do
      VFloatToStr[i]:= FloatToStr(V[i]);
  end;
end;

function VFormatDateTime(const FormatStr: String; const V: TDateVector; Options: TFormatDateTimeOptions = []): TStrVector;
var
  i: Integer;
begin
  VFormatDateTime:= nil;
  if Length(V)>0 then
  begin
    VDim(VFormatDateTime, Length(V));
    for i:=0 to High(V) do
      VFormatDateTime[i]:= FormatDateTime(FormatStr, V[i], Options);
  end;
end;

{ДЛЯ ВЕКТОРА ДАТ}

function VCrossInd(const V: TDateVector; const ABeginDate, AEndDate: TDate; out I1,I2: Integer): Boolean;
var
  BD, ED: TDate;
  n: Integer;
begin
  VCrossInd:= False;
  I1:= -1; I2:= -1;
  If Length(V)=0 then Exit;
  BD:=0; ED:=0;
  n:= High(V);
  if PeriodIntersect(V[0], V[n], ABeginDate, AEndDate, BD, ED) then
  begin
    I1:= VCountBefore(V, BD);
    I2:= n - VCountAfter(V, ED);
    VCrossInd:= True;
  end;
end;

function VCut(const V: TDateVector; const ABeginDate, AEndDate: TDate): TDateVector;
var
  I1, I2: Integer;
begin
  VCut:= nil;
  if VCrossInd(V, ABeginDate, AEndDate, I1, I2) then
    VCut:= VCut(V, I1, I2);
end;

function VCountIn(const V: TDateVector; const ABeginDate, AEndDate: TDate): Integer;
var
  I1, I2: Integer;
begin
  VCountIn:= 0;
  if VCrossInd(V, ABeginDate, AEndDate, I1, I2) then
    VCountIn:= I2 - I1 + 1;
end;

function VCountBefore(const V: TDateVector; const ADate: TDate): Integer;
var
  i: Integer;
begin
  VCountBefore:= 0;
  for i:= 0 to High(V) do
  begin
    if CompareDate(V[i], ADate)<0 then
      Inc(VCountBefore);
  end;
end;

function VCountAfter(const V: TDateVector; const ADate: TDate): Integer;
var
  i: Integer;
begin
  VCountAfter:= 0;
  for i:= 0 to High(V) do
  begin
    if CompareDate(V[i], ADate)>0 then
      Inc(VCountAfter);
  end;
end;

end.

