unit DK_TextUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, DK_Const, DK_StrUtils, DK_Vector;

 {TextToParts - разбивает текст AText на части, разделенные ADelimiter . Возвращает вектор этих частей}
 function TextToParts(const AText, ADelimiter: String): TStrVector;

 {TextToWords - разбивает текст AText на слова. Возвращает вектор этих слов
  ADivideByHyphen=True - разделяет сложные слова по дефису}
 function TextToWords(const AText: String; const ADivideByHyphen: Boolean): TStrVector;

 {WordToParts - разбивает слово на слоги для возможного переноса на другую строку.
 Возвращает вектор этих слогов.
 Не учитываются слова, не подлежащие переносу (например "узнаю")
 Могут быть ошибки в
 1. сложносокращенных словах (например "спецодежда"),
 2. сложных словах (например "пятиграммовый")}
 function WordToParts(const AWord: String): TStrVector;

 {TextToCell - вставляет в текст AText с шрифтом AFont символы разрыва
 (переноса) строки ABreakSymbol так, чтобы полученные строки умещались в ячейке
 шириной ACellWidth (размерность в px), а также символы пробела шириной
 ARedLineWidth (размерность в px) в начало текста (красная строка).
 Возвращает требуемую высоту ячейки в px.}
 function TextToCell(var AText: String; const AFont: TFont;
                   const ACellWidth: Integer;
                   const ARedLineWidth: Integer = 0;
                   const ADivideByHyphen: Boolean = False;
                   const AWrapToWordParts: Boolean = False;
                   const ABreakSymbol: String = SYMBOL_BREAK): Integer; //result:= CellHeight
 {TextToWidth - разбивает в текст AText с шрифтом AFont на части так,
 чтобы полученные строки умещались в ячейке шириной AWidth (размерность в px),
 а также символы пробела шириной ARedLineWidth (размерность в px)
 в начало текста (красная строка).
 Записывает требуемую высоту ячейки в px в AHeight, вектор получившихся
 частей в ARows}
 procedure TextToWidth(const AText: String; const AFont: TFont; const AWidth: Integer;
                  out AHeight: Integer;
                  out ARows: TStrVector;
                  const ADivideByHyphen: Boolean;
                  const AWrapToWordParts: Boolean = False;
                  const ARedLineWidth: Integer = 0);


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
function TextToWords(const AText: String; const ADivideByHyphen: Boolean): TStrVector;
var
  i, WordBegin, WordEnd, N: PtrInt;
  Text, S: String;
  IsWordEnd: Boolean;
begin
  Result:= nil;
  Text:= STrim(AText);
  N:= SLength(Text);
  if N=0 then Exit;
  WordBegin:= 1;
  IsWordEnd:= False;
  i:= 1;
  while i<N do
  begin
    Inc(i);
    if SSymbolType(SSymbol(Text,i))= stSeparator then
    begin
      WordEnd:= i-1;
      IsWordEnd:= True;
    end
    else if ADivideByHyphen and SIsHyphenSymbol(SSymbol(Text,i)) then
    begin
      WordEnd:= i;
      IsWordEnd:= True;
    end;
    if IsWordEnd then
    begin
      S:= STrim(SCopy(Text, WordBegin, WordEnd));
      if not SSame(S, EmptyStr) then
        VAppend(Result, S);
      Inc(i);
      WordBegin:= i;
      IsWordEnd:= False;
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

procedure TextToWidth(const AText: String; const AFont: TFont; const AWidth: Integer;
                  out AHeight: Integer;
                  out ARows: TStrVector;
                  const ADivideByHyphen: Boolean;
                  const AWrapToWordParts: Boolean = False;
                  const ARedLineWidth: Integer = 0);
var
  i, SpaceWidth, RowWidth, TmpWidth: Integer;
  Words, RowValues: TStrVector;
  OldRowValue, NewRowValue: String;

  procedure DoWrapWord(const AWord: String; const ARowWidth: Integer;
                       out ARowValues: TStrVector;
                       const ANeedWritePartIfNotFit: Boolean = True;
                       const ANeedCarrySymbolAfterFirst: Boolean = True);
  var
    n: Integer;
    WordParts: TStrVector;
    OldValue, NewValue: String;
  begin
    ARowValues:= nil;
    WordParts:= WordToParts(AWord);
    NewValue:= EmptyStr;
    OldValue:= EmptyStr;
    n:= 0;
    while n<=High(WordParts) do
    begin
      NewValue:= NewValue + WordParts[n];
      if SWidth(NewValue + SYMBOL_HYPHEN, AFont)<ARowWidth then
      begin
        OldValue:= NewValue;
        n:= n + 1;
      end
      else begin
        if SEmpty(OldValue) then
        begin
          if not ANeedWritePartIfNotFit then
          begin
            ARowValues:= nil;
            Exit;
          end;

          OldValue:= NewValue;
          n:= n + 1;
        end;
        if VIsNil(ARowValues) or ANeedCarrySymbolAfterFirst then
          VAppend(ARowValues, OldValue + SYMBOL_HYPHEN)
        else
          VAppend(ARowValues, OldValue);
        NewValue:= EmptyStr;
        OldValue:= EmptyStr;
      end;
    end;
    VAppend(ARowValues, OldValue);
  end;

begin
  AHeight:= 0;
  ARows:= nil;
  if SEmpty(AText) then Exit;

  //ширина пробела
  SpaceWidth:= SWidth(SYMBOL_SPACE, AFont);
  //ширина ячейки
  RowWidth:= AWidth - SpaceWidth;
  //разбиваем текст на слова
  Words:= TextToWords(Strim(AText), ADivideByHyphen);
  //добавляем красную строку перед первым словом, если нужно
  if ARedLineWidth>0 then
    Words[0]:= SRedLine(ARedLineWidth div SpaceWidth) + Words[0];

  if (Length(Words)=1)  then
  begin
    if AWrapToWordParts then
    begin
      DoWrapWord(Words[0], RowWidth, RowValues, True, True);
      ARows:= RowValues;
    end
    else
      VAppend(ARows, Words[0]);
  end
  else begin
    i:= 0;
    OldRowValue:= EmptyStr;
    while i<=High(Words) do
    begin
       if SEmpty(OldRowValue) then
         NewRowValue:= Words[i]
       else
         NewRowValue:= OldRowValue + SYMBOL_SPACE + Words[i]; //добавляем пробел и слово
       TmpWidth:= SWidth(NewRowValue, AFont);
       if TmpWidth<RowWidth then
       begin
         //если уместилось - запоминаем и переходим к следующему слову
         OldRowValue:= NewRowValue;
         i:= i + 1;
       end
       else begin
         //не уместилось
         if AWrapToWordParts then  //переносим слово по слогам
         begin
           TmpWidth:= RowWidth - SWidth(OldRowValue+SYMBOL_SPACE, AFont);
           DoWrapWord(Words[i], TmpWidth, RowValues, False, False);
           if not VIsNil(RowValues) then
           begin
             VAppend(ARows, OldRowValue+SYMBOL_SPACE+RowValues[0]);
             OldRowValue:= VSum(RowValues, 1);
             i:= i + 1;
           end
           else begin
             VAppend(ARows, OldRowValue);
             OldRowValue:= EmptyStr;
           end;
         end
         else begin //записываем все до предыдущего слова
           if SEmpty(OldRowValue) then //слово вообще не умещается - записываем, т.к. нет иного выхода
           begin
             OldRowValue:= NewRowValue;
             i:= i + 1;
           end;
           VAppend(ARows, OldRowValue);
           OldRowValue:= EmptyStr;
         end;
       end;
    end;
    VAppend(ARows, OldRowValue); //последнее значение
  end;

  AHeight:= SHeight(AFont) * Length(ARows) + 2;
end;

function TextToCell(var AText: String; const AFont: TFont;
                    const ACellWidth: Integer;
                    const ARedLineWidth: Integer = 0;
                    const ADivideByHyphen: Boolean = False;
                    const AWrapToWordParts: Boolean = False;
                    const ABreakSymbol: String = SYMBOL_BREAK): Integer; //result:= CellHeight
var
  TotalHeight: Integer;
  RowValues: TStrVector;
begin
  TextToWidth(AText, AFont, ACellWidth, TotalHeight, RowValues,
              ADivideByHyphen, AWrapToWordParts, ARedLineWidth);

  if TotalHeight>0 then
  begin
    AText:= VVectorToStr(RowValues, ABreakSymbol);
    Result:= TotalHeight;
  end
  else begin
    Result:= SHeight(AFont);
  end;
end;

end.

