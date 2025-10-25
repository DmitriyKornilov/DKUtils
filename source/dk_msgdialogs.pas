unit DK_MsgDialogs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, System.UITypes, Dialogs;

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
procedure MsgInform(const AInfo: String; const ACaption: String = ' ');

{ОКНО С ЗАПРОСОМ
 Кнопки   : "Да" [Result=True], "Нет" (по умолчанию)[Result=False]
 Параметры:
 AQuestion - текст запроса
 ACaption - заголовок окна запроса}
function MsgConfirm(const AQuestion: String; const ACaption: String = ' '): Boolean;

{ОКНО С ЗАПРОСОМ
 Кнопки   : "Да" [Result=mrYes], "Нет"[Result=mrNo], "Отмена" (по умолчанию)[Result=mrCancel]
 Параметры:
 AQuestion - текст запроса
 ACaption - заголовок окна запроса}
function MsgQuestion(const AQuestion: String; const ACaption: String = ' '): TModalResult;

implementation

procedure MsgInform(const AInfo: String; const ACaption: String = ' ');
begin
  MessageDlg(ACaption, AInfo, mtInformation, [mbOK],0);
end;

function MsgConfirm(const AQuestion: String; const ACaption: String = ' '): Boolean;
begin
  Result:= False;
  if MessageDlg(ACaption, AQuestion, mtConfirmation, mbYesNo,0, mbNo)=mrYes then
    Result:= True;
end;

function MsgQuestion(const AQuestion: String; const ACaption: String = ' '): TModalResult;
begin
  Result:= MessageDlg(ACaption, AQuestion, mtConfirmation, mbYesNoCancel,0, mbCancel);
end;

end.


