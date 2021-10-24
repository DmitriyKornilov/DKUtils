unit DK_Fonts;

{$mode objfpc}{$H+}

interface

uses
  {Classes, SysUtils, Forms,} Controls, Graphics;

const
  ARIAL_FONTS: array [0..2] of String =
    ('Arial', 'Liberation Sans', 'Nimbus Sans L');

  TIMES_FONTS: array [0..2] of String =
    ('Times New Roman', 'Liberation Serif', 'Nimbus Roman No9 L');

  COURIER_FONTS: array [0..2] of String =
    ('Courier New', 'Liberation Mono', 'Nimbus Mono L');

type
  TFontLike = (flArial, flTimes, flCourier);

  function FontLikeToName(const AFontLike: TFontLike): String;
  procedure LoadFontFromControl(const AControl: TControl;
                              out AFontName: String; out AFontSize: Single);

implementation

procedure LoadFontParams(const AFontHandle: QWord; const APixelsPerInch: Integer;
                      out AFontName: String; out AFontSize: Single);
var
  FD: TFontData;
begin
  FD:= GetFontData(AFontHandle);
  AFontName:= FD.Name;
  AFontSize:= FD.Height*72/APixelsPerInch;
  {$IFDEF WINDOWS}
  AFontSize:= -AFontSize;
  {$ENDIF}
end;

function FontLikeToName(const AFontLike: TFontLike): String;
  function GetName(const ANames: array of String): String;
  var i: Integer;
  begin
    Result:= ANames[0];
    for i:= Low(ANames) to High(ANames) do
      if Screen.Fonts.IndexOf(ANames[i])>=0 then
      begin
        Result:= ANames[i];
        Exit;
      end;
  end;
begin
  case AFontLike of
  flArial:   Result:= GetName(ARIAL_FONTS);
  flTimes:   Result:= GetName(TIMES_FONTS);
  flCourier: Result:= GetName(COURIER_FONTS);
  end;
  if Result=EmptyStr then
    Result:= GetFontData(Screen.SystemFont.Reference.Handle).Name;
end;

procedure LoadFontFromControl(const AControl: TControl;
                              out AFontName: String; out AFontSize: Single);
begin
  FontParamsLoad(AControl.Font.Reference.Handle,
                 AControl.Font.PixelsPerInch, AFontName, AFontSize);
end;

end.

