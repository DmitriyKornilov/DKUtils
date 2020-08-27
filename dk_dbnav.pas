unit DK_DBNav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DbCtrls, Graphics, Controls;

  procedure ChangeDBNavButton(DBNav: TDbNavigator;
                              const DBBtnType: TDBNavButtonType;
                              const DBBtnGlyph: TBitmap;
                              const DBBtnCursor: TCursor = crDefault);


implementation

procedure ChangeDBNavButton(DBNav: TDbNavigator;
                            const DBBtnType: TDBNavButtonType;
                            const DBBtnGlyph: TBitmap;
                            const DBBtnCursor: TCursor = crDefault);
var
  i: Integer;
  NB: TDBNavButton;
begin
  for i := 0 to DBNav.ControlCount - 1 do
  begin
    if DBNav.Controls[i].ClassName = 'TDBNavButton' then
    begin
      NB:= (DBNav.Controls[i] As TDBNavButton);
      if NB.Index= DBBtnType then
      begin
        NB.Glyph := DBBtnGlyph;
        NB.Cursor:= DBBtnCursor;
      end;
    end;
  end;
end;

end.

