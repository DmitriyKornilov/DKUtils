unit DK_DateUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


const
  NULDATE = 36526; //01.01.2000
  INFDATE = 401768; //31.12.2999

  MONTHIM: array [1..12] of String =
    ('январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль',
     'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь');
  MONTHROD: array [1..12] of String =
    ('января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля',
     'августа', 'сентября', 'октября', 'ноября', 'декабря');

  WEEKDAYSSHORT: array [1..7] of String =
    ('Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс');
  
  function CalcNulDate: TDate; //01.01.2000
  function CalcInfDate: TDate; //31.12.2999

  {ДАТЫ ПРОПИСЬЮ В ИМЕНИТЕЛЬНОМ И РОДИТЕЛЬНОМ ПАДЕЖАХ}
  function DateToStrImenit(const ADate: TDate): String;
  function DateToStrRodit(const ADate: TDate): String;

  {ИЗВЛЕЧЕНИЕ ЧАСТЕЙ ДАТЫ}
  function DayOfDate(const DayDate: TDate): Word;
  function MonthOfDate(const DayDate: TDate): Word;
  function YearOfDate(const DayDate: TDate): Word;

  {ПОРЯДКОВЫЙ НОМЕР ДНЯ}
  function DayNumberInYear(const DayDate: TDate): Word; //в году
  function DayNumberInMonth(const DayDate: TDate): Word; //в месяце
  function DayNumberInWeek(const DayDate: TDate): Word; //в неделе
  function DayNumberInWeek(const NDay, NMonth, NYear: Word): Word; //в неделе

  {ПОРЯДКОВЫЙ НОМЕР НЕДЕЛИ}
  function WeekNumberInMonth(const DayDate: TDate): Word; //в месяце

  {КВАРТАЛЫ}
  function QuarterNumber(const NMonth: Byte): Byte;  //номер квартала по номеру месяца
  function QuarterNumber(const DayDate: TDate): Byte;  //номер квартала по дате
  function MonthNumberInQuarter(const NMonth: Byte): Byte;  //порядковый номер месяца в квартале по номеру месяца в году
  function MonthNumberInQuarter(const DayDate: TDate): Byte;  //порядковый номер месяца в квартале по дате
  function FirstMonthInQuarter(const NQuart: Byte): Byte;  //номер первого месяца в квартале
  function LastMonthInQuarter(const NQuart: Byte): Byte;  //номер последнего месяца в квартале
  function QuarterNumberToRome(const NQuart: Byte): String; //номер квартала из арабских в римские
  function QuarterNumberRome(const NMonth: Byte): String;   //номер квартала римскими


  {ОСНОВНЫЕ ДАТЫ МЕСЯЦА}
  function FirstDayInMonth(const DayDate: TDate): TDate; //первый день
  function FirstDayInMonth(const AYear, AMonth: Word): TDate; //первый день
  function LastDayInMonth(const DayDate: TDate): TDate;   //последний день
  function LastDayInMonth(const AYear, AMonth: Word): TDate;
  procedure FirstLastDayInMonth(const DayDate: TDate;    //первый и последний дни
                                out FirstDay: TDate;
                                out LastDay: TDate);
  procedure FirstLastDayInMonth(const NMonth, NYear: Word;    //первый и последний дни
                                out FirstDay: TDate;
                                out LastDay: TDate);

  {ОСНОВНЫЕ ДАТЫ ГОДА}
  procedure FirstLastDayInQuarter(const NQuart,NYear: Word;  //квартал
                                  out FirstDay: TDate;
                                  out LastDay: TDate);
  function FirstDayInQuarter(const NQuart,NYear: Word): TDate;

  function LastDayInQuarter(const NQuart,NYear: Word): TDate;
  procedure FirstLastDayInHalfYear(const NHalf,NYear: Word;  //полугодие
                                  out FirstDay: TDate;
                                  out LastDay: TDate);
  procedure FirstLastDayInYear(const NYear: Word;  //год
                                  out FirstDay: TDate;
                                  out LastDay: TDate);
  function FirstDayInYear(const NYear: Word): TDate;
  function LastDayInYear(const NYear: Word): TDate;

  {РАСЧЕТ ДАТ УЧЕТНОГО ПЕРИОДА}
  //расчет части учетного периода до месяца с датой DayDate
  //возвращает False, если это первый месяц учетного периода
  function AccountingPeriodBefore(const DayDate: TDate;
                                   const AccountingType: Byte; //0-год, 1-квартал
                                   out BD, ED: TDate): Boolean;
  //расчет учетного периода по дате DayDate из этого периода
  procedure AccountingPeriod(const DayDate: TDate;
                                   const AccountingType: Byte; //0-год, 1-квартал, 2 - месяц
                                   out BD, ED: TDate);

  {ВРЕМЕННЫЕ ПРОМЕЖУТКИ}
  function DaysBetweenDates(const DT1, DT2: TDateTime): Integer; //кол-во дней между двумя датами
  function DaysInPeriod(const DT1, DT2: TDateTime): Integer;  //кол-во дней в указанном периоде
  function DaysInPeriod(const AMonth, AYear: Word): Integer;

  {НАИМЕНОВАНИЯ}
  function DayOfWeekShortName(const DayNum: Byte): String; //1 - 'Пн', 2 - 'Вт' ...
  function MonthLongName(const MonthNum: Byte): String;

  {ВРЕМЕННЫЕ ПЕРИОДЫ}
  function MinDate(const ADate1, ADate2: TDate): TDate; //меньшая из двух дат
  function MaxDate(const ADate1, ADate2: TDate): TDate; //большая из двух дат
  function IsEqualPeriods(const ABegin1, AEnd1, ABegin2, AEnd2: TDate): Boolean; //true, если ABegin1=ABegin2 и AEnd1=AEnd2
  function PeriodIntersect(const ABegin1, AEnd1, ABegin2, AEnd2: TDate; //проверяет на пересечение 2 периода
                              out ABegin, AEnd: TDate): Boolean;     //заполняет период пересечения
  function IsDateBetween(const ADate, AMinDate, AMaxDate: TDate): Boolean;

   {ОПЕРАЦИИ С ДАТАМИ}
  function IncMonthExt(const ADate: TDate; const ADeltaMonth: Extended): TDate;

implementation

uses DateUtils;

{ДАТЫ ПРОПИСЬЮ В ИМЕНИТЕЛЬНОМ И РОДИТЕЛЬНОМ ПАДЕЖАХ}
function DateToStrImenit(const ADate: TDate): String;
begin
  Result:= FormatDateTime('dd', ADate) + ' ' +
           MONTHIM[MonthOf(ADate)] + ' ' +
           FormatDateTime('yyyy', ADate) + 'г.';
end;

function DateToStrRodit(const ADate: TDate): String;
begin
  Result:= FormatDateTime('dd', ADate) + ' ' +
           MONTHROD[MonthOf(ADate)] + ' ' +
           FormatDateTime('yyyy', ADate) + 'г.';
end;

{ИЗВЛЕЧЕНИЕ ЧАСТЕЙ ДАТЫ}
function DayOfDate(const DayDate: TDate): Word;
var
  x,y: Word;
begin
  DecodeDate(DayDate, y, y, x);
  DayOfDate:= x;
end;

function MonthOfDate(const DayDate: TDate): Word;
var
  x,y: Word;
begin
  DecodeDate(DayDate, y, x, y);
  MonthOfDate:= x;
end;

function YearOfDate(const DayDate: TDate): Word;
var
  x,y: Word;
begin
  DecodeDate(DayDate, x, y, y);
  YearOfDate:= x;
end;

{ИСПОЛЬЗУЕМЫЕ НУЛЕВАЯ И КОНЕЧНАЯ ДАТЫ}

function CalcNulDate: TDate; //01.01.2000
begin
  CalcNulDate:= EncodeDate(2000,1,1);
end;

function CalcInfDate: TDate; //31.12.2999
begin
  CalcInfDate:= EncodeDate(2999,12,31);
end;

{ПОРЯДКОВЫЙ НОМЕР ДНЯ}

function DayNumberInYear(const DayDate: TDate): Word;
var
  tmp,y: Word;
begin
  DecodeDate(DayDate,y,tmp,tmp);
  DayNumberInYear:= DaysBetweenDates(EncodeDate(y,1,1), DayDate) + 1;
end;

function DayNumberInMonth(const DayDate: TDate): Word;
var
  d,tmp: Word;
begin
  DecodeDate(DayDate,tmp,tmp,d);
  DayNumberInMonth:= d;
end;

function DayNumberInWeek(const DayDate: TDate): Word;
var
  x: Word;
begin
  x:= DayOfWeek(DayDate)-1;  {1,2,3,4,5,6,0}
  if x=0 then x:= 7;
  DayNumberInWeek:= x;
end;

function DayNumberInWeek(const NDay, NMonth, NYear: Word): Word;
begin
  DayNumberInWeek:= DayNumberInWeek(EncodeDate(NYear, NMonth, NDay));
end;

{ПОРЯДКОВЫЙ НОМЕР НЕДЕЛИ}

function WeekNumberInMonth(const DayDate: TDate): Word;
var
  a,b: Integer;
begin
  a:= DayNumberInWeek(FirstDayInMonth(DayDate)) - 2;
  b:= DayNumberInMonth(DayDate);
  WeekNumberInMonth:= ((a+b) div 7) + 1;
end;

{КВАРТАЛЫ}

function QuarterNumber(const NMonth: Byte): Byte;
begin
  QuarterNumber:= ((NMonth-1) div 3) + 1;
end;

function QuarterNumber(const DayDate: TDate): Byte;
var
  x,m: Word;
begin
  DecodeDate(DayDate, x,m,x);
  Result:= QuarterNumber(MonthOfDate(DayDate));
end;

function MonthNumberInQuarter(const NMonth: Byte): Byte;
begin
  MonthNumberInQuarter:=  NMonth - 3*(QuarterNumber(NMonth)-1);
end;

function MonthNumberInQuarter(const DayDate: TDate): Byte;
begin
  Result:= MonthNumberInQuarter(MonthOfDate(DayDate));
end;

function FirstMonthInQuarter(const NQuart: Byte): Byte;
begin
  FirstMonthInQuarter:= 3*(NQuart - 1) + 1;
end;

function LastMonthInQuarter(const NQuart: Byte): Byte;
begin
  LastMonthInQuarter:= 3*NQuart;
end;

function QuarterNumberToRome(const NQuart: Byte): String; //номер квартала из арабских в римские
begin
  Result:= EmptyStr;
  case NQuart of
  1: Result:= 'I';
  2: Result:= 'II';
  3: Result:= 'III';
  4: Result:= 'IV';
  end;
end;

function QuarterNumberRome(const NMonth: Byte): String;   //номер квартала римскими
begin
  Result:=  QuarterNumberToRome(QuarterNumber(NMonth));
end;

{ОСНОВНЫЕ ДАТЫ МЕСЯЦА}
function FirstDayInMonth(const DayDate: TDate): TDate;
var
  d,m,y: Word;
begin
  DecodeDate(DayDate,y,m,d);
  FirstDayInMonth:= EncodeDate(y,m,1);
end;

function FirstDayInMonth(const AYear, AMonth: Word): TDate;
begin
  FirstDayInMonth:=  EncodeDate(AYear, AMonth, 1);
end;

function LastDayInMonth(const DayDate: TDate): TDate;
var
  d,m,y: Word;
begin
  DecodeDate(DayDate,y,m,d);
  LastDayInMonth:= EncodeDate(y,m,DaysInMonth(DayDate));
end;

function LastDayInMonth(const AYear, AMonth: Word): TDate;
var
  d: TDate;
begin
  d:= EncodeDate(AYear,AMonth,1);
  LastDayInMonth:= EncodeDate(AYear,AMonth,DaysInMonth(d));
end;

procedure FirstLastDayInMonth(const DayDate: TDate; out FirstDay: TDate; out
  LastDay: TDate);
var
  d,m,y: Word;
begin
  DecodeDate(DayDate,y,m,d);
  FirstDay:= EncodeDate(y,m,1);
  LastDay:= EncodeDate(y,m,DaysInMonth(DayDate));
end;

procedure FirstLastDayInMonth(const NMonth, NYear: Word; out FirstDay: TDate;
  out LastDay: TDate);
begin
  FirstDay:= EncodeDate(NYear,NMonth,1);
  LastDay:= EncodeDate(NYear,NMonth,DaysInMonth(FirstDay));
end;

{ОСНОВНЫЕ ДАТЫ ГОДА}

procedure FirstLastDayInQuarter(const NQuart, NYear: Word; out FirstDay: TDate;
  out LastDay: TDate);
var
  m: Byte;
begin
  m:= FirstMonthInQuarter(NQuart);
  FirstDay:= EncodeDate(NYear, m, 1);
  m:= m + 2;
  LastDay:= EncodeDate(NYear, m, DaysInMonth(EncodeDate(NYear,m,1)));
end;

function FirstDayInQuarter(const NQuart, NYear: Word): TDate;
var
  m: Byte;
begin
  m:= FirstMonthInQuarter(NQuart);
  FirstDayInQuarter:= EncodeDate(NYear, m, 1);
end;

function LastDayInQuarter(const NQuart, NYear: Word): TDate;
var
  m: Byte;
begin
  m:= LastMonthInQuarter(NQuart);
  LastDayInQuarter:= EncodeDate(NYear, m, DaysInMonth(EncodeDate(NYear,m,1)));
end;

procedure FirstLastDayInHalfYear(const NHalf, NYear: Word; out FirstDay: TDate;
  out LastDay: TDate);
var
  m: Byte;
begin
  m:= 6*(NHalf-1)+1;
  FirstDay:= EncodeDate(NYear, m , 1);
  m:= m + 5;
  LastDay:=  EncodeDate(NYear, m, DaysInMonth(EncodeDate(NYear,m,1)));
end;

procedure FirstLastDayInYear(const NYear: Word; out FirstDay: TDate; out
  LastDay: TDate);
begin
  FirstDay:= EncodeDate(NYear, 1 , 1);
  LastDay:= EncodeDate(NYear, 12 , 31);
end;

function FirstDayInYear(const NYear: Word): TDate;
begin
  FirstDayInYear:= EncodeDate(NYear, 1 , 1);
end;

function LastDayInYear(const NYear: Word): TDate;
begin
  LastDayInYear:= EncodeDate(NYear, 12 , 31);
end;

{РАСЧЕТ ДАТ УЧЕТНОГО ПЕРИОДА}

procedure AccountingPeriod(const DayDate: TDate;
                           const AccountingType: Byte; //0-год, 1-квартал, 2 - месяц
                           out BD, ED: TDate);
begin
  case AccountingType of
  0: FirstLastDayInYear(YearOfDate(DayDate), BD, ED);  //год
  1: FirstLastDayInQuarter(QuarterNumber(DayDate), YearOfDate(DayDate), BD, ED); //квартал
  2: FirstLastDayInMonth(DayDate, BD, ED); //месяц
  end;
end;

function AccountingPeriodBefore(const DayDate: TDate;
                                const AccountingType: Byte; //0-год, 1-квартал
                                out BD, ED: TDate): Boolean;
var
  M, Y: Word;
begin
  Result:= False;
  BD:= NULDATE;
  ED:= NULDATE;
  if AccountingType>1 then Exit;
  Y:= YearOfDate(DayDate);
  M:= MonthOfDate(DayDate);
  case AccountingType of
  0: begin //год
       if M=1 then Exit;
       BD:= FirstDayInYear(Y);
     end;
  1: begin //квартал
       if MonthNumberInQuarter(M)=1 then Exit;
       BD:= FirstDayInQuarter(QuarterNumber(M), Y);
     end;
  end;
  ED:= LastDayInMonth(Y, M-1);
  Result:= True;
end;

{ВРЕМЕННЫЕ ПРОМЕЖУТКИ}

function DaysBetweenDates(const DT1, DT2: TDateTime): Integer;
var
  x: Integer;
begin
  x:= DateTimeToUnix(DT2)-DateTimeToUnix(DT1);
  DaysBetweenDates:= Trunc(x/3600/24);
end;

function DaysInPeriod(const DT1, DT2: TDateTime): Integer;
begin
  DaysInPeriod:= DaysBetweenDates(DT1, DT2) + 1;
end;

function DaysInPeriod(const AMonth, AYear: Word): Integer;
begin
  DaysInPeriod:= DaysInMonth(EncodeDate(AYear, AMonth,1));
end;

{НАИМЕНОВАНИЯ}
function DayOfWeekShortName(const DayNum: Byte): String;
begin
  Result:= WEEKDAYSSHORT[DayNum];
end;

function MonthLongName(const MonthNum: Byte): String;
begin
  Result:= MONTHIM[MonthNum];
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

function PeriodIntersect(const ABegin1, AEnd1, ABegin2, AEnd2: TDate; out
  ABegin, AEnd: TDate): Boolean;     //заполняет период пересечения

begin
  Result:= ((CompareDate(ABegin1, ABegin2)<=0) and (CompareDate(AEnd1, AEnd2)>=0)) or
           ((CompareDate(ABegin1, ABegin2)<=0) and (CompareDate(AEnd1, ABegin2)>=0)) or
           ((CompareDate(ABegin1, AEnd2)<=0)   and (CompareDate(AEnd1, AEnd2)>=0)) or
           ((CompareDate(ABegin1, ABegin2)>=0) and (CompareDate(AEnd1, AEnd2)<=0));
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

function IsDateBetween(const ADate, AMinDate, AMaxDate: TDate): Boolean;
begin
  Result:= (CompareDate(ADate, AMinDate)>=0) and
           (CompareDate(ADate, AMaxDate)<=0);
end;

function IsEqualPeriods(const ABegin1, AEnd1, ABegin2, AEnd2: TDate): Boolean; //true, если ABegin1=ABegin2 и AEnd1=AEnd2
begin
  Result:= (CompareDate(ABegin1, ABegin2)=0) and (CompareDate(AEnd1, AEnd2)=0);
end;

{ОПЕРАЦИИ С ДАТАМИ}
function IncMonthExt(const ADate: TDate; const ADeltaMonth: Extended): TDate;
var
  DeltaM, DeltaD: Integer;
begin
  //целая часть приращения
  DeltaM:= Trunc(ADeltaMonth);
  Result:= IncMonth(ADate, DeltaM);
  if DeltaM<>ADeltaMonth then //дробное число месяцев
  begin
    DeltaD:= Round(30*Frac(ADeltaMonth));
    Result:= IncDay(Result, DeltaD);
  end;
end;

end.

