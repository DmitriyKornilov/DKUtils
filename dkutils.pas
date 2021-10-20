{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit DKUtils;

{$warn 5023 off : no warning about unused units}
interface

uses
  DK_Const, DK_DateUtils, DK_Dialogs, DK_LCLStrRus, DK_Matrix, DK_PriceUtils, 
  DK_SQLUtils, DK_StrUtils, DK_TextUtils, DK_Vector, DK_VMShow, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('DKUtils', @Register);
end.
