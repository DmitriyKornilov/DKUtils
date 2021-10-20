unit DK_LCLStrRus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Translations;

implementation

function TranslateLCLStr: Boolean;
var
  Res: TLResource;
  POFile: TPOFile;
begin
  {ресурс подключен в initialization}
  Res:=LazarusResources.Find('lclstrconsts.ru','PO');
  POFile:=TPOFile.Create;
  try
    POFile.ReadPOText(Res.Value);
    Result:=Translations.TranslateUnitResourceStrings('LCLStrConsts',POFile);
  finally
    FreeAndNil(POFile);
  end;
end;

initialization
  {$I lclstrconsts.lrs}
  TranslateLCLStr;

end.

