unit DK_DateUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, DK_Const;

  {ДАТЫ ПРОПИСЬЮ В ИМЕНИТЕЛЬНОМ И РОДИТЕЛЬНОМ ПАДЕЖАХ}
  function DateToStrNominative(const ADate: TDate): String;
  function DateToStrGenitive(const ADate: TDate): String;

  {ИЗВЛЕЧЕНИЕ ЧАСТЕЙ ДАТЫ}
  function DayOfDate(const ADate: TDate): Word;
  function MonthOfDate(const ADate: TDate): Word;
  function YearOfDate(const ADate: TDate): Word;

  {ПОРЯДКОВЫЙ НОМЕР ДНЯ}
  function DayNumberInYear(const ADate: TDate): Word; //в году
  function DayNumberInYear(const ADay, AMonth, AYear: Word): Word; //в году
  function DayNumberInWeek(const ADate: TDate): Word; //в неделе
  function DayNumberInWeek(const ADay, AMonth, AYear: Word): Word; //в неделе

  {ПОРЯДКОВЫЙ НОМЕР НЕДЕЛИ}
  function WeekNumberInMonth(const ADate: TDate): Word; //в месяце
  function WeekNumberInMonth(const ADay, AMonth, AYear: Word): Word; //в месяце

  {КВАРТАЛЫ}
  function QuarterNumber(const AMonth: Byte): Byte;  //номер квартала по номеру месяца
  function QuarterNumber(const ADate: TDate): Byte;  //номер квартала по дате
  function MonthNumberInQuarter(const AMonth: Byte): Byte;  //порядковый номер месяца в квартале по номеру месяца в году
  function MonthNumberInQuarter(const ADate: TDate): Byte;  //порядковый номер месяца в квартале по дате
  function FirstMonthInQuarter(const AQuart: Byte): Byte;  //номер первого месяца в квартале
  function FirstMonthInQuarter(const ADate: TDate): Byte;
  function LastMonthInQuarter(const AQuart: Byte): Byte;  //номер последнего месяца в квартале
  function LastMonthInQuarter(const ADate: TDate): Byte;
  function QuarterNumberToRome(const AQuart: Byte): String; //номер квартала из арабских в римские

  {ПОЛУГОДИЕ}
  function HalfYearNumber(const AMonth: Byte): Byte;
  function HalfYearNumber(const ADate: TDate): Byte;

  {ОСНОВНЫЕ ДАТЫ МЕСЯЦА}
  function FirstDayInMonth(const ADate: TDate): TDate; //первый день
  function FirstDayInMonth(const AMonth, AYear: Word): TDate; //первый день
  function LastDayInMonth(const ADate: TDate): TDate;   //последний день
  function LastDayInMonth(const AMonth, AYear: Word): TDate;
  procedure FirstLastDayInMonth(const ADate: TDate;    //первый и последний дни
                                out AFirstDay, ALastDay: TDate);
  procedure FirstLastDayInMonth(const AMonth, AYear: Word;    //первый и последний дни
                                out AFirstDay, ALastDay: TDate);

  {ОСНОВНЫЕ ДАТЫ ГОДА}
  function FirstDayInYear(const AYear: Word): TDate;
  function FirstDayInYear(const ADate: TDate): TDate;
  function LastDayInYear(const AYear: Word): TDate;
  function LastDayInYear(const ADate: TDate): TDate;
  procedure FirstLastDayInYear(const AYear: Word;
                               out AFirstDay, ALastDay: TDate);
  procedure FirstLastDayInYear(const ADate: TDate;
                               out AFirstDay, ALastDay: TDate);

  function FirstDayInQuarter(const AQuart, AYear: Word): TDate;
  function FirstDayInQuarter(const ADate: TDate): TDate;
  function LastDayInQuarter(const AQuart, AYear: Word): TDate;
  function LastDayInQuarter(const ADate: TDate): TDate;
  procedure FirstLastDayInQuarter(const AQuart, AYear: Word;
                                  out AFirstDay, ALastDay: TDate);
  procedure FirstLastDayInQuarter(const ADate: TDate;
                                  out AFirstDay, ALastDay: TDate);
  procedure FirstLastDayInHalfYear(const AHalf, AYear: Word;
                                   out AFirstDay, ALastDay: TDate);
  procedure FirstLastDayInHalfYear(const ADate: TDate;
                                   out AFirstDay, ALastDay: TDate);

  {ВРЕМЕННЫЕ ПРОМЕЖУТКИ}
  function MinDate(const ADate1, ADate2: TDate): TDate; //меньшая из двух дат
  function MaxDate(const ADate1, ADate2: TDate): TDate; //большая из двух дат
  function DaysBetweenDates(const ADate1, ADate2: TDate): Integer; //кол-во дней между двумя датами
  function DaysInPeriod(const ADate1, ADate2: TDate): Integer;  //кол-во дней в указанном периоде
  function IsDateInPeriod(const ADate, ADate1, ADate2: TDate): Boolean;
  function IsEqualPeriods(const ABegin1, AEnd1, ABegin2, AEnd2: TDate): Boolean;
  function IsPeriodIntersect(const ABegin1, AEnd1, ABegin2, AEnd2: TDate): Boolean;
  function IsPeriodIntersect(const ABegin1, AEnd1, ABegin2, AEnd2: TDate;
                             out ABegin, AEnd: TDate): Boolean;

  {ОПЕРАЦИИ С ДАТАМИ}
  function IncMonthExt(const ADate: TDate; const ADeltaMonth: Extended): TDate;
  function IsBoundaryDate(const ADate: TDate): Boolean;


implementation

{ДАТЫ ПРОПИСЬЮ В ИМЕНИТЕЛЬНОМ И РОДИТЕЛЬНОМ ПАДЕЖАХ}
function DateToStrNominative(const ADate: TDate): String;
begin
  Result:= FormatDateTime('dd', ADate) + ' ' +
           MONTHSNOM[MonthOf(ADate)] + ' ' +
           FormatDateTime('yyyy', ADate) + 'г.';
end;

function DateToStrGenitive(const ADate: TDate): String;
begin
  Result:= FormatDateTime('dd', ADate) + ' ' +
           MONTHSGEN[MonthOf(ADate)] + ' ' +
           FormatDateTime('yyyy', ADate) + 'г.';
end;

{ИЗВЛЕЧЕНИЕ ЧАСТЕЙ ДАТЫ}
function DayOfDate(const ADate: TDate): Word;
var
  x,y: Word;
begin
  DecodeDate(ADate, y, y, x);
  Result:= x;
end;

function MonthOfDate(const ADate: TDate): Word;
var
  x,y: Word;
begin
  DecodeDate(ADate, y, x, y);
  Result:= x;
end;

function YearOfDate(const ADate: TDate): Word;
var
  x,y: Word;
begin
  DecodeDate(ADate, x, y, y);
  Result:= x;
end;

{ПОРЯДКОВЫЙ НОМЕР ДНЯ}

function DayNumberInYear(const ADate: TDate): Word;
begin
  Result:= DaysBetweenDates(FirstDayInYear(ADate), ADate) + 1;
end;

function DayNumberInYear(const ADay, AMonth, AYear: Word): Word;
var
  d1, d2: TDate;
begin
  d1:= EncodeDate(AYear, 1, 1);
  d2:= EncodeDate(AYear, AMonth, ADay);
  Result:= DaysBetweenDates(d1, d2) + 1;
end;

function DayNumberInWeek(const ADate: TDate): Word;
var
  x: Word;
begin
  x:= DayOfWeek(ADate)-1;  {1,2,3,4,5,6,0}
  if x=0 then x:= 7;
  Result:= x;
end;

function DayNumberInWeek(const ADay, AMonth, AYear: Word): Word;
begin
  Result:= DayNumberInWeek(EncodeDate(AYear, AMonth, ADay));
end;

{ПОРЯДКОВЫЙ НОМЕР НЕДЕЛИ}

function WeekNumberInMonth(const ADate: TDate): Word;
var
  a,b: Integer;
begin
  a:= DayNumberInWeek(FirstDayInMonth(ADate)) - 2;
  b:= DayOfDate(ADate);
  Result:= ((a+b) div 7) + 1;
end;

function WeekNumberInMonth(const ADay, AMonth, AYear: Word): Word;
begin
  Result:= WeekNumberInMonth(EncodeDate(AYear, AMonth, ADay));
end;

{КВАРТАЛЫ}

function QuarterNumber(const AMonth: Byte): Byte;
begin
  Result:= ((AMonth-1) div 3) + 1;
end;

function QuarterNumber(const ADate: TDate): Byte;
var
  x,m: Word;
begin
  DecodeDate(ADate, x,m,x);
  Result:= QuarterNumber(MonthOfDate(ADate));
end;

function MonthNumberInQuarter(const AMonth: Byte): Byte;
begin
  Result:= AMonth - 3*(QuarterNumber(AMonth)-1);
end;

function MonthNumberInQuarter(const ADate: TDate): Byte;
begin
  Result:= MonthNumberInQuarter(MonthOfDate(ADate));
end;

function FirstMonthInQuarter(const AQuart: Byte): Byte;
begin
  Result:= 3*(AQuart - 1) + 1;
end;

function FirstMonthInQuarter(const ADate: TDate): Byte;
begin
  Result:= FirstMonthInQuarter(QuarterNumber(ADate));
end;

function LastMonthInQuarter(const AQuart: Byte): Byte;
begin
  Result:= 3*AQuart;
end;

function LastMonthInQuarter(const ADate: TDate): Byte;
begin
  Result:= LastMonthInQuarter(QuarterNumber(ADate));
end;

function QuarterNumberToRome(const AQuart: Byte): String; //номер квартала из арабских в римские
begin
  Result:= EmptyStr;
  case AQuart of
  1: Result:= 'I';
  2: Result:= 'II';
  3: Result:= 'III';
  4: Result:= 'IV';
  end;
end;

function HalfYearNumber(const AMonth: Byte): Byte;
begin
  if AMonth<=6 then
    Result:= 1
  else
    Result:= 2;
end;

function HalfYearNumber(const ADate: TDate): Byte;
begin
  Result:= HalfYearNumber(MonthOfDate(ADate));
end;

{ОСНОВНЫЕ ДАТЫ МЕСЯЦА}
function FirstDayInMonth(const ADate: TDate): TDate;
var
  d,m,y: Word;
begin
  DecodeDate(ADate,y,m,d);
  Result:= EncodeDate(y,m,1);
end;

function FirstDayInMonth(const AMonth, AYear: Word): TDate;
begin
  Result:= EncodeDate(AYear, AMonth, 1);
end;

function LastDayInMonth(const ADate: TDate): TDate;
var
  d,m,y: Word;
begin
  DecodeDate(ADate,y,m,d);
  Result:= EncodeDate(y,m,DaysInMonth(ADate));
end;

function LastDayInMonth(const AMonth, AYear: Word): TDate;
var
  d: TDate;
begin
  d:= EncodeDate(AYear,AMonth,1);
  Result:= EncodeDate(AYear,AMonth,DaysInMonth(d));
end;

procedure FirstLastDayInMonth(const ADate: TDate; out AFirstDay, ALastDay: TDate);
var
  d,m,y: Word;
begin
  DecodeDate(ADate,y,m,d);
  AFirstDay:= EncodeDate(y,m,1);
  ALastDay:= EncodeDate(y,m,DaysInMonth(ADate));
end;

procedure FirstLastDayInMonth(const AMonth, AYear: Word; out AFirstDay, ALastDay: TDate);
begin
  AFirstDay:= EncodeDate(AYear,AMonth,1);
  ALastDay:= EncodeDate(AYear,AMonth,DaysInMonth(AFirstDay));
end;

{ОСНОВНЫЕ ДАТЫ ГОДА}

function FirstDayInYear(const AYear: Word): TDate;
begin
  FirstDayInYear:= EncodeDate(AYear, 1 , 1);
end;

function FirstDayInYear(const ADate: TDate): TDate;
begin
  Result:= FirstDayInYear(YearOfDate(ADate));
end;

function LastDayInYear(const AYear: Word): TDate;
begin
  Result:= EncodeDate(AYear, 12 , 31);
end;

function LastDayInYear(const ADate: TDate): TDate;
begin
  Result:= LastDayInYear(YearOfDate(ADate));
end;

procedure FirstLastDayInYear(const AYear: Word; out AFirstDay, ALastDay: TDate);
begin
  AFirstDay:= EncodeDate(AYear, 1 , 1);
  ALastDay:= EncodeDate(AYear, 12 , 31);
end;

procedure FirstLastDayInYear(const ADate: TDate; out AFirstDay, ALastDay: TDate);
begin
  FirstLastDayInYear(YearOfDate(ADate), AFirstDay, ALastDay);
end;

function FirstDayInQuarter(const AQuart, AYear: Word): TDate;
begin
  Result:= EncodeDate(AYear, FirstMonthInQuarter(AQuart), 1);
end;

function FirstDayInQuarter(const ADate: TDate): TDate;
begin
  Result:= FirstDayInQuarter(QuarterNumber(ADate), YearOfDate(ADate));
end;

function LastDayInQuarter(const AQuart, AYear: Word): TDate;
var
  m: Byte;
begin
  m:= LastMonthInQuarter(AQuart);
  Result:= EncodeDate(AYear, m, DaysInMonth(EncodeDate(AYear,m,1)));
end;

function LastDayInQuarter(const ADate: TDate): TDate;
begin
  Result:= LastDayInQuarter(QuarterNumber(ADate), YearOfDate(ADate));
end;

procedure FirstLastDayInQuarter(const AQuart, AYear: Word; out AFirstDay,
  ALastDay: TDate);
var
  m: Byte;
begin
  m:= FirstMonthInQuarter(AQuart);
  AFirstDay:= EncodeDate(AYear, m, 1);
  m:= m + 2;
  ALastDay:= EncodeDate(AYear, m, DaysInMonth(EncodeDate(AYear,m,1)));
end;

procedure FirstLastDayInQuarter(const ADate: TDate; out AFirstDay,
  ALastDay: TDate);
begin
  FirstLastDayInQuarter(QuarterNumber(ADate), YearOfDate(ADate), AFirstDay, ALastDay);
end;

procedure FirstLastDayInHalfYear(const AHalf, AYear: Word; out AFirstDay,
  ALastDay: TDate);
var
  m: Byte;
begin
  m:= 6*(AHalf-1)+1;
  AFirstDay:= EncodeDate(AYear, m , 1);
  m:= m + 5;
  ALastDay:=  EncodeDate(AYear, m, DaysInMonth(EncodeDate(AYear,m,1)));
end;

procedure FirstLastDayInHalfYear(const ADate: TDate; out AFirstDay,
  ALastDay: TDate);
begin
  FirstLastDayInHalfYear(HalfYearNumber(ADate), YearOfDate(ADate), AFirstDay, ALastDay);
end;

{ВРЕМЕННЫЕ ПЕРИОДЫ}

function MinDate(const ADate1, ADate2: TDate): TDate;
begin
  Result:= ADate1;
  if CompareDate(ADate1, ADate2)>0 then
    Result:= ADate2;
end;

function MaxDate(const ADate1, ADate2: TDate): TDate;
begin
  Result:= ADate1;
  if CompareDate(ADate1, ADate2)<0 then
    Result:= ADate2;
end;

function DaysBetweenDates(const ADate1, ADate2: TDate): Integer;
var
  x: Integer;
begin
  x:= DateTimeToUnix(ADate2)-DateTimeToUnix(ADate1);
  DaysBetweenDates:= Trunc(x/3600/24);
end;

function DaysInPeriod(const ADate1, ADate2: TDate): Integer;
begin
  DaysInPeriod:= DaysBetweenDates(ADate1, ADate2) + 1;
end;

function IsDateInPeriod(const ADate, ADate1, ADate2: TDate): Boolean;
begin
  Result:= (CompareDate(ADate, ADate1)>=0) and
           (CompareDate(ADate, ADate2)<=0);
end;

function IsEqualPeriods(const ABegin1, AEnd1, ABegin2, AEnd2: TDate): Boolean; //true, если ABegin1=ABegin2 и AEnd1=AEnd2
begin
  Result:= (CompareDate(ABegin1, ABegin2)=0) and (CompareDate(AEnd1, AEnd2)=0);
end;

function IsPeriodIntersect(const ABegin1, AEnd1, ABegin2, AEnd2: TDate): Boolean;
begin
  Result:= ((CompareDate(ABegin1, ABegin2)<=0) and (CompareDate(AEnd1, AEnd2)>=0)) or
           ((CompareDate(ABegin1, ABegin2)<=0) and (CompareDate(AEnd1, ABegin2)>=0)) or
           ((CompareDate(ABegin1, AEnd2)<=0)   and (CompareDate(AEnd1, AEnd2)>=0)) or
           ((CompareDate(ABegin1, ABegin2)>=0) and (CompareDate(AEnd1, AEnd2)<=0));
end;

function IsPeriodIntersect(const ABegin1, AEnd1, ABegin2, AEnd2: TDate; out
  ABegin, AEnd: TDate): Boolean;
begin
  Result:= IsPeriodIntersect(ABegin1, AEnd1, ABegin2, AEnd2);
  if Result then
  begin
    ABegin:= MaxDate(ABegin1, ABegin2);
    AEnd:= MinDate(AEnd1, AEnd2);
  end
  else begin
    ABegin:= ABegin1;
    AEnd:= AEnd1;
  end;
end;

{ОПЕРАЦИИ С ДАТАМИ}

function IncMonthExt(const ADate: TDate; const ADeltaMonth: Extended): TDate;
var
  Delta: Integer;
begin
  Delta:= Trunc(ADeltaMonth); //целая часть приращения
  Result:= IncMonth(ADate, Delta);
  Delta:= Round(30*Frac(ADeltaMonth)); //дробная часть месяцев (дни)
  if Delta<>0 then
    Result:= IncDay(Result, Delta);
end;

function IsBoundaryDate(const ADate: TDate): Boolean;
begin
  Result:= (CompareDate(ADate, 0)=0)           or
           (CompareDate(ADate, NULDATE)=0)     or
           (CompareDate(ADate, INFDATE)=0)     or
           (CompareDate(ADate, MaxDateTime)=0) or
           (CompareDate(ADate, MinDateTime)=0);
end;


end.

