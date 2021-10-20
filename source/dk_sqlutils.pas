unit DK_SQLUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SqlDB, db, DK_Dialogs, DK_Const;


  {Query Utils}
  procedure QSetQuery(AQuery: TSQLQuery);
  procedure QSetSQL(const ASQLText: String);
  procedure QShowSQL; //debug util
  procedure QOpen;
  procedure QExec;
  procedure QClose;
  procedure QCommit;
  procedure QCommitEnd;
  procedure QRollback;
  procedure QRollbackEnd;
  procedure QFirst;
  procedure QNext;
  procedure QGotoBookmark(ABookmark: TBookmark);
  procedure QDisableControls;
  procedure QEnableControls;
  procedure QParamInt(const AParamName: String; const AParamValue: Integer);
  procedure QParamInt64(const AParamName: String; const AParamValue: Int64);
  procedure QParamStr(const AParamName: String; const AParamValue: String);
  procedure QParamDT(const AParamName: String; const AParamValue: TDateTime);
  function QIsNull(const AFieldName: String): Boolean;
  function QIsEmpty: Boolean;
  function QEOF: Boolean;
  function QGetBookmark: TBookmark;
  function QFieldInt(const AFieldName: String): Integer;
  function QFieldInt64(const AFieldName: String): Int64;
  function QFieldStr(const AFieldName: String): String;
  function QFieldDT(const AFieldName: String): TDateTime;

  {SQL Utils}
  function SqlSpaces(const AStr: String): String;
  function SqlBrackets(const AStr: String): String;
  function SqlExprLogic(const ALeftArg, AAssertion, ARightArg: String): String;
  function SqlOR(const AExpressions: array of String): String;
  function SqlAND(const AExpressions: array of String): String;
  function SqlCROSS(const AMin1, AMax1, AMin2, AMax2: String): String;
  function SqlSELECT(const AFields: array of String;
                     const ATableName: String; const ATablePseud: String = SYMBOL_EMPTY): String;
  function SqlSELECT(const AFieldsList, ATableName: String;
                     const ATablePseud: String = SYMBOL_EMPTY): String;
  function SqlINSERT(const ATableName: String; const AFields: array of String;
                     const AORExpression: String = SYMBOL_EMPTY): String;
  function SqlUPDATE(const ATableName: String; const AFields: array of String): String;


implementation

var
  SqlUtilsQuery: TSQLQuery;

{Query Utils}

procedure QSetQuery(AQuery: TSQLQuery);
begin
  SqlUtilsQuery:= AQuery;
end;

procedure QSetSQL(const ASQLText: String);
begin
  with SqlUtilsQuery do
  begin
    Close;
    SQL.Clear;
    Params.Clear;
    SQL.Text:= ASQLText;
    Params.ParseSQL(SQL.Text, True);
  end;
end;

procedure QShowSQL;
begin
  ShowInfo(SqlUtilsQuery.SQL.Text);
end;

procedure QOpen;
begin
  SqlUtilsQuery.Open;
end;

procedure QExec;
begin
  SqlUtilsQuery.ExecSQL;
end;

procedure QClose;
begin
  SqlUtilsQuery.Close;
end;

procedure QCommit;
begin
  SqlUtilsQuery.SQLTransaction.CommitRetaining;
end;

procedure QCommitEnd;
begin
  SqlUtilsQuery.SQLTransaction.Commit;
end;

procedure QRollback;
begin
  SqlUtilsQuery.SQLTransaction.RollbackRetaining;
end;

procedure QRollbackEnd;
begin
  SqlUtilsQuery.SQLTransaction.Rollback;
end;

function QIsNull(const AFieldName: String): Boolean;
begin
  Result:= SqlUtilsQuery.FieldByName(AFieldName).IsNull;
end;

function QIsEmpty: Boolean;
begin
  Result:= SqlUtilsQuery.IsEmpty;
end;

function QEOF: Boolean;
begin
  Result:= SqlUtilsQuery.EOF;
end;

procedure QFirst;
begin
  SqlUtilsQuery.First;
end;

procedure QNext;
begin
  SqlUtilsQuery.Next;
end;

function QGetBookmark: TBookmark;
begin
  Result:= SqlUtilsQuery.GetBookmark;
end;

procedure QGotoBookmark(ABookmark: TBookmark);
begin
  if SqlUtilsQuery.BookmarkValid(ABookmark) then
    SqlUtilsQuery.GotoBookmark(ABookmark)
  else
    SqlUtilsQuery.First;
end;

procedure QDisableControls;
begin
  SqlUtilsQuery.DisableControls;
end;

procedure QEnableControls;
begin
  SqlUtilsQuery.EnableControls;
end;

procedure QParamInt(const AParamName: String;
  const AParamValue: Integer);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsInteger:= AParamValue;
end;

procedure QParamInt64(const AParamName: String; const AParamValue: Int64);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsLargeInt:= AParamValue;
end;

procedure QParamStr(const AParamName: String;
  const AParamValue: String);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsString:= AParamValue;
end;

procedure QParamDT(const AParamName: String;
  const AParamValue: TDateTime);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsDateTime:= AParamValue;
end;

function QFieldInt(const AFieldName: String): Integer;
begin
  Result:= 0;
  if not QIsNull(AFieldName) then
    Result:= SqlUtilsQuery.FieldByName(AFieldName).AsInteger;
end;

function QFieldInt64(const AFieldName: String): Int64;
begin
  Result:= 0;
  if not QIsNull(AFieldName) then
    Result:= SqlUtilsQuery.FieldByName(AFieldName).AsLargeInt;
end;

function QFieldStr(const AFieldName: String): String;
begin
  Result:= EmptyStr;
  if not QIsNull(AFieldName) then
    Result:= SqlUtilsQuery.FieldByName(AFieldName).AsString;
end;

function QFieldDT(const AFieldName: String): TDateTime;
begin
  Result:= 0;
  if not QIsNull(AFieldName) then
    Result:= SqlUtilsQuery.FieldByName(AFieldName).AsDateTime;
end;

{SQL Utils}

//SqlExprUnion(['A=B','C<D'], 'OR') --> ' (A=B) OR (C<D) '
function SqlExprUnion(const AExpressions: array of String; const AUnionStr: String): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  if Length(AExpressions)=0 then Exit;
  Result:= SqlBrackets(AExpressions[0]);
  for i:= 1 to High(AExpressions) do
      Result:= Result + SqlSpaces(AUnionStr) + SqlBrackets(AExpressions[i]);
  Result:= SqlSpaces(Result);
end;

// SqlExprList(['A AS AName', 'B', 'C']) --> ' A AS AName, B, C '
function SqlExprList(const AExpressions: array of String): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  if Length(AExpressions)=0 then Exit;
  Result:= AExpressions[0] ;
  for i:= 1 to High(AExpressions) do
      Result:= Result + SYMBOL_COMMA + SYMBOL_SPACE + AExpressions[i];
  Result:= SqlSpaces(Result);
end;

//SqlParamList(['Param1', 'Param2', 'Param3'])--> ' (:Param1, :Param2, :Param3) ';
function SqlParamList(const AParams: array of String): String;
var
  i: Integer;
begin
  Result:= EmptyStr;
  if Length(AParams)=0 then Exit;
  Result:= ':'+AParams[0] ;
  for i:= 1 to High(AParams) do
      Result:= Result + SYMBOL_COMMA + SYMBOL_SPACE + ':' + AParams[i];
  Result:= SqlBrackets(Result);
end;

// SqlSpaces('ABCD')--> ' ABCD '
function SqlSpaces(const AStr: String): String;
begin
  Result:= SYMBOL_SPACE + AStr + SYMBOL_SPACE;
end;

// SqlBrackets('ABCD')--> ' (ABCD) '
function SqlBrackets(const AStr: String): String;
begin
  Result:= SqlSpaces(SYMBOL_OPENBRACKET + AStr + SYMBOL_CLOSEBRACKET);
end;

//SqlExprLogic('A', '<', 'B')--> 'A<B'
function SqlExprLogic(const ALeftArg, AAssertion, ARightArg: String): String;
begin
  Result:= ALeftArg + SqlSpaces(AAssertion) + ARightArg;
end;

// SqlOR(['A<B', 'A>C', 'A=D']) -->  ' (A<B) OR (A>C) OR (A=D) '
function SqlOR(const AExpressions: array of String): String;
begin
  Result:= SqlExprUnion(AExpressions, 'OR');
end;

// SqlAND(['A<B', 'A>C', 'A=D']) -->  ' (A<B) AND (A>C) AND (A=D) '
function SqlAND(const AExpressions: array of String): String;
begin
  Result:= SqlExprUnion(AExpressions, 'AND');
end;

function SqlCROSS(const AMin1, AMax1, AMin2, AMax2: String): String;
begin
  Result:= SqlOR([SqlAND([SqlExprLogic(AMin1, '<=', AMin2), SqlExprLogic(AMax1, '>=', AMax2)]),
                  SqlAND([SqlExprLogic(AMin1, '<=', AMin2), SqlExprLogic(AMax1, '>=', AMin2)]),
                  SqlAND([SqlExprLogic(AMin1, '<=', AMax2), SqlExprLogic(AMax1, '>=', AMax2)]),
                  SqlAND([SqlExprLogic(AMin1, '>=', AMin2), SqlExprLogic(AMax1, '<=', AMax2)])]);
end;

function SqlSELECT(const AFields: array of String;
  const ATableName: String; const ATablePseud: String = SYMBOL_EMPTY): String;
begin
  Result:= 'SELECT';
  if Length(AFields)=0 then
    Result:= Result + ' * '
  else
    Result:= Result + SqlExprList(AFields);
  Result:= Result + ' FROM ' + ATableName;
  if ATablePseud<>SYMBOL_EMPTY then
    Result:= Result + SYMBOL_SPACE + ATablePseud;
  Result:= Result + SYMBOL_SPACE;
end;

function SqlSELECT(const AFieldsList, ATableName: String;
                   const ATablePseud: String = SYMBOL_EMPTY): String;
begin
  Result:= 'SELECT ' + AFieldsList + ' FROM ' + ATableName;
  if ATablePseud<>SYMBOL_EMPTY then
    Result:= Result + SYMBOL_SPACE + ATablePseud;
  Result:= Result + SYMBOL_SPACE;
end;

function SqlINSERT(const ATableName: String; const AFields: array of String;
  const AORExpression: String): String;
begin
  Result:= 'INSERT';
  if AORExpression<>SYMBOL_EMPTY then
    Result:= Result + ' OR ' + AORExpression;
  Result:= Result + ' INTO ' + ATableName +
           SqlBrackets(SqlExprList(AFields)) + ' VALUES ' +
           SqlParamList(AFields);
end;

function SqlUPDATE(const ATableName: String;
  const AFields: array of String): String;
var
  i: Integer;
begin
  Result:= 'UPDATE' + SYMBOL_SPACE + ATableName + SYMBOL_SPACE + 'SET';
  for i:= 0 to High(AFields) do
  begin
    Result:= Result + SYMBOL_SPACE + AFields[i] + '=:' + AFields[i];
    if i<High(AFields) then
      Result:= Result + SYMBOL_COMMA
    else
      Result:= Result + SYMBOL_SPACE;
  end;
end;



end.

