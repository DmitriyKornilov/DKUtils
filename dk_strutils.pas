unit DK_StrUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, Graphics, DK_Vector;

const
  SYMBOL_HYPH         = #13;
  SYMBOL_SPACE        = ' ';                      //пробел
  SYMBOL_CARRY        = '-';                      //символ переноса слова
  SYMBOLS_SEPARATOR   = SYMBOL_SPACE;             //символы разделения слов
  SYMBOLS_PUNCTUATION = '-,;:.?!/\()"«»';         //пунктуация, разделители
  SYMBOLS_VOWEL       = 'АЕЁИОУЭЫЮЯ';             //гласные буквы
  SYMBOLS_CONSONANT   = 'БВГДЖЙЗКЛМНПРСТФЧЦХШЩ';  //согласные буквы
  SYMBOLS_SPECIAL     = 'ЬЪ';

type
  TSymbolType = (stUnknown, stPunctuation, stSeparator, stVowel, stConsonant, stSpecial);

  function SLength(const AStr: String): PtrInt;
  function SUpper(const AStr: String): String;
  function STrim(const AStr: String): String;
  function SSame(const AStr1, AStr2: String): Boolean;
  function SPos(const AStr, AValue: String; const AStartPos: SizeInt = 1): PtrInt;
  function SCopy(const AStr: String; const AStart, AEnd: PtrInt): String;
  function SCopyCount(const AStr: String; const AStart, ACount: PtrInt): String;
  function SDivide(const AStr: String; const ADivideSymbol: String; out APart1, APart2: String): Boolean;
  function SDel(const AStr: String; const AStart, AEnd: PtrInt): String;
  function SSymbol(const AStr: String; const ASymbolPos: PtrInt): String;
  function SSymbolFirst(const AStr: String): String;
  function SSymbolLast(const AStr: String): String;
  function SDigit(const AStr: String; const ASymbolPos: PtrInt): Byte;
  function SRedLine(const ASpacesCount: SizeUInt): String;
  function SSymbolType(const ASymbol: String): TSymbolType;
  function SSymbolType(const AStr: String; const ASymbolPos: PtrInt): TSymbolType;
  function SFont(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): TFont;
  function SWidth(const AStr: String; const AFont: TFont): Integer;
  function SWidth(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
  function SHeight(const AStr: String; const AFont: TFont): Integer;
  function SHeight(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;

  {STextToWords - разбивает текст AText на слова. Возвращает вектор этих слов}
  function STextToWords(const AText: String): TStrVector;

  {SWordToParts - разбивает слово на слоги для возможного переноса на другую строку.
  Возвращает вектор этих слогов.
  Не учитываются слова, не подлежащие переносу (например "узнаю")
  Могут быть ошибки в
  1. сложносокращенных словах (например "спецодежда"),
  2. сложных словах (например "пятиграммовый")}
  function SWordToParts(const AWord: String): TStrVector;

  {STextToCell - вставляет в текст AText с шрифтом AFont символы разрыва
  (переноса) строки AHyphSymbol так, чтобы полученные строки умещались в ячейке
  шириной ACellWidth (размерность в px), а также символы пробела количеством
  ARedLineWidth в начало текста (красная строка).
  Возвращает требуемую высоту ячейки в px.}
  function STextToCell(var AText: String; const AFont: TFont;
                    const ACellWidth: Integer;
                    const ARedLineWidth: Integer = 0;
                    const AWrapToWordParts: Boolean = False;
                    const AHyphSymbol: String = SYMBOL_HYPH): Integer; //result:= CellHeight

  {Фамилия Имя Отчество -> Фамилия И.О.}
  function SFIO(const F, I, O: String): String;

implementation

function SLength(const AStr: String): PtrInt;
begin
  SLength:= UTF8Length(AStr);
end;

function SUpper(const AStr: String): String;
begin
  SUpper:= UTF8UpperCase(AStr);
end;

function STrim(const AStr: String): String;
begin
  STrim:= UTF8Trim(AStr);
end;

function SSame(const AStr1, AStr2: String): Boolean;
begin
  SSame:= UTF8CompareStr(AStr1, AStr2)=0;
end;

function SPos(const AStr, AValue: String; const AStartPos: SizeInt = 1): PtrInt;
begin
  SPos:= UTF8Pos(AValue, AStr, AStartPos);
end;

function SCopy(const AStr: String; const AStart, AEnd: PtrInt): String;
begin
  SCopy:= UTF8Copy(AStr, AStart, AEnd-AStart+1);
end;

function SCopyCount(const AStr: String; const AStart, ACount: PtrInt): String;
begin
  SCopyCount:= UTF8Copy(AStr, AStart, ACount);
end;

function SDivide(const AStr: String; const ADivideSymbol: String; out APart1, APart2: String): Boolean;
var
  N: PtrInt;
begin
  SDivide:= False;
  APart1:= AStr;
  APart2:= EmptyStr;
  N:= SPos(ADivideSymbol, AStr);
  if N>0 then
  begin
    APart1:= SCopy(AStr,1, N-1);
    APart2:= SCopy(AStr,N+1, SLength(AStr));
    SDivide:= True;
  end;
end;

function SDel(const AStr: String; const AStart, AEnd: PtrInt): String;
begin
  SDel:= AStr;
  UTF8Delete(SDel, AStart, AEnd-AStart+1);
end;

function SSymbol(const AStr: String; const ASymbolPos: PtrInt): String;
begin
  SSymbol:= UTF8Copy(AStr, ASymbolPos, 1);
end;

function SSymbolFirst(const AStr: String): String;
begin
  SSymbolFirst:= SSymbol(AStr, 1);
end;

function SSymbolLast(const AStr: String): String;
begin
  SSymbolLast:= SSymbol(AStr, SLength(AStr));
end;

function SDigit(const AStr: String; const ASymbolPos: PtrInt): Byte;
begin
  Result:= StrToInt(SSymbol(AStr, ASymbolPos));
end;

function SRedLine(const ASpacesCount: SizeUInt): String;
var
  i: SizeUInt;
begin
  SRedLine:= EmptyStr;
  for i:= 1 to ASpacesCount do
    SRedLine:= SRedLine + SYMBOL_SPACE;
end;

function SSymbolType(const ASymbol: String): TSymbolType;
begin
  SSymbolType:= stUnknown;
  if SPos(SUpper(ASymbol), SYMBOLS_PUNCTUATION)>0 then SSymbolType:= stPunctuation
    else if SPos(SUpper(ASymbol), SYMBOLS_SEPARATOR)>0 then SSymbolType:= stSeparator
      else if SPos(SUpper(ASymbol), SYMBOLS_VOWEL)>0 then SSymbolType:= stVowel
        else if SPos(SUpper(ASymbol), SYMBOLS_CONSONANT)>0 then SSymbolType:= stConsonant
          else if SPos(SUpper(ASymbol), SYMBOLS_SPECIAL)>0 then SSymbolType:= stSpecial;
end;

function SSymbolType(const AStr: String; const ASymbolPos: PtrInt): TSymbolType;
begin
  SSymbolType:=  SSymbolType(SSymbol(AStr,ASymbolPos));
end;

function SFont(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): TFont;
begin
  SFont:= TFont.Create;
  SFont.Name:= AFontName;
  SFont.Size:= Trunc(AFontSize);
  if SFont.Size<>AFontSize then
    SFont.Size:= SFont.Size + 1;
  SFont.Style:= AFontStyle;
end;

function SWidth(const AStr: String; const AFont: TFont): Integer;
var
  BM: TBitmap;
begin
  BM:= TBitmap.Create;
  try
    BM.Canvas.Font.Assign(AFont);
    SWidth:= BM.Canvas.TextWidth(AStr);
  finally
    FreeAndNil(BM);
  end;
end;

function SWidth(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
var
  F: TFont;
begin
  F:= SFont(AFontName, AFontSize, AFontStyle);
  try
    SWidth:= SWidth(AStr, F);
  finally
    FreeAndNil(F);
  end;
end;

function SHeight(const AStr: String; const AFont: TFont): Integer;
var
  BM: TBitmap;
begin
  BM:= TBitmap.Create;
  try
    BM.Canvas.Font.Assign(AFont);
    SHeight:= BM.Canvas.TextHeight(AStr) + 2;
  finally
    FreeAndNil(BM);
  end;
end;

function SHeight(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
var
  F: TFont;
begin
  F:= SFont(AFontName, AFontSize, AFontStyle);
  try
    SHeight:= SHeight(AStr, F);
  finally
    FreeAndNil(F);
  end;
end;

//вектор слов из текста
function STextToWords(const AText: String): TStrVector;
var
  i, WordBegin, WordEnd, N: PtrInt;
  Text: String;

  procedure AddWord(const AInd1, AInd2: PtrInt);
  var S: String;
  begin
    S:= STrim(SCopy(Text, AInd1, AInd2));
    if not SSame(S, EmptyStr) then
      VAppend(STextToWords, S);
  end;

begin
  STextToWords:= nil;
  Text:= STrim(AText);
  N:= SLength(Text);
  if N=0 then Exit;
  WordBegin:= 1;
  i:= 1;
  while i<N do
  begin
    Inc(i);
    if SSymbolType(SSymbol(Text,i))= stSeparator then
     begin
       WordEnd:= i-1;
       AddWord(WordBegin, WordEnd);
       Inc(i);
       WordBegin:= i;
     end;
  end;
  AddWord(WordBegin, N);
end;

//вектор слогов из слова
function SWordToParts(const AWord: String): TStrVector;
var
  PartsCount, PartEnd: ShortInt;
  WordStr, PartStr: String;

  function IsFirstVowelAndNextTwoConsonant(const W: String): Boolean;
  begin
    IsFirstVowelAndNextTwoConsonant:=  (SSymbolType(W,1)= stVowel) and
                                       (SSymbolType(W,2)= stConsonant) and
                                       (SSymbolType(W,3)= stConsonant);
  end;

  {подсчет кол-ва слогов}
  function CalcPartsCount(const W: String): ShortInt;
  var
    i, L: ShortInt;
  begin
    L:= SLength(W);
    if L<=3 then
    begin
      CalcPartsCount:= 1;
      Exit;
    end;
    CalcPartsCount:= 0;
    //суммируем количество встречающихся гласных (кроме той, что в начале слова)
    for i := 2 to L do
      if SSymbolType(W,i)=stVowel then Inc(CalcPartsCount);
    //если слово начинается с гласной, а после неё следуют две и более согласные, то первую гласную тоже учитываем
    if IsFirstVowelAndNextTwoConsonant(W) then Inc(CalcPartsCount);
     //вычитаем все подряд идущие гласные в окончании слова (кроме одной последней)
    if SSymbolType(W,L)=stVowel then
      for i := L-1 downto 1 do
        if SSymbolType(W,i)=stVowel then Dec(CalcPartsCount) else break;
  end;

  {подсчет индекса последней буквы первого слога}
  function CalcPartEnd(const W: String): ShortInt;
  var
    i, L, VowelPos: ShortInt;
    S: String;
  begin
    //если слово начинается с гласной, а после неё следуют две и более согласные, то можно перенести после первой согласной
    if IsFirstVowelAndNextTwoConsonant(W) then
    begin  //от-Странить
      CalcPartEnd:= 2;
      Exit;
    end;
    L:= SLength(W);
    //определяем, на каком месте в тексте стоит первая гласная буква кроме той, которая начинает слово
    for i := 2 to L do
      if SSymbolType(W,i)=stVowel then
      begin
        VowelPos:= i;
        break;
      end;
    //определяем, какие буквы идут за найденной гласной
    if SSymbolType(W,VowelPos+1)=stVowel then CalcPartEnd:= VowelPos //за-Алел (закат)
    else begin
      if SSymbolType(W,VowelPos+1)=stConsonant then
      begin
        if SUpper(SSymbol(W,VowelPos+1))='Й' then CalcPartEnd:= VowelPos + 1  //воЙ-на
        else begin
          S:= SUpper(SCopy(W, 1, VowelPos));
          if (S='ПРИ') or (S='ПРЕ') then CalcPartEnd:= VowelPos  //ПРИ-слать
          else if SSymbolType(W,VowelPos+2)=stVowel then CalcPartEnd:= VowelPos //за-дАча
          else if SSymbolType(W,VowelPos+2)=stConsonant then CalcPartEnd:= VowelPos + 1  //раз-Брос
          else if SSymbolType(W,VowelPos+2)=stSpecial then CalcPartEnd:= VowelPos + 2; //разЪ-езд
        end;
      end;
    end;
  end;

begin
  SWordToParts:= nil;
  WordStr:= STrim(AWord);
  PartsCount:= CalcPartsCount(WordStr);
  if PartsCount=0 then
  begin
    VAppend(SWordToParts, WordStr);
    Exit;
  end;
  PartEnd:= SLength(WordStr);
  while PartsCount>1 do
  begin
    PartEnd:= CalcPartEnd(WordStr);
    PartStr:= SCopy(WordStr, 1, PartEnd);
    VAppend(SWordToParts, PartStr);
    WordStr:= SDel(WordStr, 1, PartEnd);
    PartEnd:= SLength(WordStr);
    Dec(PartsCount);
  end;
  VAppend(SWordToParts, WordStr);
end;

function STextToCell(var AText: String; const AFont: TFont;
                    const ACellWidth: Integer;
                    const ARedLineWidth: Integer = 0;
                    const AWrapToWordParts: Boolean = False;
                    const AHyphSymbol: String = SYMBOL_HYPH): Integer; //result:= CellHeight
var
  i,j,k, SpaceWidth, CellWidth: Integer;
  Words, WordParts, Lines: TStrVector;
  OldLineStr, OldLineStr2, NewLineStr: String;
begin
  //пустая строка
  AText:= STrim(AText);
  if SSame(AText, EmptyStr) then
  begin
    STextToCell:= SHeight('Х', AFont);
    Exit;
  end;
  //ширина пробела
  SpaceWidth:= SWidth(SYMBOL_SPACE, AFont);
  //ширина ячейки
  CellWidth:= ACellWidth - SpaceWidth;
  //разбиваем текст на слова
  Words:= STextToWords(AText);
  //добавляем красную строку перед первым словом, если нужно
  if ARedLineWidth>0 then
    Words[0]:= SRedLine(ARedLineWidth div SpaceWidth) + Words[0];
  //заполняем строки
  Lines:= nil;
  OldLineStr:= Words[0];
  for i:= 1 to High(Words) do
  begin
    NewLineStr:= OldLineStr + SYMBOL_SPACE + Words[i]; //добавляем пробел и слово
    if SWidth(NewLineStr, AFont)<CellWidth then
      OldLineStr:= NewLineStr
    else begin
      if AWrapToWordParts then //перенос по слогам
      begin
        WordParts:= SWordToParts(Words[i]); //разбиваем слово на слоги
        OldLineStr2:= OldLineStr;
        NewLineStr:= OldLineStr + SYMBOL_SPACE;
        for j:=0 to High(WordParts) do
        begin
          NewLineStr:= NewLineStr + WordParts[j];
          if SWidth(NewLineStr + SYMBOL_CARRY, AFont)<CellWidth then
            OldLineStr2:= NewLineStr
          else begin
            if SSame(OldLineStr, OldLineStr2) then //не поместилось ни одного слога
            begin
              VAppend(Lines, OldLineStr);
              OldLineStr:= Words[i];
            end
            else begin //поместилась какая-то часть слогов
              VAppend(Lines, OldLineStr2 + SYMBOL_CARRY);
              OldLineStr:= EmptyStr;
              for k:= j to High(WordParts) do
                OldLineStr:= OldLineStr + WordParts[k];
            end;
            break;
          end;
        end;
      end
      else begin //сохранять целые слова
        VAppend(Lines, OldLineStr);
        OldLineStr:= Words[i];
      end;
    end;
  end;
  VAppend(Lines, OldLineStr); //последнее значение
  //формируем итоговую строку
  AText:= Lines[0];
  for i:= 1 to High(Lines) do
    AText:= AText + AHyphSymbol + Lines[i];
  //требуемая высота ячейки = кол-во строк * высота одной строки
  STextToCell:= Length(Lines) * SHeight('Х', AFont);
end;

function SFIO(const F, I, O: String): String;
begin
  SFIO:= F + ' ' + SSymbol(I,1) + '.' + SSymbol(O,1) + '.' ;
end;

end.

