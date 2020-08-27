unit DK_Dialogs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, Controls;

const
  SpaceStr = ' ';

{ОКНО С СООБЩЕНИЕМ
 Кнопки   : "Ок"
 Параметры:
 AInfo - текст сообщения
 ACaption - заголовок окна сообщения}
procedure ShowInfo(const AInfo: String; const ACaption: String = SpaceStr);

{ОКНО С ЗАПРОСОМ НА УДАЛЕНИЕ
 Кнопки   : "Да" [Result=True], "Нет" (по умолчанию)[Result=False]
 Параметры:
 AQuestion - текст сообщения
 ACaption - заголовок окна сообщения}
function Confirm(const AQuestion: String; const ACaption: String = SpaceStr): Boolean;

implementation

procedure ShowInfo(const AInfo: String; const ACaption: String = SpaceStr);
begin
  MessageDlg(ACaption, AInfo, mtInformation, [mbOK],0);
end;

function Confirm(const AQuestion: String; const ACaption: String = SpaceStr): Boolean;
begin
  Result:= False;
  if MessageDlg(ACaption, AQuestion, mtConfirmation, mbYesNo,0, mbNo)=mrYes then
    Result:= True;
end;

end.

