unit DK_PriceUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, DK_StrUtils;

  {'1234,56' -> 123456 или '1 234,56' -> 123456}
  function PriceStrToInt(const APrice: String): Int64;

  {ANeedThousandSeparator=False: 123456 -> '1234,56'; True: 123456 -> '1 234,56'
   AEmptyIfZero=False: 0 -> '0,00'; True: 0 -> ''}
  function PriceIntToStr(const APrice: Int64;
                         const ANeedThousandSeparator: Boolean = False;
                         const AEmptyIfZero: Boolean = False): String;

  {ANeedThousandSeparator=False: 123456 -> '1234 руб. 56 коп.'; True: 123456 -> '1 234 руб. 56 коп.' '}
  function PriceToString(const APrice: Int64; const ANeedThousandSeparator: Boolean = False): String;

  {123456 -> одна тысяча двести тридцать четыре рубля 56 копеек; AFirstCapital=true: первая буква заглавная}
  function PriceToText(const APrice: Int64; const AFirstCapital: Boolean = False): String;

implementation

const
  MAX000 = 6;
  MAXPOSITION = MAX000*3;

procedure PriceIntToRubKop(const APrice: Int64; out ARub: Int64; out AKop: Byte);
begin
  ARub:= APrice div 100;
  AKop:= APrice mod 100;
end;

procedure PriceIntToRubKop(const APrice: Int64; out ARub, AKop: String;
                           const ANeedThousandSeparator: Boolean = False);
var
  Rub: Int64;
  Kop: Byte;
begin
  PriceIntToRubKop(APrice, Rub, Kop);
  if ANeedThousandSeparator then
    ARub:= FormatFloat('## ### ### ### ### ###', Rub)
  else
    ARub:= IntToStr(Rub);
  AKop:= Format('%.2d', [Kop]);
end;

function PriceStrToInt(const APrice: String): Int64;
var
  Rub, Kop, Price: String;
begin
  Result:= 0;
  if SEmpty(APrice) then Exit;
  Price:= StringReplace(APrice, FormatSettings.ThousandSeparator, EmptyStr, [rfReplaceAll]);
  if SDivide(Price, FormatSettings.DecimalSeparator, Rub, Kop) then
  begin
    if SLength(Kop)=1 then Kop:= Kop + '0';
    Result:= StrToInt64(Rub)*100 + StrToInt64(Kop);
  end
  else
    Result:= StrToInt64(Price)*100;
end;

function PriceIntToStr(const APrice: Int64;
                       const ANeedThousandSeparator: Boolean = False;
                       const AEmptyIfZero: Boolean = False): String;
var
  Rub, Kop: String;
begin
  Result:= EmptyStr;
  if (APrice=0) and AEmptyIfZero then Exit;
  PriceIntToRubKop(APrice, Rub, Kop, ANeedThousandSeparator);
  Result:= Rub + FormatSettings.DecimalSeparator + Kop;
end;

function PriceToString(const APrice: Int64; const ANeedThousandSeparator: Boolean = False): String;
var
  Rub, Kop: String;
begin
  PriceIntToRubKop(APrice, Rub, Kop, ANeedThousandSeparator);
  Result:= Rub + ' руб. ' + Kop + ' коп.';
end;

function NumToStr(s: String): String;
const
  c1000: array [0..MAX000] of String =
         ('', 'тысяч', 'миллион', 'миллиард', 'триллион', 'квадраллион', 'квинтиллион');
  c1000w: array [0..MAX000] of Boolean =
         (False, True, False, False, False, False, False);
  w: array [False..True, 0..9] of String =
         (('ов ', ' ', 'а ', 'а ', 'а ', 'ов ', 'ов ', 'ов ', 'ов ', 'ов '),
          (' ', 'а ', 'и ', 'и ', 'и ', ' ', ' ', ' ', ' ', ' '));

  function Num000ToStr(s: String; b: Boolean): String;
  const
    c100: array [0..9] of String =
           ('', 'сто ', 'двести ', 'триста ', 'четыреста ', 'пятьсот ', 'шестьсот ', 'семьсот ', 'восемьсот ', 'девятьсяот ');
    c10: array [0..9] of String =
           ('', 'десять ', 'двадцать ', 'тридцать ', 'сорок ', 'пятьдесят ', 'шестьдесят ', 'семьдесят ', 'восемьдесят ', 'девяносто ');
    c11: array [0..9] of String =
           ('', 'один', 'две', 'три', 'четыр', 'пят', 'шест', 'сем', 'восем', 'девят');
    c1:  array [False..True, 0..9] of String =
           (('', 'один ', 'два ', 'три ', 'четыре ', 'пять ', 'шесть ', 'семь ', 'восемь ', 'девять '),
            ('', 'одна ', 'две ', 'три ', 'четыре ', 'пять ', 'шесть ', 'семь ', 'восемь ', 'девять '));
  var
    Dig3, Dig2: Byte;
  begin
    Dig2:= SDigit(s,2);
    Dig3:= SDigit(s,3);
    Result:= c100[SDigit(s,1)];
    if (Dig2=1) and (Dig3>0) then
      Result:= Result + c11[Dig3] + 'надцать '
    else
      Result:= Result + c10[Dig2] + c1[b, Dig3]
  end;

var
  s000: String;
  Isw, IsMinus: Boolean;
  i, N: Byte;

begin
  Result:= EmptyStr;
  i:= 0;
  IsMinus:= (s<>EmptyStr) and (SSymbol(s,1)='-');
  if IsMinus then s:= SCopyCount(s, 2, SLength(s)-1);
  N:= SLength(s);
  while not ((i>=Ceil(N/3)) or (i>=MAX000)) do
  begin
    s000:= SCopyCount('00'+s, N-i*3, 3);
    Isw:= c1000w[i];
    if (i>0) and (s000<>'000') then
    begin
      if SDigit(s000,2)=1 then
        Result:= c1000[i] + w[Isw, 0] + Result
      else
        Result:= c1000[i] + w[Isw, SDigit(s000,3)] + Result;
    end;
    Result:= Num000ToStr(s000, Isw) + Result;
    Inc(i);
  end;
  if Result=EmptyStr then Result:= 'ноль';
  if IsMinus then Result:= 'минус ' + Result;
end;


function PriceToText(const APrice: Extended; const AFirstCapital: Boolean = False): String;
var
  Rub,Kop: String;
  N: Byte;
const
  RUBLEY: array [0..9] of String =
         ('ей', 'ь', 'я', 'я', 'я', 'ей', 'ей', 'ей', 'ей', 'ей');
  KOPEEK: array [0..9] of String =
         ('ек', 'йка', 'йки', 'йки', 'йки', 'ек', 'ек', 'ек', 'ек', 'ек');

  function EndInd(s: String): Byte;
  var
    L: Byte;
  begin
    L:= SLength(s);
    if (L>1) and (SDigit(s,L-1)=1) then
      Result:= 0
    else
      Result:= SDigit(s,L);
  end;
begin
   Str(APrice: MAXPOSITION+3:2, Result);
   if SPos('E', Result)>0 then Exit;

   N:= SLength(Result);
   Rub:= SCopyCount(Result, 1, N-3);
   Rub:= STrim(Rub);
   Kop:= SCopyCount(Result, N-1, 2);

   Result:= NumToStr(Rub) + ' рубл' + RUBLEY[EndInd(Rub)] +
            ' ' +    Kop  + ' копе' + KOPEEK[EndInd(Kop)];

   if AFirstCapital then
     Result:= SUpper(SSymbol(Result,1)) + SCopy(Result, 2, SLength(Result));

end;

function PriceToText(const APrice: Int64; const AFirstCapital: Boolean = False): String;
begin
  Result:= PriceToText(APrice/100, AFirstCapital);
end;

end.

