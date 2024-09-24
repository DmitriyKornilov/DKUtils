unit DK_StrUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, Graphics, RegExpr, Math, DK_Const;

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
  function SPos(const AStr, AValue: String; const AStartPos: Integer = 1; const ACaseSensitivity: Boolean = True): Integer;
  function SFind(const AStr, AValue: String; const ACaseSensitivity: Boolean = True): Boolean;
  function SCopy(const AStr: String; const AStart, AEnd: Integer): String;
  function SCopyCount(const AStr: String; const AStart, ACount: Integer): String;
  function SDivide(const AStr: String; const ADivideSymbol: String; out APart1, APart2: String): Boolean;
  function SDel(const AStr: String; const AStart, AEnd: Integer): String;
  function SDelCount(const AStr: String; const AStart, ACount: Integer): String;
  function SSymbol(const AStr: String; const ASymbolPos: Integer): String;
  function SSymbolFirst(const AStr: String): String;
  function SSymbolLast(const AStr: String): String;
  function SDigit(const AStr: String; const ASymbolPos: Integer): Byte;
  function SIsDigit(const ASymbol: String): Boolean;
  function SDigits(const AStr: String): String;
  function SRepeat(const ACount: Integer; const AStr: String): String;
  function SRedLine(const ASpacesCount: Integer): String;
  function SFillRight(const AStr: String; const ANeedLength: Integer; const AFillStr: String = SYMBOL_SPACE): String;
  function SFillLeft(const AStr: String; const ANeedLength: Integer; const AFillStr: String = SYMBOL_SPACE): String;
  function SSymbolType(const ASymbol: String): TSymbolType;
  function SSymbolType(const AStr: String; const ASymbolPos: Integer): TSymbolType;
  function SIsHyphenSymbol(const ASymbol: String): Boolean;
  function SFont(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): TFont;
  function SWidth(const AStr: String; const AFont: TFont): Integer;
  function SWidth(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
  function SHeight(const AFont: TFont): Integer;
  function SHeight(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
  function SMetric(const AFont: TFont): TLCLTextMetric;
  function SNameLong(const AFamily, AName, APatronymic: String): String;
  function SNameShort(const AFamily, AName, APatronymic: String): String;
  function SRusQuoted(const AStr: String): String;
  function SNameShort(const AFullName: String): String;
  function SFileName(const AFileName, AExtention: String): String;
  function SFileNameCheck(const AFileName, ASymbolInsteadBad: String): String;
  function SReplace(const AStr, AOld, ANew: String; const ACaseSensitivity: Boolean = True;
                    const AMaxReplaceCount: Integer = 0 {replace all} ): String;
  function SFromStrings(const AStrings: TStrings; const ADelimiter: String = SYMBOL_SPACE): String;
  procedure SToStrings(const AStr: String; const AStrings: TStrings; const ADelimiter: String);
  function SDate(const AStr: String): String;
  function SFit(const AStr, AEnd: String; const AWidth: Integer; const AFont: TFont): String;

implementation

uses DK_Vector;

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

function SPos(const AStr, AValue: String; const AStartPos: Integer = 1; const ACaseSensitivity: Boolean = True): Integer;
begin
  if ACaseSensitivity then
    Result:= UTF8Pos(AValue, AStr, AStartPos)
  else
    Result:= UTF8Pos(SUpper(AValue), SUpper(AStr), AStartPos);
end;

function SFind(const AStr, AValue: String; const ACaseSensitivity: Boolean): Boolean;
begin
  if ACaseSensitivity then
    Result:= SPos(AStr, AValue)>0
  else
    Result:= SPos(SUpper(AStr), SUpper(AValue))>0;
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

function SIsDigit(const ASymbol: String): Boolean;
begin
  Result:= SFind(SYMBOLS_DIGITS, ASymbol);
end;

function SDigits(const AStr: String): String;
var
  i: Integer;
  S: String;
begin
  Result:= EmptyStr;
  for i:= 1 to SLength(AStr) do
  begin
    S:= SSymbol(AStr, i);
    if SIsDigit(S) then
      Result:= Result + S;
  end;
end;

function SRepeat(const ACount: Integer; const AStr: String): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  for i:= 1 to ACount do
    Result:= Result + AStr;
end;

function SRedLine(const ASpacesCount: Integer): String;
begin
  Result:= SRepeat(ASpacesCount, SYMBOL_SPACE);
end;

function GetFillStr(const AStr: String; const ANeedLength: Integer; const AFillStr: String): String;
var
  n, k: Integer;
begin
  Result:= EmptyStr;
  n:= ANeedLength - SLength(AStr);
  if (n<=0) or SEmpty(AFillStr) then Exit;
  k:= Ceil(n/SLength(AFillStr));
  Result:= SRepeat(k, AFillStr);
  if SLength(Result)>n then
    Result:= SCopyCount(Result, 1, n);
end;

function SFillRight(const AStr: String; const ANeedLength: Integer; const AFillStr: String = SYMBOL_SPACE): String;
begin
  Result:= AStr + GetFillStr(AStr, ANeedLength, AFillStr);
end;

function SFillLeft(const AStr: String; const ANeedLength: Integer; const AFillStr: String = SYMBOL_SPACE): String;
begin
  Result:= GetFillStr(AStr, ANeedLength, AFillStr) + AStr;
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

function SIsHyphenSymbol(const ASymbol: String): Boolean;
begin
  Result:= SSame(ASymbol, SYMBOL_HYPHEN);
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
  if not SEmpty(AName) then
    Result:= Result + ' ' + AName;
  if not SEmpty(APatronymic) then
    Result:= Result + ' ' + APatronymic;
end;

function SNameShort(const AFamily, AName, APatronymic: String): String;
begin
  Result:= AFamily;
  if not SEmpty(AName) then
    Result:= Result + ' ' + SCopy(AName, 1, 1) + '.';
  if not SEmpty(APatronymic) then
    Result:= Result + SCopy(APatronymic, 1, 1) + '.';
end;

function SRusQuoted(const AStr: String): String;
begin
  Result:= EmptyStr;
  if SEmpty(AStr) then Exit;
  Result:= SYMBOL_QUOTELEFT + AStr + SYMBOL_QUOTERIGHT;
end;

function SNameShort(const AFullName: String): String;
var
  V: TStrVector;
begin
  Result:= EmptyStr;
  V:= VStrToVector(AFullName, SYMBOL_SPACE);
  if VIsNil(V) then Exit;
  Result:= STrim(SFirstUpper(V[0]));
  if Length(V)>1 then
    Result:= Result + SYMBOL_SPACE + SUpper(SSymbolFirst(STrim(V[1]))) + '.';
  if Length(V)>2 then
    Result:= Result + SUpper(SSymbolFirst(STrim(V[2]))) + '.';
end;

function SFileName(const AFileName, AExtention: String): String;
var
  N: Integer;
  S: String;
begin
  Result:= AFileName;
  N:= SLength(AExtention);
  S:= SRight(AFileName, N);
  if not SSame(S, AExtention) then
    Result:= Result + '.' + AExtention;
end;

function SFileNameCheck(const AFileName, ASymbolInsteadBad: String): String;
var
  i, n: Integer;
begin
  Result:= EmptyStr;
  if SEmpty(AFileName) then Exit;
  n:= SLength(SYMBOLS_BADFILENAME);
  Result:= AFileName;
  for i:= 1 to n do
    Result:= SReplace(Result, SSymbol(SYMBOLS_BADFILENAME, i), ASymbolInsteadBad);
end;

function SReplace(const AStr, AOld, ANew: String;
                  const ACaseSensitivity: Boolean = True;
                  const AMaxReplaceCount: Integer = 0 {replace all}): String;
var
  V: TStrVector;
begin
  V:= VStrToVector(AStr, AOld, ACaseSensitivity);
  if Length(V)<=1 then
    Result:= AStr
  else if AMaxReplaceCount=0 then
    Result:= VVectorToStr(V, ANew)
  else if High(V)<=AMaxReplaceCount then
    Result:= VVectorToStr(V, ANew)
  else
    Result:= VVectorToStr(VCut(V,0,AMaxReplaceCount), ANew) + AOld +
             VVectorToStr(VCut(V,AMaxReplaceCount+1), AOld);
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

function SDate(const AStr: String): String;
var
  RegExpr: TRegExpr;
begin
  Result:= EmptyStr;
  RegExpr:= TRegExpr.Create;
  try
    RegExpr.Expression := '\d{1,4}[\/.-]\d{1,2}[\/.-]\d{1,4}';
    if RegExpr.Exec(AStr) then
      Result:= RegExpr.Match[0];
  finally
    FreeAndNil(RegExpr);
  end;
end;

function SFit(const AStr, AEnd: String; const AWidth: Integer; const AFont: TFont): String;
var
  MaxWidth, i: Integer;
  CutStr, NextSymbol: String;
begin
  MaxWidth:= AWidth;

  if SWidth(AStr, AFont)<=MaxWidth then
    Result:= AStr
  else begin
    MaxWidth:= MaxWidth - SWidth(AEnd, AFont);
    CutStr:= SSymbol(AStr, 1);
    for i:=2 to SLength(AStr) do
    begin
      NextSymbol:= SSymbol(AStr, i);
      if SWidth(CutStr+NextSymbol, AFont)>MaxWidth then
        break
      else
        CutStr:= CutStr + NextSymbol;
    end;
    Result:= CutStr + AEnd;
  end;
end;

end.

