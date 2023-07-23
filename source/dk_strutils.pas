unit DK_StrUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, Graphics, DK_Const;

type
  TSymbolType = (stUnknown, stPunctuation, stSeparator, stVowel, stConsonant, stSpecial);

  function SSetUTF8(const AStr: String): String;
  function SLength(const AStr: String): Integer;
  function SUpper(const AStr: String): String;
  function SFirstUpper(const AStr: String): String;
  function SLower(const AStr: String): String;
  function SFirstLower(const AStr: String): String;
  function STrim(const AStr: String): String;
  function STrimRight(const AStr: String): String;
  function STrimLeft(const AStr: String): String;
  function SCut(const AStr: String; const ALeftCount, ARightCount: Integer): String;
  function SCutRight(const AStr: String; const ACount: Integer): String;
  function SCutLeft(const AStr: String; const ACount: Integer): String;
  function SRight(const AStr: String; const ACount: Integer): String;
  function SLeft(const AStr: String; const ACount: Integer): String;
  function SSame(const AStr1, AStr2: String; const ACaseSensitivity: Boolean = True): Boolean;
  function SEmpty(const AStr: String): Boolean;
  function SCompare(const AStr1, AStr2: String; const ACaseSensitivity: Boolean = True): Integer;
  function SPos(const AStr, AValue: String; const AStartPos: Integer = 1): Integer;
  function SCopy(const AStr: String; const AStart, AEnd: Integer): String;
  function SCopyCount(const AStr: String; const AStart, ACount: Integer): String;
  function SDivide(const AStr: String; const ADivideSymbol: String; out APart1, APart2: String): Boolean;
  function SDel(const AStr: String; const AStart, AEnd: Integer): String;
  function SDelCount(const AStr: String; const AStart, ACount: Integer): String;
  function SSymbol(const AStr: String; const ASymbolPos: Integer): String;
  function SSymbolFirst(const AStr: String): String;
  function SSymbolLast(const AStr: String): String;
  function SDigit(const AStr: String; const ASymbolPos: Integer): Byte;
  function SRedLine(const ASpacesCount: Integer): String;
  function SFillRight(const AStr: String; const ANeedLength: Integer): String;
  function SFillLeft(const AStr: String; const ANeedLength: Integer): String;
  function SSymbolType(const ASymbol: String): TSymbolType;
  function SSymbolType(const AStr: String; const ASymbolPos: Integer): TSymbolType;
  function SFont(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): TFont;
  function SWidth(const AStr: String; const AFont: TFont): Integer;
  function SWidth(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
  function SHeight(const AFont: TFont): Integer;
  function SHeight(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
  function SMetric(const AFont: TFont): TLCLTextMetric;
  function SNameLong(const AFamily, AName, APatronymic: String): String;
  function SNameShort(const AFamily, AName, APatronymic: String): String;
  function SFileName(const AFileName, AExtention: String): String;
  function SFromStrings(const AStrings: TStrings; const ADelimiter: String = SYMBOL_SPACE): String;
  procedure SToStrings(const AStr: String; const AStrings: TStrings; const ADelimiter: String);

implementation

function SSetUTF8(const AStr: String): String;
var
  Raw: RawByteString;
begin
  Raw:= AStr;
  SetCodePage(Raw, CP_NONE, False);
  SetCodePage(Raw, CP_UTF8, True);
  Result:= Raw;
end;

function SLength(const AStr: String): Integer;
begin
  Result:= UTF8Length(AStr);
end;

function SUpper(const AStr: String): String;
begin
  Result:= UTF8UpperCase(AStr);
end;

function SFirstUpper(const AStr: String): String;
begin
  Result:= SUpper(SSymbol(AStr, 1)) + SCutLeft(AStr, 1);
end;

function SLower(const AStr: String): String;
begin
  Result:= UTF8LowerCase(AStr);
end;

function SFirstLower(const AStr: String): String;
begin
  Result:= SLower(SSymbol(AStr, 1)) + SCutLeft(AStr, 1);
end;

function STrim(const AStr: String): String;
begin
  Result:= UTF8Trim(AStr);
end;

function STrimRight(const AStr: String): String;
begin
  Result:= UTF8Trim(AStr, [u8tKeepStart]);
end;

function STrimLeft(const AStr: String): String;
begin
  Result:= UTF8Trim(AStr, [u8tKeepEnd]);
end;

function SCut(const AStr: String; const ALeftCount, ARightCount: Integer): String;
begin
  Result:= SCopyCount(AStr, ALeftCount+1, SLength(AStr)-ARightCount);
end;

function SCutRight(const AStr: String; const ACount: Integer): String;
begin
  Result:= SCopyCount(AStr, 1, SLength(AStr)-ACount);
end;

function SCutLeft(const AStr: String; const ACount: Integer): String;
begin
  Result:= SCopyCount(AStr, ACount+1, SLength(AStr));
end;

function SRight(const AStr: String; const ACount: Integer): String;
begin
  Result:= SCopyCount(AStr, SLength(AStr)-ACount+1, ACount);
end;

function SLeft(const AStr: String; const ACount: Integer): String;
begin
  Result:= SCopyCount(AStr, 1, ACount);
end;

function SSame(const AStr1, AStr2: String; const ACaseSensitivity: Boolean = True): Boolean;
begin
  Result:= SCompare(AStr1, AStr2, ACaseSensitivity)=0;
end;

function SEmpty(const AStr: String): Boolean;
begin
  Result:= SSame(AStr, EmptyStr);
end;

function SCompare(const AStr1, AStr2: String; const ACaseSensitivity: Boolean = True): Integer;
begin
  if ACaseSensitivity then
    Result:= UTF8CompareStr(AStr1, AStr2)
  else
    Result:= UTF8CompareStr(SUpper(AStr1), SUpper(AStr2));
end;

function SPos(const AStr, AValue: String; const AStartPos: Integer = 1): Integer;
begin
  Result:= UTF8Pos(AValue, AStr, AStartPos);
end;

function SCopy(const AStr: String; const AStart, AEnd: Integer): String;
begin
  Result:= UTF8Copy(AStr, AStart, AEnd-AStart+1);
end;

function SCopyCount(const AStr: String; const AStart, ACount: Integer): String;
begin
  Result:= UTF8Copy(AStr, AStart, ACount);
end;

function SDivide(const AStr: String; const ADivideSymbol: String; out APart1, APart2: String): Boolean;
var
  N: Integer;
begin
  Result:= False;
  APart1:= AStr;
  APart2:= EmptyStr;
  N:= SPos(AStr, ADivideSymbol);
  if N>0 then
  begin
    APart1:= SCopy(AStr,1, N-1);
    APart2:= SCopy(AStr,N+1, SLength(AStr));
    Result:= True;
  end;
end;

function SDel(const AStr: String; const AStart, AEnd: Integer): String;
begin
  Result:= AStr;
  UTF8Delete(Result, AStart, AEnd-AStart+1);
end;

function SDelCount(const AStr: String; const AStart, ACount: Integer): String;
begin
  Result:= AStr;
  UTF8Delete(Result, AStart, ACount);
end;

function SSymbol(const AStr: String; const ASymbolPos: Integer): String;
begin
  Result:= UTF8Copy(AStr, ASymbolPos, 1);
end;

function SSymbolFirst(const AStr: String): String;
begin
  Result:= SSymbol(AStr, 1);
end;

function SSymbolLast(const AStr: String): String;
begin
  Result:= SSymbol(AStr, SLength(AStr));
end;

function SDigit(const AStr: String; const ASymbolPos: Integer): Byte;
begin
  Result:= StrToInt(SSymbol(AStr, ASymbolPos));
end;

function SRedLine(const ASpacesCount: Integer): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  for i:= 1 to ASpacesCount do
    Result:= Result + SYMBOL_SPACE;
end;

function SFillRight(const AStr: String; const ANeedLength: Integer): String;
var
  n: Integer;
begin
  n:= ANeedLength - Length(AStr);
  if n<=0 then
    Result:= AStr
  else
    Result:= AStr + SRedLine(n);
end;

function SFillLeft(const AStr: String; const ANeedLength: Integer): String;
var
  n: Integer;
begin
  n:= ANeedLength - Length(AStr);
  if n<=0 then
    Result:= AStr
  else
    Result:= SRedLine(n) + AStr;
end;

function SSymbolType(const ASymbol: String): TSymbolType;
begin
  Result:= stUnknown;
  if SPos(SYMBOLS_PUNCTUATION, SUpper(ASymbol))>0 then Result:= stPunctuation
    else if SPos(SYMBOLS_SEPARATOR, SUpper(ASymbol))>0 then Result:= stSeparator
      else if SPos(SYMBOLS_VOWEL, SUpper(ASymbol))>0 then Result:= stVowel
        else if SPos(SYMBOLS_CONSONANT, SUpper(ASymbol))>0 then Result:= stConsonant
          else if SPos(SYMBOLS_SPECIAL, SUpper(ASymbol))>0 then Result:= stSpecial;
end;

function SSymbolType(const AStr: String; const ASymbolPos: Integer): TSymbolType;
begin
  Result:=  SSymbolType(SSymbol(AStr,ASymbolPos));
end;

function SFont(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): TFont;
begin
  Result:= TFont.Create;
  Result.Name:= AFontName;
  Result.Size:= Trunc(AFontSize);
  if Result.Size<>AFontSize then
    Result.Size:= Result.Size + 1;
  Result.Style:= AFontStyle;
end;

function SWidth(const AStr: String; const AFont: TFont): Integer;
var
  BM: TBitmap;
begin
  BM:= TBitmap.Create;
  try
    BM.Canvas.Font.Assign(AFont);
    Result:= BM.Canvas.TextWidth(AStr) + 2;
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
    Result:= SWidth(AStr, F);
  finally
    FreeAndNil(F);
  end;
end;

function SHeight(const AFont: TFont): Integer;
var
  BM: TBitmap;
begin
  BM:= TBitmap.Create;
  try
    BM.Canvas.Font.Assign(AFont);
    Result:= BM.Canvas.TextHeight('X') + 2;
  finally
    FreeAndNil(BM);
  end;
end;

function SHeight(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
var
  F: TFont;
begin
  F:= SFont(AFontName, AFontSize, AFontStyle);
  try
    Result:= SHeight(F);
  finally
    FreeAndNil(F);
  end;
end;

function SMetric(const AFont: TFont): TLCLTextMetric;
var
  BM: TBitmap;
begin
  BM:= TBitmap.Create;
  try
    BM.Canvas.Font.Assign(AFont);
    BM.Canvas.GetTextMetrics(Result);
  finally
    FreeAndNil(BM);
  end;
end;

function SNameLong(const AFamily, AName, APatronymic: String): String;
begin
  Result:= AFamily;
  if not SSame(AName, EmptyStr) then
    Result:= Result + ' ' + AName;
  if not SSame(APatronymic, EmptyStr) then
    Result:= Result + ' ' + APatronymic;
end;

function SNameShort(const AFamily, AName, APatronymic: String): String;
begin
  Result:= AFamily;
  if not SSame(AName, EmptyStr) then
    Result:= Result + ' ' + SCopy(AName, 1, 1) + '.';
  if not SSame(APatronymic, EmptyStr) then
    Result:= Result + SCopy(APatronymic, 1, 1) + '.';
end;

function SFileName(const AFileName, AExtention: String): String;
var
  N: Integer;
  S: String;
begin
  Result:= AFileName;
  N:= Length(AExtention);
  S:= SRight(AFileName, N);
  if not SSame(S, AExtention) then
    Result:= Result + '.' + AExtention;
end;

function SFromStrings(const AStrings: TStrings; const ADelimiter: String = SYMBOL_SPACE): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  if AStrings.Count<=0 then Exit;
  Result:= AStrings[0];
  for i:= 1 to AStrings.Count-1 do
  Result:= Result + ADelimiter + AStrings[i];
end;

procedure SToStrings(const AStr: String; const AStrings: TStrings; const ADelimiter: String);
var
  S: String;
  n, LDelimiter: Integer;
begin
  if not Assigned(AStrings) then Exit;
  AStrings.Clear;
  if SLength(AStr)=0 then Exit;

  LDelimiter:= SLength(ADelimiter);
  if (LDelimiter=0) then
  begin
    AStrings.Append(AStr);
    Exit;
  end;

  S:= AStr;
  n:= SPos(S, ADelimiter);
  while n>0 do
  begin
    if n=1 then
      S:= SDel(S, 1, LDelimiter)
    else begin
      AStrings.Append(SCopy(S, 1, n-1));
      S:= SDel(S, 1, n+LDelimiter-1);
    end;
    n:= SPos(S, ADelimiter);
  end;

  if SLength(S)>0 then
    AStrings.Append(S);
end;

end.

