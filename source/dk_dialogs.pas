unit DK_Dialogs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, System.UITypes, Dialogs, DK_Const;

type
  TModalResult = System.UITypes.TModalResult;

const
  mrYes     = System.UITypes.mrYes;
  mrNo      = System.UITypes.mrNo;
  mrCancel  = System.UITypes.mrCancel;

{ОКНО С СООБЩЕНИЕМ
 Кнопки   : "Ок"
 Параметры:
 AInfo - текст сообщения
 ACaption - заголовок окна сообщения}
procedure ShowInfo(const AInfo: String; const ACaption: String = SYMBOL_SPACE);

{ОКНО С ЗАПРОСОМ
 Кнопки   : "Да" [Result=True], "Нет" (по умолчанию)[Result=False]
 Параметры:
 AQuestion - текст запроса
 ACaption - заголовок окна запроса}
function Confirm(const AQuestion: String; const ACaption: String = SYMBOL_SPACE): Boolean;

{ОКНО С ЗАПРОСОМ
 Кнопки   : "Да" [Result=mrYes], "Нет"[Result=mrNo], "Отмена" (по умолчанию)[Result=mrCancel]
 Параметры:
 AQuestion - текст запроса
 ACaption - заголовок окна запроса}
function ShowQuestion(const AQuestion: String; const ACaption: String = SYMBOL_SPACE): TModalResult;

implementation

procedure ShowInfo(const AInfo: String; const ACaption: String = SYMBOL_SPACE);
begin
  MessageDlg(ACaption, AInfo, mtInformation, [mbOK],0);
end;

function Confirm(const AQuestion: String; const ACaption: String = SYMBOL_SPACE): Boolean;
begin
  Result:= False;
  if MessageDlg(ACaption, AQuestion, mtConfirmation, mbYesNo,0, mbNo)=mrYes then
    Result:= True;
end;

function ShowQuestion(const AQuestion: String; const ACaption: String = SYMBOL_SPACE): TModalResult;
begin
  Result:= MessageDlg(ACaption, AQuestion, mtConfirmation, mbYesNoCancel,0, mbCancel);
end;

end.

