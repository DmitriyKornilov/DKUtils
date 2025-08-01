unit DK_Vector;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Graphics,
  DK_Const, DK_DateUtils, DK_StrUtils, DK_PriceUtils;

type
  TOrderType = (otNone, otAscending, otDescending);

  TIntVector   = array of Integer;
  TInt64Vector = array of Int64;
  TStrVector   = array of String;
  TDblVector   = array of Double;
  TDateVector  = type TDblVector;
  TTimeVector  = type TDblVector;
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
  function VCreateDate(const ABeginDate, AEndDate: TDate): TDateVector;
  function VCreateTime(const V: array of TTime): TTimeVector;
  function VCreateBool(const V: array of Boolean): TBoolVector;
  function VCreateColor(const V: array of TColor): TColorVector;

  {ЗАМЕНА НА НОВОЕ ЗНАЧЕНИЕ}
  procedure VChangeIn(var V: TIntVector;   const NewValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TInt64Vector; const NewValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TStrVector;   const NewValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TDblVector;   const NewValue: Double;  FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TBoolVector;  const NewValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIn(var V: TColorVector; const NewValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1);

  procedure VChangeIn(var V: TIntVector;   const NewValues: TIntVector; FromIndex, ToIndex: Integer);
  procedure VChangeIn(var V: TInt64Vector; const NewValues: TInt64Vector; FromIndex, ToIndex: Integer);
  procedure VChangeIn(var V: TStrVector;   const NewValues: TStrVector; FromIndex, ToIndex: Integer);
  procedure VChangeIn(var V: TDblVector;   const NewValues: TDblVector; FromIndex, ToIndex: Integer);
  procedure VChangeIn(var V: TBoolVector;  const NewValues: TBoolVector; FromIndex, ToIndex: Integer);
  procedure VChangeIn(var V: TColorVector; const NewValues: TColorVector; FromIndex, ToIndex: Integer);

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
  procedure VChangeIfDate(var V: TDateVector;  const IfValue, NewValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIfTime(var V: TTimeVector;  const IfValue, NewValue: TTime; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TBoolVector;  const IfValue, NewValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TColorVector; const IfValue, NewValue: TColor; FromIndex: Integer=-1; ToIndex: Integer=-1);

  procedure VChangeIf(var V: TIntVector; const NewValue: Integer;    const IfVector: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TInt64Vector; const NewValue: Int64;    const IfVector: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TStrVector; const NewValue: String;     const IfVector: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIfDate(var V: TDateVector; const NewValue: TDate; const IfVector: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIfTime(var V: TTimeVector; const NewValue: TTime; const IfVector: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TBoolVector; const NewValue: Boolean;   const IfVector: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);
  procedure VChangeIf(var V: TColorVector; const NewValue: TColor;   const IfVector: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1);


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
  procedure VIns(var V: TIntVector;   const Ind: Integer; const Value: Integer = VECTOR_INT_DEFAULT_VALUE);
  procedure VIns(var V: TInt64Vector; const Ind: Integer; const Value: Int64 = VECTOR_INT64_DEFAULT_VALUE);
  procedure VIns(var V: TStrVector;   const Ind: Integer; const Value: String = VECTOR_STR_DEFAULT_VALUE);
  procedure VIns(var V: TDblVector;   const Ind: Integer; const Value: Double = VECTOR_DBL_DEFAULT_VALUE);
  procedure VIns(var V: TBoolVector;  const Ind: Integer; const Value: Boolean = VECTOR_BOOL_DEFAULT_VALUE);
  procedure VIns(var V: TColorVector; const Ind: Integer; const Value: TColor = VECTOR_COLOR_DEFAULT_VALUE);

  procedure VIns(var V: TIntVector;   const Ind: Integer; const Source: TIntVector);
  procedure VIns(var V: TInt64Vector; const Ind: Integer; const Source: TInt64Vector);
  procedure VIns(var V: TStrVector;   const Ind: Integer; const Source: TStrVector);
  procedure VIns(var V: TDblVector;   const Ind: Integer; const Source: TDblVector);
  procedure VIns(var V: TBoolVector;  const Ind: Integer; const Source: TBoolVector);
  procedure VIns(var V: TColorVector; const Ind: Integer; const Source: TColorVector);

  {ВСТАВКА В УПОРЯДОЧЕННЫЙ ВЕКТОР}
  procedure VInsAsc(var V: TIntVector;   const Value: Integer);
  procedure VInsAsc(var V: TInt64Vector; const Value: Int64);
  procedure VInsAsc(var V: TStrVector;   const Value: String; const ACaseSensitivity: Boolean = True);
  procedure VInsAscDate(var V: TDateVector; const Value: TDate);
  procedure VInsAscTime(var V: TTimeVector; const Value: TTime);

  procedure VInsDesc(var V: TIntVector;   const Value: Integer);
  procedure VInsDesc(var V: TInt64Vector; const Value: Int64);
  procedure VInsDesc(var V: TStrVector;   const Value: String; const ACaseSensitivity: Boolean = True);
  procedure VInsDescDate(var V: TDateVector; const Value: TDate);
  procedure VInsDescTime(var V: TTimeVector; const Value: TTime);

  {ПОИСК ИНДЕКСА ЗНАЧЕНИЯ В ВЕКТОРЕ}
  function VIndexOf(const V: TIntVector;   const FindValue: Integer; const SkipIndex: Integer = -1): Integer;
  function VIndexOf(const V: TInt64Vector; const FindValue: Int64; const SkipIndex: Integer = -1):   Integer;
  function VIndexOf(const V: TStrVector;   const FindValue: String;
                    const ACaseSensitivity: Boolean = True; const SkipIndex: Integer = -1):  Integer;
  function VIndexOfDate(const V: TDateVector;  const FindValue: TDate; const SkipIndex: Integer = -1):   Integer;
  function VIndexOfTime(const V: TTimeVector;  const FindValue: TTime; const SkipIndex: Integer = -1):   Integer;
  function VIndexOf(const V: TBoolVector;  const FindValue: Boolean; const SkipIndex: Integer = -1): Integer;
  function VIndexOf(const V: TColorVector; const FindValue: TColor; const SkipIndex: Integer = -1):  Integer;

  function VIndexOf(const V1, V2: TIntVector; const FindValue1, FindValue2: Integer): Integer;

  {ПОИСК В ДИАПАЗОНЕ}
  function VIndexOf(const VMin, VMax: TIntVector; const FindValue: Integer): Integer;
  function VIndexOfDate(const VMin, VMax: TDateVector; const FindValue: TDate): Integer;

  {ПОЗИЦИЯ ДЛЯ ВСТАВКИ В УПОРЯДОЧЕННОМ ВЕКТОРЕ}
  function VIndexOfAsc(const V: TIntVector;   const InsValue: Integer): Integer;
  function VIndexOfAsc(const V: TInt64Vector; const InsValue: Int64):   Integer;
  function VIndexOfAsc(const V: TStrVector;   const InsValue: String;
                     const ACaseSensitivity: Boolean = True):  Integer;
  function VIndexOfAscDate(const V: TDateVector; const InsValue: TDate):    Integer;
  function VIndexOfAscTime(const V: TTimeVector; const InsValue: TTime):    Integer;

  function VIndexOfDesc(const V: TIntVector;   const InsValue: Integer): Integer;
  function VIndexOfDesc(const V: TInt64Vector; const InsValue: Int64):   Integer;
  function VIndexOfDesc(const V: TStrVector;   const InsValue: String;
                      const ACaseSensitivity: Boolean = True):  Integer;
  function VIndexOfDescDate(const V: TDateVector; const InsValue: TDate):    Integer;
  function VIndexOfDescTime(const V: TTimeVector; const InsValue: TTime):    Integer;

  {УНИКАЛЬНЫЕ ЗНАЧЕНИЯ}
  function VUnique(const V: TIntVector): TIntVector;
  function VUnique(const V: TInt64Vector): TInt64Vector;
  function VUnique(const V: TStrVector;
                   const ACaseSensitivity: Boolean = True): TStrVector;
  function VUniqueDate(const V: TDateVector): TDateVector;
  function VUniqueTime(const V: TTimeVector): TTimeVector;
  function VUnique(const V: TColorVector): TColorVector;

  {ПРОВЕРКА НА ОДИНАКОВЫЕ ЗНАЧЕНИЯ ВСЕХ ЭЛЕМЕНТОВ}
  function VSame(const V: TIntVector): Boolean;
  function VSame(const V: TInt64Vector): Boolean;
  function VSame(const V: TStrVector;
                   const ACaseSensitivity: Boolean = True): Boolean;
  function VSameDate(const V: TDateVector): Boolean;
  function VSameTime(const V: TTimeVector): Boolean;
  function VSame(const V: TColorVector): Boolean;

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
  function VMinDate(const V: TDateVector):  TDate;
  function VMinTime(const V: TTimeVector):  TTime;

  {НАИБОЛЬШЕЕ ЗНАЧЕНИЕ}
  function VMax(const V: TIntVector):   Integer;
  function VMax(const V: TInt64Vector): Int64;
  function VMax(const V: TStrVector;
                const ACaseSensitivity: Boolean = True):   String;
  function VMaxDate(const V: TDateVector):  TDate;
  function VMaxTime(const V: TTimeVector):  TTime;
  function VMaxWidth(const V: TStrVector; const AFont: TFont; const ADefaultValue: Integer = 0): Integer;
  function VMaxWidth(const V: TStrVector; const AFontName: String; const AFontSize: Single;
                     const AFontStyle: TFontStyles=[];
                     const ADefaultValue: Integer = 0): Integer;

                {КОЛ-ВО ЗНАЧЕНИЙ, РАВНЫХ ЗАДАННОМУ}
  function VCountIf(const V: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                    const ACaseSensitivity: Boolean = True): Integer;
  function VCountIfDate(const V: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfTime(const V: TTimeVector;  const IfValue: TTime;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIf(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;

  {КОЛ-ВО ЗНАЧЕНИЙ, НЕ РАВНЫХ ЗАДАННОМУ}
  function VCountIfNot(const V: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                       const ACaseSensitivity: Boolean = True): Integer;
  function VCountIfNotDate(const V: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNotTime(const V: TTimeVector;  const IfValue: TTime;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VCountIfNot(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;

  {ПРЕОБРАЗОВНИЕ ИЗ СТРОКОВОГО ВЕКТОРА}
  function VStrToInt(const V: TStrVector): TIntVector;
  function VStrToInt64(const V: TStrVector): TInt64Vector;
  function VStrToDate(const V: TStrVector): TDateVector;
  function VStrToTime(const V: TStrVector): TTimeVector;

  {BOOLEAN}
  function VIntToBool(const V: TIntVector): TBoolVector;
  function VBoolToInt(const V: TBoolVector): TIntVector;

  {ПРЕОБРАЗОВНИЕ К СТРОКОВОМУ ВЕКТОРУ}
  function VIntToStr(const V: TIntVector; const ZeroIsEmpty: Boolean = False): TStrVector;
  function VIntToStr(const V: TInt64Vector; const ZeroIsEmpty: Boolean = False): TStrVector;
  function VBoolToStr(const V: TBoolVector; const StrTrue: String = STR_TRUE; const StrFalse: String = STR_False): TStrVector;
  function VFloatToStr(const V: TDblVector): TStrVector;
  function VDateToStr(const V: TDateVector; const BoundaryIsEmpty: Boolean = False): TStrVector;
  function VTimeToStr(const V: TTimeVector): TStrVector;
  function VFormatDateTime(const FormatStr: String; const V: TDblVector;
                           const BoundaryIsEmpty: Boolean = False;
                           Options: TFormatDateTimeOptions = []): TStrVector;
  function VFormat(const FormatStr: String; const V: TIntVector): TStrVector;
  function VFormat(const FormatStr: String; const V: TInt64Vector): TStrVector;
  function VFormat(const FormatStr: String; const V: TDblVector): TStrVector;
  function VFormat(const FormatStr: String; const V: TStrVector): TStrVector;
  function VTrim(const V: TStrVector): TStrVector;
  function VSymbolFromUnicode(const ACodes: TIntVector): TStrVector;
  function VSymbolToUnicode(const ASymbols: TStrVector): TIntVector;
  function VSymbolsFromString(const AString: String): TStrVector;

  {СТРОКОВЫЙ ВЕКТОР И СПИСОК}
  function VFromStrings(const S: TStrings): TStrVector;
  procedure VToStrings(const V: TStrVector; const S: TStrings);

  {СТРОКОВЫЙ ВЕКТОР И СТРОКА}
  function VStrToVector(const Str, Delimiter: String; const ACaseSensitivity: Boolean = True): TStrVector;
  function VVectorToStr(const V: TStrVector;
                        const Delimiter: String;
                        const Prefix: String = '';
                        const PostFix: String = ''): String;
  function VStringReplace(const V: TStrVector; const OldString, NewString: String;
                          const ACaseSensitivity: Boolean = True;
                          const AMaxReplaceCount: Integer = 0 {replace all}): TStrVector;

  {ВЕКТОР ЧИСЕЛ ИЗ СТРОКИ}
  function VStrToNumbers(const Str: String): TIntVector;

  {PRICE}
  function VPriceStrToInt(const APrices: TStrVector): TInt64Vector;
  function VPriceIntToStr(const APrices: TInt64Vector;
                          const ANeedThousandSeparator: Boolean = False;
                          const AEmptyIfZero: Boolean = False): TStrVector;

  {COLOR}
  function VColorFromVector(const AColorVector: TColorVector; const AIndex: Integer;
                            const ASortIndexes: TIntVector = nil): TColor;


  {СУММА/КОНКАТЕНАЦИЯ}
  function VSum(const V: TStrVector; const S: String): TStrVector;
  function VSum(const S: String; const V: TStrVector): TStrVector;

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
  function VSumIfDate(const V: TIntVector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfTime(const V: TIntVector; const IfVector: TTimeVector; const IfValue: TTime;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TIntVector; const IfVector: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIf(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                  const ACaseSensitivity: Boolean = True): Int64;
  function VSumIfDate(const V: TInt64Vector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfTime(const V: TInt64Vector; const IfVector: TTimeVector;  const IfValue: TTime;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIf(const V: TInt64Vector; const IfVector: TBoolVector;  const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;

  function VSumIfNot(const V: TIntVector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TIntVector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                     const ACaseSensitivity: Boolean = True): Integer;
  function VSumIfNotDate(const V: TIntVector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNotTime(const V: TIntVector; const IfVector: TTimeVector;  const IfValue: TTime;   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TInt64Vector; const IfValue: Int64;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNot(const V: TInt64Vector; const IfVector: TStrVector;   const IfValue: String;  FromIndex: Integer=-1; ToIndex: Integer=-1;
                     const ACaseSensitivity: Boolean = True): Int64;
  function VSumIfNotDate(const V: TInt64Vector; const IfVector: TDateVector;  const IfValue: TDate;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
  function VSumIfNotTime(const V: TInt64Vector; const IfVector: TTimeVector;  const IfValue: TTime;   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;

  function VMult(const V1,V2: TIntVector): TIntVector;
  function VMult(const V1,V2: TInt64Vector): TInt64Vector;
  function VMult(const V1: TStrVector; const V2: TIntVector): TStrVector;

  {ДЛЯ ЦЕЛОЧИСЛЕННОГО ВЕКТОРА}
  function VOrder(const MaxValue: Integer;
                  const AZeroFirst: Boolean = False): TIntVector; //{[0],1,2,3,...,MaxValue}
  function VRange(const AFirstValue, ALastValue: Integer): TIntVector; // {AFirstValue, AFirstValue+1, ..., ALastValue}

  {ДЛЯ УПОРЯДОЧЕННОГО ВЕКТОРА ДАТ}
  function VCrossInd(const V: TDateVector; const ABeginDate, AEndDate: TDate; out I1,I2: Integer): Boolean;
  function VCut(const V: TDateVector; const ABeginDate, AEndDate: TDate): TDateVector;
  function VCountIn(const V: TDateVector; const ABeginDate, AEndDate: TDate): Integer;
  function VCountBefore(const V: TDateVector; const ADate: TDate): Integer;
  function VCountAfter(const V: TDateVector; const ADate: TDate): Integer;
  procedure VDel(var V: TDateVector; const ADate: TDate);

  {ОБРАЩЕНИЕ ПОРЯДКА ЭЛЕМЕНТОВ}
  function VReverse(const V: TIntVector): TIntVector;
  function VReverse(const V: TInt64Vector): TInt64Vector;
  function VReverse(const V: TDblVector): TDblVector;
  function VReverse(const V: TStrVector): TStrVector;

  {СОРТИРОВКА}
  procedure VSort(const V: TStrVector; out Indexes: TIntVector; const Desc: Boolean = False);
  procedure VSort(const V: TIntVector; out Indexes: TIntVector; const Desc: Boolean = False);
  procedure VSort(const V: TInt64Vector; out Indexes: TIntVector; const Desc: Boolean = False);
  procedure VSortDate(const V: TDateVector; out Indexes: TIntVector;  const Desc: Boolean = False);
  procedure VSortTime(const V: TTimeVector; out Indexes: TIntVector;  const Desc: Boolean = False);
  function VSort(const V: TStrVector; const Desc: Boolean = False): TStrVector;
  function VSort(const V: TIntVector; const Desc: Boolean = False): TIntVector;
  function VSort(const V: TInt64Vector; const Desc: Boolean = False): TInt64Vector;
  function VSortDate(const V: TDateVector; const Desc: Boolean = False): TDateVector;
  function VSortTime(const V: TTimeVector; const Desc: Boolean = False): TTimeVector;

  {ПЕРЕСТАНОВКА ПО ВЕКТОРУ ИНДЕКСОВ}
  function VReplace(const V: TStrVector; const Indexes: TIntVector): TStrVector;
  function VReplace(const V: TIntVector; const Indexes: TIntVector): TIntVector;
  function VReplace(const V: TInt64Vector; const Indexes: TIntVector): TInt64Vector;
  function VReplace(const V: TDblVector; const Indexes: TIntVector): TDblVector;
  function VReplace(const V: TBoolVector; const Indexes: TIntVector): TBoolVector;

  {ПРОВЕРКА И КОРРЕКТИРОВКА ИНДЕКСОВ}
  function CheckFromToIndexes(MaxIndex: Integer; var FromIndex, ToIndex: Integer): Boolean;
  function CheckIndex(const MaxIndex, Ind: Integer): Boolean;
  function CheckIndexes(const MaxIndex, Ind1, Ind2: Integer): Boolean;

  function VIsTrue(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
  function VIsFalse(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
  function VIsAllTrue(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
  function VIsAllFalse(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;

  {ВЕКТОРЫ ИМЕН}
  function VNameLong(const AFs, ANs, APs: TStrVector): TStrVector;
  function VNameShort(const AFs, ANs, APs: TStrVector): TStrVector;

  function VSameIndexValue(const FindValue: Integer; const SearchVector: TIntVector; const SourceVector: TIntVector; out Value: Integer): Boolean;
  function VSameIndexValue(const FindValue: Integer; const SearchVector: TIntVector; const SourceVector: TInt64Vector; out Value: Int64): Boolean;
  function VSameIndexValue(const FindValue: Int64; const SearchVector: TInt64Vector; const SourceVector: TIntVector; out Value: Integer): Boolean;
  function VSameIndexValue(const FindValue: Int64; const SearchVector: TInt64Vector; const SourceVector: TInt64Vector; out Value: Int64): Boolean;
  function VSameIndexValue(const FindValue: String; const SearchVector: TStrVector; const SourceVector: TIntVector; out Value: Integer;
                           const ACaseSensitivity: Boolean = False): Boolean;
  function VSameIndexValue(const FindValue: String; const SearchVector: TStrVector; const SourceVector: TInt64Vector; out Value: Int64;
                           const ACaseSensitivity: Boolean = False): Boolean;


  {ЗАМЕНА КЛЮЧЕЙ НА ЗНАЧЕНИЕ}
  function VPickFromKey(const Values: TIntVector; const Keys: TIntVector; const Picks: TIntVector): TIntVector;
  function VPickFromKey(const Values: TIntVector; const Keys: TIntVector; const Picks: TStrVector): TStrVector;
  function VPickFromKey(const Values: TInt64Vector; const Keys: TInt64Vector; const Picks: TStrVector): TStrVector;

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

function VIsIncludes(const V: TBoolVector; const AValue: Boolean;
                     FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
var
  i: Integer;
begin
  Result:= False;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:= FromIndex to ToIndex do
  begin
    if V[i]=AValue then
    begin
      Result:= True;
      break;
    end;
  end;
end;

function VIsTrue(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
begin
  Result:= VIsIncludes(V, True, FromIndex, ToIndex);
end;

function VIsFalse(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
begin
  Result:= VIsIncludes(V, False, FromIndex, ToIndex);
end;

function VIsAllTrue(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
begin
  Result:= not VIsFalse(V, FromIndex, ToIndex);
end;

function VIsAllFalse(const V: TBoolVector; FromIndex: Integer=-1; ToIndex: Integer=-1): Boolean;
begin
  Result:= not VIsTrue(V, FromIndex, ToIndex);
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

function VCreateDate(const ABeginDate, AEndDate: TDate): TDateVector;
var
  i, n: Integer;
begin
  Result:= nil;
  n:= DaysBetweenDates(ABeginDate, AEndDate);
  for i:= 0 to n do
    VAppend(Result, IncDay(ABeginDate, i));
end;

function VCreateTime(const V: array of TTime): TTimeVector;
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

procedure VChangeIn(var V: TIntVector; const NewValues: TIntVector; FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  if Length(NewValues)<>(ToIndex-FromIndex+1) then Exit;
  for i:= FromIndex to ToIndex do V[i]:= NewValues[i-FromIndex];
end;

procedure VChangeIn(var V: TInt64Vector; const NewValues: TInt64Vector; FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  if Length(NewValues)<>(ToIndex-FromIndex+1) then Exit;
  for i:= FromIndex to ToIndex do V[i]:= NewValues[i-FromIndex];
end;

procedure VChangeIn(var V: TStrVector; const NewValues: TStrVector; FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  if Length(NewValues)<>(ToIndex-FromIndex+1) then Exit;
  for i:= FromIndex to ToIndex do V[i]:= NewValues[i-FromIndex];
end;

procedure VChangeIn(var V: TDblVector; const NewValues: TDblVector; FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  if Length(NewValues)<>(ToIndex-FromIndex+1) then Exit;
  for i:= FromIndex to ToIndex do V[i]:= NewValues[i-FromIndex];
end;

procedure VChangeIn(var V: TBoolVector;  const NewValues: TBoolVector; FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  if Length(NewValues)<>(ToIndex-FromIndex+1) then Exit;
  for i:= FromIndex to ToIndex do V[i]:= NewValues[i-FromIndex];
end;

procedure VChangeIn(var V: TColorVector; const NewValues: TColorVector; FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  if Length(NewValues)<>(ToIndex-FromIndex+1) then Exit;
  for i:= FromIndex to ToIndex do V[i]:= NewValues[i-FromIndex];
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

procedure VChangeIfDate(var V: TDateVector;  const IfValue, NewValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if SameDate(V[i],IfValue) then V[i]:= NewValue;
end;

procedure VChangeIfTime(var V: TTimeVector; const IfValue, NewValue: TTime; FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if SameTime(V[i],IfValue) then V[i]:= NewValue;
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

procedure VChangeIf(var V: TIntVector; const NewValue: Integer;
                    const IfVector: TIntVector; const IfValue: Integer;
                    FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if Length(V)<>Length(IfVector) then Exit;
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if IfVector[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TInt64Vector; const NewValue: Int64;
                    const IfVector: TIntVector; const IfValue: Integer;
                    FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if Length(V)<>Length(IfVector) then Exit;
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if IfVector[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TStrVector; const NewValue: String;
                    const IfVector: TIntVector; const IfValue: Integer;
                    FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if Length(V)<>Length(IfVector) then Exit;
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if IfVector[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIfDate(var V: TDateVector; const NewValue: TDate;
                        const IfVector: TIntVector; const IfValue: Integer;
                        FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if Length(V)<>Length(IfVector) then Exit;
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if IfVector[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIfTime(var V: TTimeVector; const NewValue: TTime;
                        const IfVector: TIntVector; const IfValue: Integer;
                        FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if Length(V)<>Length(IfVector) then Exit;
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if IfVector[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TBoolVector; const NewValue: Boolean;
                    const IfVector: TIntVector; const IfValue: Integer;
                    FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if Length(V)<>Length(IfVector) then Exit;
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if IfVector[i]=IfValue then V[i]:= NewValue;
end;

procedure VChangeIf(var V: TColorVector; const NewValue: TColor;
                    const IfVector: TIntVector; const IfValue: Integer;
                    FromIndex: Integer; ToIndex: Integer);
var
  i: Integer;
begin
  if Length(V)<>Length(IfVector) then Exit;
  if CheckFromToIndexes(High(V), FromIndex, ToIndex) then
    for i:= FromIndex to ToIndex do
      if IfVector[i]=IfValue then V[i]:= NewValue;
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
  V1, V2: TDblVector;
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

//VInsAsc

procedure VInsAsc(var V: TIntVector; const Value: Integer);
begin
  VIns(V, VIndexOfAsc(V, Value), Value);
end;

procedure VInsAsc(var V: TInt64Vector; const Value: Int64);
begin
  VIns(V, VIndexOfAsc(V, Value), Value);
end;

procedure VInsAsc(var V: TStrVector; const Value: String; const ACaseSensitivity: Boolean = True);
begin
  VIns(V, VIndexOfAsc(V, Value, ACaseSensitivity), Value);
end;

procedure VInsAscDate(var V: TDateVector; const Value: TDate);
begin
  VIns(V, VIndexOfAscDate(V, Value), Value);
end;

procedure VInsAscTime(var V: TTimeVector; const Value: TTime);
begin
  VIns(V, VIndexOfAscTime(V, Value), Value);
end;

//VInsDesc

procedure VInsDesc(var V: TIntVector; const Value: Integer);
begin
  VIns(V, VIndexOfDesc(V, Value), Value);
end;

procedure VInsDesc(var V: TInt64Vector; const Value: Int64);
begin
  VIns(V, VIndexOfDesc(V, Value), Value);
end;

procedure VInsDesc(var V: TStrVector; const Value: String; const ACaseSensitivity: Boolean = True);
begin
  VIns(V, VIndexOfDesc(V, Value, ACaseSensitivity), Value);
end;

procedure VInsDescDate(var V: TDateVector; const Value: TDate);
begin
  VIns(V, VIndexOfDescDate(V, Value), Value);
end;

procedure VInsDescTime(var V: TTimeVector; const Value: TTime);
begin
  VIns(V, VIndexOfDescTime(V, Value), Value);
end;

//VIndexOf

function VIndexOf(const V: TIntVector; const FindValue: Integer; const SkipIndex: Integer = -1): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if (V[i]=FindValue) and (i<>SkipIndex) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TInt64Vector; const FindValue: Int64; const SkipIndex: Integer = -1): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if (V[i]=FindValue) and (i<>SkipIndex) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TStrVector; const FindValue: String;
                  const ACaseSensitivity: Boolean = True; const SkipIndex: Integer = -1): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if SSame(V[i], FindValue, ACaseSensitivity) and (i<>SkipIndex) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfDate(const V: TDateVector; const FindValue: TDate; const SkipIndex: Integer = -1): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if SameDate(V[i], FindValue) and (i<>SkipIndex) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfTime(const V: TTimeVector; const FindValue: TTime; const SkipIndex: Integer = -1): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if SameTime(V[i], FindValue) and (i<>SkipIndex) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TBoolVector; const FindValue: Boolean; const SkipIndex: Integer = -1): Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if (V[i]=FindValue) and (i<>SkipIndex) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V: TColorVector; const FindValue: TColor; const SkipIndex: Integer = -1):  Integer;
var
  i: Integer;
begin
  Result:= -1;
  for i := 0 to High(V) do
  begin
    if (V[i]=FindValue) and (i<>SkipIndex) then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOf(const V1, V2: TIntVector; const FindValue1, FindValue2: Integer): Integer;
var
  i: Integer;
begin
  Result:= -1;
  if Length(V1)<>Length(V2) then Exit;
  for i:= 0 to High(V1) do
  begin
    if (V1[i]=FindValue1) and (V2[i]=FindValue2) then
    begin
      Result:= i;
      break;
    end;
  end;
end;

function VIndexOf(const VMin, VMax: TIntVector; const FindValue: Integer): Integer;
var
  i: Integer;
begin
  Result:= -1;
  if Length(VMin)<>Length(VMax) then Exit;
  for i:= 0 to High(VMin) do
  begin
    if (FindValue>=VMin[i]) and
       (FindValue<=VMax[i]) then
    begin
      Result:= i;
      break;
    end;
  end;
end;

function VIndexOfDate(const VMin, VMax: TDateVector; const FindValue: TDate): Integer;
var
  i: Integer;
begin
  Result:= -1;
  if Length(VMin)<>Length(VMax) then Exit;
  for i:= 0 to High(VMin) do
  begin
    if (CompareDate(FindValue, VMin[i])>=0) and
       (CompareDate(FindValue, VMax[i])<=0) then
    begin
      Result:= i;
      break;
    end;
  end;
end;

//VIndexOfAsc

function VIndexOfAsc(const V: TIntVector;   const InsValue: Integer): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  if InsValue<V[0] then Exit;
  if InsValue>=V[High(V)] then
  begin
    Result:= High(V)+1;
    Exit;
  end;
  for i:= 1 to High(V) do
  begin
    if InsValue<V[i] then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfAsc(const V: TInt64Vector; const InsValue: Int64):   Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  if InsValue<V[0] then Exit;
  if InsValue>=V[High(V)] then
  begin
    Result:= High(V)+1;
    Exit;
  end;
  for i:= 1 to High(V) do
  begin
    if InsValue<V[i] then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfAsc(const V: TStrVector;   const InsValue: String;
                   const ACaseSensitivity: Boolean = True):  Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;

  if SCompare(InsValue, V[0], ACaseSensitivity)<0 then Exit;

  if SCompare(InsValue, V[High(V)], ACaseSensitivity)>=0 then
  begin
    Result:= High(V)+1;
    Exit;
  end;

  for i:= 1 to High(V) do
  begin
    if SCompare(InsValue, V[i], ACaseSensitivity)<0 then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfAscDate(const V: TDateVector; const InsValue: TDate):   Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;

  if CompareDate(InsValue, V[0])<0 then Exit;

  if CompareDate(InsValue, V[High(V)])>=0 then
  begin
    Result:= High(V)+1;
    Exit;
  end;

  for i:= 1 to High(V) do
  begin
    if CompareDate(InsValue, V[i])<0 then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfAscTime(const V: TTimeVector; const InsValue: TTime): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;

  if CompareTime(InsValue, V[0])<0 then Exit;

  if CompareTime(InsValue, V[High(V)])>=0 then
  begin
    Result:= High(V)+1;
    Exit;
  end;

  for i:= 1 to High(V) do
  begin
    if CompareTime(InsValue, V[i])<0 then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

//VIndexOfDesc

function VIndexOfDesc(const V: TIntVector;   const InsValue: Integer): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  if InsValue>V[0] then Exit;
  if InsValue<=V[High(V)] then
  begin
    Result:= High(V)+1;
    Exit;
  end;
  for i:= 1 to High(V) do
  begin
    if InsValue>V[i] then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfDesc(const V: TInt64Vector; const InsValue: Int64):   Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  if InsValue>V[0] then Exit;
  if InsValue<=V[High(V)] then
  begin
    Result:= High(V)+1;
    Exit;
  end;
  for i:= 1 to High(V) do
  begin
    if InsValue>V[i] then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfDesc(const V: TStrVector;   const InsValue: String;
                    const ACaseSensitivity: Boolean = True):  Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;

  if SCompare(InsValue, V[0], ACaseSensitivity)>0 then Exit;

  if SCompare(InsValue, V[High(V)], ACaseSensitivity)<=0 then
  begin
    Result:= High(V)+1;
    Exit;
  end;

  for i:= 1 to High(V) do
  begin
    if SCompare(InsValue, V[i], ACaseSensitivity)>0 then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfDescDate(const V: TDateVector; const InsValue: TDate): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;

  if CompareDate(InsValue, V[0])>0 then Exit;

  if CompareDate(InsValue, V[High(V)])<=0 then
  begin
    Result:= High(V)+1;
    Exit;
  end;

  for i:= 1 to High(V) do
  begin
    if CompareDate(InsValue, V[i])>0 then
    begin
      Result:= i;
      Exit;
    end;
  end;
end;

function VIndexOfDescTime(const V: TTimeVector; const InsValue: TTime): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;

  if CompareTime(InsValue, V[0])>0 then Exit;

  if CompareTime(InsValue, V[High(V)])<=0 then
  begin
    Result:= High(V)+1;
    Exit;
  end;

  for i:= 1 to High(V) do
  begin
    if CompareTime(InsValue, V[i])>0 then
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

function VUniqueDate(const V: TDateVector): TDateVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
  begin
    if VIndexOfDate(Result, V[i])=-1 then
      VAppend(Result, V[i]);
  end;
end;

function VUniqueTime(const V: TTimeVector): TTimeVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(V) do
  begin
    if VIndexOfTime(Result, V[i])=-1 then
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

//Same

function VSame(const V: TIntVector): Boolean;
var
  i: Integer;
begin
  Result:= True;
  if Length(V)<=1 then Exit;
  for i:= 1 to High(V) do
  begin
    if V[i]<>V[0] then
    begin
      Result:= False;
      Exit;
    end;
  end;
end;

function VSame(const V: TInt64Vector): Boolean;
var
  i: Integer;
begin
  Result:= True;
  if Length(V)<=1 then Exit;
  for i:= 1 to High(V) do
  begin
    if V[i]<>V[0] then
    begin
      Result:= False;
      Exit;
    end;
  end;
end;

function VSame(const V: TStrVector; const ACaseSensitivity: Boolean): Boolean;
var
  i: Integer;
begin
  Result:= True;
  if Length(V)<=1 then Exit;
  for i:= 1 to High(V) do
  begin
    if not SSame(V[i], V[0], ACaseSensitivity) then
    begin
      Result:= False;
      Exit;
    end;
  end;
end;

function VSameDate(const V: TDateVector): Boolean;
var
  i: Integer;
begin
  Result:= True;
  if Length(V)<=1 then Exit;
  for i:= 1 to High(V) do
  begin
    if not SameDate(V[i], V[0]) then
    begin
      Result:= False;
      Exit;
    end;
  end;
end;

function VSameTime(const V: TTimeVector): Boolean;
var
  i: Integer;
begin
  Result:= True;
  if Length(V)<=1 then Exit;
  for i:= 1 to High(V) do
  begin
    if not SameTime(V[i], V[0]) then
    begin
      Result:= False;
      Exit;
    end;
  end;
end;

function VSame(const V: TColorVector): Boolean;
var
  i: Integer;
begin
  Result:= True;
  if Length(V)<=1 then Exit;
  for i:= 1 to High(V) do
  begin
    if V[i]<>V[0] then
    begin
      Result:= False;
      Exit;
    end;
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
      if VIndexOfDate(V1, V2[i])<0 then
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
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]<Result then
      Result:= V[i];
end;

function VMin(const V: TInt64Vector): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]<Result then
      Result:= V[i];
end;


function VMin(const V: TStrVector; const ACaseSensitivity: Boolean = True): String;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= EmptyStr;
  if VIsNil(V) then Exit;
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

function VMinDate(const V: TDateVector): TDate;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if CompareDate(V[i], Result)<0 then
      Result:= V[i];
end;

function VMinTime(const V: TTimeVector): TTime;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if CompareTime(V[i], Result)<0 then
      Result:= V[i];
end;

//VMax

function VMax(const V: TIntVector): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]>Result then
      Result:= V[i];
end;

function VMax(const V: TInt64Vector): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if V[i]>Result then
      Result:= V[i];
end;

function VMax(const V: TStrVector; const ACaseSensitivity: Boolean = True): String;
var
  i: Integer;
  S1, S2: String;
begin
  Result:= EmptyStr;
  if VIsNil(V) then Exit;
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

function VMaxDate(const V: TDateVector): TDate;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if CompareDate(V[i], Result)>0 then
      Result:= V[i];
end;

function VMaxTime(const V: TTimeVector): TTime;
var
  i: Integer;
begin
  Result:= 0;
  if VIsNil(V) then Exit;
  Result:= V[0];
  for i:=1 to High(V) do
    if CompareTime(V[i], Result)>0 then
      Result:= V[i];
end;

function VMaxWidth(const V: TStrVector; const AFont: TFont; const ADefaultValue: Integer = 0): Integer;
var
  i, w: Integer;
begin
  Result:= ADefaultValue;
  for i:= 0 to High(V) do
  begin
    w:= SWidth(V[i], AFont);
    if w>Result then
      Result:= w;
  end;
end;

function VMaxWidth(const V: TStrVector; const AFontName: String; const AFontSize: Single;
                     const AFontStyle: TFontStyles=[];
                     const ADefaultValue: Integer = 0): Integer;
var
  F: TFont;
begin
  F:= SFont(AFontName, AFontSize, AFontStyle);
  try
    Result:= VMaxWidth(V, F, ADefaultValue);
  finally
    FreeAndNil(F);
  end;
end;

//VCountIf

function VCountIf(const V: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then
      Inc(Result);
end;

function VCountIf(const V: TInt64Vector; const IfValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then
      Inc(Result);
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

function VCountIfDate(const V: TDateVector; const IfValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if SameDate(V[i], IfValue) then
      Inc(Result);
end;

function VCountIfTime(const V: TTimeVector; const IfValue: TTime; FromIndex: Integer; ToIndex: Integer): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if SameTime(V[i], IfValue) then
      Inc(Result);
end;

function VCountIf(const V: TBoolVector; const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then
      Inc(Result);
end;

function VCountIf(const V: TColorVector; const IfValue: TColor; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]=IfValue then
      Inc(Result);
end;

//VCountIfNot

function VCountIfNot(const V: TIntVector; const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then
      Inc(Result);
end;

function VCountIfNot(const V: TInt64Vector; const IfValue: Int64; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then
      Inc(Result);
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

function VCountIfNotDate(const V: TDateVector; const IfValue: TDate; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if not SameDate(V[i], IfValue) then
      Inc(Result);
end;

function VCountIfNotTime(const V: TTimeVector; const IfValue: TTime; FromIndex: Integer; ToIndex: Integer): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if not SameTime(V[i], IfValue) then
      Inc(Result);
end;

function VCountIfNot(const V: TBoolVector; const IfValue: Boolean; FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then
      Inc(Result);
end;

function VCountIfNot(const V: TColorVector; const IfValue: TColor;  FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i := FromIndex to ToIndex do
    if V[i]<>IfValue then
      Inc(Result);
end;


//VOrder

function VOrder(const MaxValue: Integer; const AZeroFirst: Boolean = False): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  VDim(Result, MaxValue + Ord(AZeroFirst));
  for i:= 0 to High(Result) do
    Result[i]:= i + Ord(not AZeroFirst);
end;

//VRange

function VRange(const AFirstValue, ALastValue: Integer): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  if ALastValue<AFirstValue then Exit;
  VDim(Result, ALastValue-AFirstValue+1);
  for i:= AFirstValue to ALastValue do
    Result[i-AFirstValue]:= i;
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

function VSum(const V: TStrVector; const S: String): TStrVector;
var
  Values: TStrVector;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Values{%H-}, Length(V), S);
  Result:= VSum(V, Values);
end;

function VSum(const S: String; const V: TStrVector): TStrVector;
var
  Values: TStrVector;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Values{%H-}, Length(V), S);
  Result:= VSum(Values, V);
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
    if IfVector[i]=IfValue then
      Result:= Result + V[i];
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
    if IfVector[i]=IfValue then
      Result:= Result + V[i];
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

function VSumIfDate(const V: TIntVector; const IfVector: TDateVector; const IfValue: TDate;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if SameDate(IfVector[i], IfValue) then
      Result:= Result + V[i];
end;

function VSumIfTime(const V: TIntVector; const IfVector: TTimeVector; const IfValue: TTime;
                FromIndex: Integer; ToIndex: Integer): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if SameTime(IfVector[i], IfValue) then
      Result:= Result + V[i];
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
    if IfVector[i]=IfValue then
      Result:= Result + V[i];
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
    if IfVector[i]=IfValue then
      Result:= Result + V[i];
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
    if IfVector[i]=IfValue then
      Result:= Result + V[i];
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

function VSumIfDate(const V: TInt64Vector; const IfVector: TDateVector; const IfValue: TDate;
                FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if SameDate(IfVector[i], IfValue) then
      Result:= Result + V[i];
end;

function VSumIfTime(const V: TInt64Vector; const IfVector: TTimeVector;
  const IfValue: TTime; FromIndex: Integer; ToIndex: Integer): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if SameTime(IfVector[i], IfValue) then
      Result:= Result + V[i];
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
    if IfVector[i]=IfValue then
      Result:= Result + V[i];
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
    if IfVector[i]<>IfValue then
      Result:= Result + V[i];
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
    if IfVector[i]<>IfValue then
      Result:= Result + V[i];
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

function VSumIfNotDate(const V: TIntVector; const IfVector: TDateVector; const IfValue: TDate;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if not SameDate(IfVector[i], IfValue) then
      Result:= Result + V[i];
end;

function VSumIfNotTime(const V: TIntVector; const IfVector: TTimeVector; const IfValue: TTime;
                   FromIndex: Integer; ToIndex: Integer): Integer;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if not SameTime(IfVector[i], IfValue) then
      Result:= Result + V[i];
end;

function VSumIfNot(const V: TInt64Vector; const IfVector: TIntVector;   const IfValue: Integer; FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if IfVector[i]<>IfValue then
      Result:= Result + V[i];
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
    if IfVector[i]<>IfValue then
      Result:= Result + V[i];
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

function VSumIfNotDate(const V: TInt64Vector; const IfVector: TDateVector; const IfValue: TDate;
                   FromIndex: Integer=-1; ToIndex: Integer=-1): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if not SameDate(IfVector[i], IfValue) then
      Result:= Result + V[i];
end;

function VSumIfNotTime(const V: TInt64Vector; const IfVector: TTimeVector;
  const IfValue: TTime; FromIndex: Integer; ToIndex: Integer): Int64;
var
  i: Integer;
begin
  Result:= 0;
  if Length(V)<>Length(IfVector) then Exit;
  if not CheckFromToIndexes(High(V), FromIndex, ToIndex) then Exit;
  for i:=FromIndex to ToIndex do
    if not SameTime(IfVector[i], IfValue) then
      Result:= Result + V[i];
end;

//VStrToXXX

function VStrToInt(const V: TStrVector): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not SEmpty(V[i]) then
      Result[i]:= StrToInt(V[i]);
end;

function VStrToInt64(const V: TStrVector): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not SEmpty(V[i]) then
      Result[i]:= StrToInt64(V[i]);
end;

function VStrToDate(const V: TStrVector): TDateVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not SEmpty(V[i]) then
      Result[i]:= StrToDate(V[i]);
end;

function VStrToTime(const V: TStrVector): TTimeVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not SEmpty(V[i]) then
      Result[i]:= StrToTime(V[i]);
end;

function VIntToBool(const V: TIntVector): TBoolVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V), False);
  for i:= 0 to High(V) do
    Result[i]:= V[i]=1;
end;

function VBoolToInt(const V: TBoolVector): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V), 0);
  for i:= 0 to High(V) do
    Result[i]:= Ord(V[i]);
end;

{ПРЕОБРАЗОВНИЕ К СТРОКОВОМУ ВЕКТОРУ}
function VIntToStr(const V: TIntVector; const ZeroIsEmpty: Boolean = False): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not (ZeroIsEmpty and (V[i]=0)) then
      Result[i]:= IntToStr(V[i]);
end;

function VIntToStr(const V: TInt64Vector; const ZeroIsEmpty: Boolean = False): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not (ZeroIsEmpty and (V[i]=0)) then
      Result[i]:= IntToStr(V[i]);
end;

function VDateToStr(const V: TDateVector; const BoundaryIsEmpty: Boolean = False): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not (BoundaryIsEmpty and IsBoundaryDate(V[i])) then
      Result[i]:= DateToStr(V[i]);
end;

function VBoolToStr(const V: TBoolVector;
   const StrTrue: String = STR_TRUE; const StrFalse: String = STR_False): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if V[i] then
      Result[i]:= StrTrue
    else
      Result[i]:= StrFalse;
end;

function VFloatToStr(const V: TDblVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    Result[i]:= FloatToStr(V[i]);
end;

function VTimeToStr(const V: TTimeVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    Result[i]:= TimeToStr(V[i]);
end;

function VFormatDateTime(const FormatStr: String; const V: TDblVector;
                         const BoundaryIsEmpty: Boolean = False;
                         Options: TFormatDateTimeOptions = []): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:=0 to High(V) do
    if not (BoundaryIsEmpty and IsBoundaryDate(V[i])) then
      Result[i]:= FormatDateTime(FormatStr, V[i], Options);
end;

function VFormat(const FormatStr: String; const V: TIntVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:= 0 to High(V) do
    Result[i]:= Format(FormatStr, [V[i]]);
end;

function VFormat(const FormatStr: String; const V: TInt64Vector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:= 0 to High(V) do
    Result[i]:= Format(FormatStr, [V[i]]);
end;

function VFormat(const FormatStr: String; const V: TDblVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:= 0 to High(V) do
    Result[i]:= Format(FormatStr, [V[i]]);
end;

function VFormat(const FormatStr: String; const V: TStrVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:= 0 to High(V) do
    Result[i]:= Format(FormatStr, [V[i]]);
end;

function VTrim(const V: TStrVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:= 0 to High(V) do
    Result[i]:= STrim(V[i]);
end;

function VSymbolFromUnicode(const ACodes: TIntVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(ACodes) do
    VAppend(Result, SSymbolFromUnicode(ACodes[i]));
end;

function VSymbolToUnicode(const ASymbols: TStrVector): TIntVector;
var
  i: Integer;
begin
  Result:= nil;
  for i:= 0 to High(ASymbols) do
    VAppend(Result, SSymbolToUnicode(ASymbols[i]));
end;

function VSymbolsFromString(const AString: String): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if SEmpty(AString) then Exit;
  for i:= 1 to SLength(AString) do
    VAppend(Result, SSymbol(AString, i));
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

function VStrToVector(const Str, Delimiter: String; const ACaseSensitivity: Boolean = True): TStrVector;
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
  n:= SPos(S, Delimiter, 1, ACaseSensitivity);
  while n>0 do
  begin
    if n=1 then
    begin
      VAppend(Result, EmptyStr);
      S:= SDel(S, 1, LDelimiter);
    end
    else begin
      VAppend(Result, SCopy(S, 1, n-1));
      S:= SDel(S, 1, n+LDelimiter-1);
    end;
    n:= SPos(S, Delimiter, 1, ACaseSensitivity);
  end;

  if SLength(S)>0 then
    VAppend(Result, S);
end;

function VVectorToStr(const V: TStrVector;
                        const Delimiter: String;
                        const Prefix: String = '';
                        const PostFix: String = ''): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  if VIsNil(V) then Exit;
  Result:= Prefix + V[0] + PostFix;
  for i:= 1 to High(V) do
    Result:= Result + Delimiter + Prefix + V[i] + PostFix;
end;

function VStringReplace(const V: TStrVector; const OldString, NewString: String;
                        const ACaseSensitivity: Boolean = True;
                        const AMaxReplaceCount: Integer = 0 {replace all}): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(V) then Exit;
  VDim(Result, Length(V));
  for i:= 0 to High(V) do
    Result[i]:= SReplace(V[i], OldString, NewString, ACaseSensitivity, AMaxReplaceCount);
end;

function VStrToNumbers(const Str: String): TIntVector;
var
  i: Integer;
  Symbol, Number: String;
begin
  Result:= nil;
  if SEmpty(Str) then Exit;

  Number:= EmptyStr;
  for i:= 1 to SLength(Str) do
  begin
    Symbol:= SSymbol(Str, i);
    if SIsDigit(Symbol) then
      Number:= Number + Symbol
    else if not SEmpty(Number) then
    begin
      VAppend(Result, StrToInt(Number));
      Number:= EmptyStr
    end;
  end;

  if not SEmpty(Number) then
    VAppend(Result, StrToInt(Number));
end;

function VPriceStrToInt(const APrices: TStrVector): TInt64Vector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(APrices) then Exit;
  VDim(Result, Length(APrices));
  for i:= 0 to High(APrices) do
    Result[i]:= PriceStrToInt(APrices[i]);
end;

function VPriceIntToStr(const APrices: TInt64Vector;
                        const ANeedThousandSeparator: Boolean;
                        const AEmptyIfZero: Boolean = False): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  if VIsNil(APrices) then Exit;
  VDim(Result, Length(APrices));
  for i:= 0 to High(APrices) do
    Result[i]:= PriceIntToStr(APrices[i], ANeedThousandSeparator, AEmptyIfZero);
end;

function VColorFromVector(const AColorVector: TColorVector; const AIndex: Integer;
                          const ASortIndexes: TIntVector = nil): TColor;
var
  k, n: Integer;
begin
  n:= Length(ASortIndexes);
  if n>0 then
    k:= ASortIndexes[AIndex mod n]
  else
    k:= AIndex;
  Result:= AColorVector[k mod Length(AColorVector)];
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

procedure VDel(var V: TDateVector; const ADate: TDate);
var
  i: Integer;
begin
  i:= VIndexOfDate(V, ADate);
  while i>=0 do
  begin
    VDel(V, i);
    i:= VIndexOfDate(V, ADate);
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

procedure VSortDate(const V: TDateVector; out Indexes: TIntVector;
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
      x:= VMaxDate(Vec)
    else
      x:= VMinDate(Vec);
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

procedure VSortTime(const V: TTimeVector; out Indexes: TIntVector;
  const Desc: Boolean);
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
      x:= VMaxTime(Vec)
    else
      x:= VMinTime(Vec);
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

function VSort(const V: TStrVector; const Desc: Boolean): TStrVector;
var
  Indexes: TIntVector;
begin
  VSort(V, Indexes, Desc);
  Result:= VReplace(V, Indexes);
end;

function VSort(const V: TIntVector; const Desc: Boolean): TIntVector;
var
  Indexes: TIntVector;
begin
  VSort(V, Indexes, Desc);
  Result:= VReplace(V, Indexes);
end;

function VSort(const V: TInt64Vector; const Desc: Boolean): TInt64Vector;
var
  Indexes: TIntVector;
begin
  VSort(V, Indexes, Desc);
  Result:= VReplace(V, Indexes);
end;

function VSortDate(const V: TDateVector; const Desc: Boolean): TDateVector;
var
  Indexes: TIntVector;
begin
  VSortDate(V, Indexes, Desc);
  Result:= VReplace(V, Indexes);
end;

function VSortTime(const V: TTimeVector; const Desc: Boolean): TTimeVector;
var
  Indexes: TIntVector;
begin
  VSortTime(V, Indexes, Desc);
  Result:= VReplace(V, Indexes);
end;

//VReplace

function VReplace(const V: TStrVector; const Indexes: TIntVector): TStrVector;
var
  i: Integer;
begin
  VDim(Result{%H-}, Length(Indexes));
  for i:= 0 to High(Indexes) do
    Result[i]:= V[Indexes[i]];
end;

function VReplace(const V: TIntVector; const Indexes: TIntVector): TIntVector;
var
  i: Integer;
begin
  VDim(Result{%H-}, Length(Indexes));
  for i:= 0 to High(Indexes) do
    Result[i]:= V[Indexes[i]];
end;

function VReplace(const V: TInt64Vector; const Indexes: TIntVector): TInt64Vector;
var
  i: Integer;
begin
  VDim(Result{%H-}, Length(Indexes));
  for i:= 0 to High(Indexes) do
    Result[i]:= V[Indexes[i]];
end;

function VReplace(const V: TDblVector; const Indexes: TIntVector): TDblVector;
var
  i: Integer;
begin
  VDim(Result{%H-}, Length(Indexes));
  for i:= 0 to High(Indexes) do
    Result[i]:= V[Indexes[i]];
end;

function VReplace(const V: TBoolVector; const Indexes: TIntVector): TBoolVector;
var
  i: Integer;
begin
  VDim(Result{%H-}, Length(Indexes));
  for i:= 0 to High(Indexes) do
    Result[i]:= V[Indexes[i]];
end;

//VReverse

function VReverse(const V: TIntVector): TIntVector;
var
  i, n: Integer;
begin
  VDim(Result{%H-}, Length(V));
  n:= High(V);
  for i:= n downto 0 do
    Result[n-i]:= V[i];
end;

function VReverse(const V: TInt64Vector): TInt64Vector;
var
  i, n: Integer;
begin
  VDim(Result{%H-}, Length(V));
  n:= High(V);
  for i:= n downto 0 do
    Result[n-i]:= V[i];
end;

function VReverse(const V: TDblVector): TDblVector;
var
  i, n: Integer;
begin
  VDim(Result{%H-}, Length(V));
  n:= High(V);
  for i:= n downto 0 do
    Result[n-i]:= V[i];
end;

function VReverse(const V: TStrVector): TStrVector;
var
  i, n: Integer;
begin
  VDim(Result{%H-}, Length(V));
  n:= High(V);
  for i:= n downto 0 do
    Result[n-i]:= V[i];
end;

function VNameLong(const AFs, ANs, APs: TStrVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  VDim(Result, Length(AFs));
  for i:= 0 to High(AFs) do
    Result[i]:= SNameLong(AFs[i], ANs[i], APs[i]);
end;

function VNameShort(const AFs, ANs, APs: TStrVector): TStrVector;
var
  i: Integer;
begin
  Result:= nil;
  VDim(Result, Length(AFs));
  for i:= 0 to High(AFs) do
    Result[i]:= SNameShort(AFs[i], ANs[i], APs[i]);
end;

function VSameIndexValue(const FindValue: Integer; const SearchVector: TIntVector;
                         const SourceVector: TIntVector; out Value: Integer): Boolean;
var
  Index: Integer;
begin
  Value:= VECTOR_INT_DEFAULT_VALUE;
  Index:= VIndexOf(SearchVector, FindValue);
  Result:= Index>=0;
  if not Result then Exit;
  Value:= SourceVector[Index];
end;

function VSameIndexValue(const FindValue: Integer; const SearchVector: TIntVector;
                         const SourceVector: TInt64Vector; out Value: Int64): Boolean;
var
  Index: Integer;
begin
  Value:= VECTOR_INT64_DEFAULT_VALUE;
  Index:= VIndexOf(SearchVector, FindValue);
  Result:= Index>=0;
  if not Result then Exit;
  Value:= SourceVector[Index];
end;

function VSameIndexValue(const FindValue: Int64; const SearchVector: TInt64Vector;
                         const SourceVector: TIntVector; out Value: Integer): Boolean;
var
  Index: Integer;
begin
  Value:= VECTOR_INT_DEFAULT_VALUE;
  Index:= VIndexOf(SearchVector, FindValue);
  Result:= Index>=0;
  if not Result then Exit;
  Value:= SourceVector[Index];
end;

function VSameIndexValue(const FindValue: Int64; const SearchVector: TInt64Vector;
                         const SourceVector: TInt64Vector; out Value: Int64): Boolean;
var
  Index: Integer;
begin
  Value:= VECTOR_INT64_DEFAULT_VALUE;
  Index:= VIndexOf(SearchVector, FindValue);
  Result:= Index>=0;
  if not Result then Exit;
  Value:= SourceVector[Index];
end;

function VSameIndexValue(const FindValue: String; const SearchVector: TStrVector;
                         const SourceVector: TIntVector; out Value: Integer;
                         const ACaseSensitivity: Boolean = False): Boolean;
var
  Index: Integer;
begin
  Value:= VECTOR_INT_DEFAULT_VALUE;
  Index:= VIndexOf(SearchVector, FindValue, ACaseSensitivity);
  Result:= Index>=0;
  if not Result then Exit;
  Value:= SourceVector[Index];
end;

function VSameIndexValue(const FindValue: String; const SearchVector: TStrVector;
                         const SourceVector: TInt64Vector; out Value: Int64;
                         const ACaseSensitivity: Boolean): Boolean;
var
  Index: Integer;
begin
  Value:= VECTOR_INT_DEFAULT_VALUE;
  Index:= VIndexOf(SearchVector, FindValue, ACaseSensitivity);
  Result:= Index>=0;
  if not Result then Exit;
  Value:= SourceVector[Index];
end;

function VPickFromKey(const Values: TIntVector;
                      const Keys: TIntVector; const Picks: TIntVector): TIntVector;
var
  Index, i: Integer;
begin
  Result:= nil;
  VDim(Result, Length(Values), -1);
  for i:= 0 to High(Values) do
  begin
    Index:= VIndexOf(Keys, Values[i]);
    if Index>=0 then
      Result[i]:= Picks[Index];
  end;
end;

function VPickFromKey(const Values: TIntVector;
                      const Keys: TIntVector; const Picks: TStrVector): TStrVector;
var
  Index, i: Integer;
begin
  Result:= nil;
  if VIsNil(Values) then Exit;
  VDim(Result, Length(Values), EmptyStr);
  for i:= 0 to High(Values) do
  begin
    Index:= VIndexOf(Keys, Values[i]);
    if Index>=0 then
      Result[i]:= Picks[Index];
  end;
end;

function VPickFromKey(const Values: TInt64Vector;
                      const Keys: TInt64Vector; const Picks: TStrVector): TStrVector;
var
  Index, i: Integer;
begin
  Result:= nil;
  if VIsNil(Values) then Exit;
  VDim(Result, Length(Values), EmptyStr);
  for i:= 0 to High(Values) do
  begin
    Index:= VIndexOf(Keys, Values[i]);
    if Index>=0 then
      Result[i]:= Picks[Index];
  end;
end;

end.

