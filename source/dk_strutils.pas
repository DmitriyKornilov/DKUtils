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
  function SLower(const AStr: String): String;
  function STrim(const AStr: String): String;
  function SCut(const AStr: String; const ALeftCount, ARightCount: Integer): String;
  function SCutRight(const AStr: String; const ACount: Integer): String;
  function SCutLeft(const AStr: String; const ACount: Integer): String;
  function SSame(const AStr1, AStr2: String): Boolean;
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
  function SSymbolType(const ASymbol: String): TSymbolType;
  function SSymbolType(const AStr: String; const ASymbolPos: Integer): TSymbolType;
  function SFont(const AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): TFont;
  function SWidth(const AStr: String; const AFont: TFont): Integer;
  function SWidth(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;
  function SHeight(const AStr: String; const AFont: TFont): Integer;
  function SHeight(const AStr, AFontName: String; const AFontSize: Single; const AFontStyle: TFontStyles=[]): Integer;

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

function SLower(const AStr: String): String;
begin
  Result:= UTF8LowerCase(AStr);
end;

function STrim(const AStr: String): String;
begin
  Result:= UTF8Trim(AStr);
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

function SSame(const AStr1, AStr2: String): Boolean;
begin
  Result:= UTF8CompareStr(AStr1, AStr2)=0;
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
    Result:= Round(BM.Canvas.TextWidth(AStr)*96/AFont.PixelsPerInch);
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

function SHeight(const AStr: String; const AFont: TFont): Integer;
var
  BM: TBitmap;
begin
  BM:= TBitmap.Create;
  try
    BM.Canvas.Font.Assign(AFont);
    Result:= BM.Canvas.TextHeight(AStr) + 2;
    //Result:= Round(BM.Canvas.TextHeight(AStr)*96/AFont.PixelsPerInch) + 2;
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
    Result:= SHeight(AStr, F);
  finally
    FreeAndNil(F);
  end;
end;



end.

