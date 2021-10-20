unit DK_TextUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, DK_Const, DK_StrUtils, DK_Vector;

 {TextToParts - разбивает текст AText на части, разделенные ADelimiter . Возвращает вектор этих частей}
 function TextToParts(const AText, ADelimiter: String): TStrVector;

 {TextToWords - разбивает текст AText на слова. Возвращает вектор этих слов}
 function TextToWords(const AText: String): TStrVector;

 {WordToParts - разбивает слово на слоги для возможного переноса на другую строку.
 Возвращает вектор этих слогов.
 Не учитываются слова, не подлежащие переносу (например "узнаю")
 Могут быть ошибки в
 1. сложносокращенных словах (например "спецодежда"),
 2. сложных словах (например "пятиграммовый")}
 function WordToParts(const AWord: String): TStrVector;

 {TextToCell - вставляет в текст AText с шрифтом AFont символы разрыва
 (переноса) строки ABreakSymbol так, чтобы полученные строки умещались в ячейке
 шириной ACellWidth (размерность в px), а также символы пробела количеством
 ARedLineWidth в начало текста (красная строка).
 Возвращает требуемую высоту ячейки в px.}
 function TextToCell(var AText: String; const AFont: TFont;
                   const ACellWidth: Integer;
                   const ARedLineWidth: Integer = 0;
                   const AWrapToWordParts: Boolean = False;
                   const ABreakSymbol: String = SYMBOL_BREAK): Integer; //result:= CellHeight

 {Фамилия Имя Отчество -> Фамилия И.О.}
 function SurnameNP(const ASurname, AName, APatronymic: String): String;

implementation

function TextToParts(const AText, ADelimiter: String): TStrVector;
var
  N, PartBegin, PartEnd: PtrInt;
  Text, S: String;
begin
  Result:= nil;
  Text:= STrim(AText);
  PartBegin:= 1;
  N:= SPos(Text, ADelimiter, PartBegin);
  while N>0 do
  begin
    PartEnd:= N-1;
    S:= SCopy(Text, PartBegin, PartEnd);
    if not SSame(S, EmptyStr) then
      VAppend(Result, S);
    PartBegin:= N + SLength(ADelimiter);
    N:= SPos(Text, ADelimiter, PartBegin);
  end;
  S:= SCopy(Text, PartBegin, SLength(Text));
  if not SSame(S, EmptyStr) then
    VAppend(Result, S);
end;

//вектор слов из текста
function TextToWords(const AText: String): TStrVector;
var
  i, WordBegin, WordEnd, N: PtrInt;
  Text, S: String;
begin
  Result:= nil;
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
      S:= STrim(SCopy(Text, WordBegin, WordEnd));
      if not SSame(S, EmptyStr) then
        VAppend(Result, S);
      Inc(i);
      WordBegin:= i;
    end;
  end;
  S:= STrim(SCopy(Text, WordBegin, N));
  if not SSame(S, EmptyStr) then
    VAppend(Result, S);
end;

//вектор слогов из слова
function WordToParts(const AWord: String): TStrVector;
var
  PartsCount, PartEnd: ShortInt;
  WordStr, PartStr: String;

  function IsFirstVowelAndNextTwoConsonant(const W: String): Boolean;
  begin
    Result:= (SSymbolType(W,1)= stVowel) and
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
      Result:= 1;
      Exit;
    end;
    Result:= 0;
    //суммируем количество встречающихся гласных (кроме той, что в начале слова)
    for i := 2 to L do
      if SSymbolType(W,i)=stVowel then Inc(Result);
    //если слово начинается с гласной, а после неё следуют две и более согласные, то первую гласную тоже учитываем
    if IsFirstVowelAndNextTwoConsonant(W) then Inc(Result);
     //вычитаем все подряд идущие гласные в окончании слова (кроме одной последней)
    if SSymbolType(W,L)=stVowel then
      for i := L-1 downto 1 do
        if SSymbolType(W,i)=stVowel then Dec(Result) else break;
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
      Result:= 2;
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
    if SSymbolType(W,VowelPos+1)=stVowel then Result:= VowelPos //за-Алел (закат)
    else begin
      if SSymbolType(W,VowelPos+1)=stConsonant then
      begin
        if SUpper(SSymbol(W,VowelPos+1))='Й' then Result:= VowelPos + 1  //воЙ-на
        else begin
          S:= SUpper(SCopy(W, 1, VowelPos));
          if (S='ПРИ') or (S='ПРЕ') then Result:= VowelPos  //ПРИ-слать
          else if SSymbolType(W,VowelPos+2)=stVowel then Result:= VowelPos //за-дАча
          else if SSymbolType(W,VowelPos+2)=stConsonant then Result:= VowelPos + 1  //раз-Брос
          else if SSymbolType(W,VowelPos+2)=stSpecial then Result:= VowelPos + 2; //разЪ-езд
        end;
      end;
    end;
  end;

begin
  Result:= nil;
  WordStr:= STrim(AWord);
  PartsCount:= CalcPartsCount(WordStr);
  if PartsCount=0 then
  begin
    VAppend(Result, WordStr);
    Exit;
  end;
  PartEnd:= SLength(WordStr);
  while PartsCount>1 do
  begin
    PartEnd:= CalcPartEnd(WordStr);
    PartStr:= SCopy(WordStr, 1, PartEnd);
    VAppend(Result, PartStr);
    WordStr:= SDel(WordStr, 1, PartEnd);
    PartEnd:= SLength(WordStr);
    Dec(PartsCount);
  end;
  if not SSame(WordStr, EmptyStr) then
    if (SLength(WordStr)=1) and (not VIsNil(Result)) then
      Result[High(Result)]:= Result[High(Result)] + WordStr
    else
      VAppend(Result, WordStr);
end;

function TextToCell(var AText: String; const AFont: TFont;
                    const ACellWidth: Integer;
                    const ARedLineWidth: Integer = 0;
                    const AWrapToWordParts: Boolean = False;
                    const ABreakSymbol: String = SYMBOL_BREAK): Integer; //result:= CellHeight
var
  i,j,k, SpaceWidth, CellWidth: Integer;
  Words, WordParts, Lines: TStrVector;
  OldLineStr, OldLineStr2, NewLineStr: String;
begin
  //пустая строка
  AText:= STrim(AText);
  if SSame(AText, EmptyStr) then
  begin
    Result:= SHeight('Х', AFont);
    Exit;
  end;
  //ширина пробела
  SpaceWidth:= SWidth(SYMBOL_SPACE, AFont);
  //ширина ячейки
  CellWidth:= ACellWidth - SpaceWidth;
  //разбиваем текст на слова
  Words:= TextToWords(AText);
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
        WordParts:= WordToParts(Words[i]); //разбиваем слово на слоги
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
    AText:= AText + ABreakSymbol + Lines[i];
  //требуемая высота ячейки = кол-во строк * высота одной строки
  Result:= Length(Lines) * SHeight('Х', AFont);
end;

function SurnameNP(const ASurname, AName, APatronymic: String): String;
begin
  Result:= ASurname + ' ' + SSymbol(AName,1) + '.' + SSymbol(APatronymic,1) + '.' ;
end;

end.

