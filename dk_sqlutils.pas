unit DK_SQLUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SqlDB, DK_Dialogs, db;

const
  SQL_EMPTY        = '';
  SQL_SPACE        = ' ';
  SQL_OPENBRACKET  = '(';
  SQL_CLOSEBRACKET = ')';
  SQL_COMMA        = ',';

  {Query Utils}
  procedure SetQuery(AQuery: TSQLQuery);
  procedure SetSQL(const ASQLText: String);
  procedure ShowSQL;
  procedure OpenSQL;
  procedure ExecSQL;
  procedure CloseSQL;
  procedure CommitSQL;
  procedure CommitEndSQL;
  procedure RollbackSQL;
  procedure RollbackEndSQL;
  function IsNullSQL(const AFieldName: String): Boolean;
  function IsEmptySQL: Boolean;
  function EOFSQL: Boolean;
  procedure FirstSQL;
  procedure NextSQL;
  function GetBookmarkSQL: TBookmark;
  procedure GotoBookmarkSQL(ABookmark: TBookmark);
  procedure DisableControlsSQL;
  procedure EnableControlsSQL;
  procedure ParamInt(const AParamName: String; const AParamValue: Integer);
  procedure ParamInt64(const AParamName: String; const AParamValue: Int64);
  procedure ParamStr(const AParamName: String; const AParamValue: String);
  procedure ParamDT(const AParamName: String; const AParamValue: TDateTime);
  function FieldInt(const AFieldName: String): Integer;
  function FieldInt64(const AFieldName: String): Int64;
  function FieldStr(const AFieldName: String): String;
  function FieldDT(const AFieldName: String): TDateTime;

  {SQL Utils}
  function SqlSpaces(const AStr: String): String;
  function SqlBrackets(const AStr: String): String;
  function SqlExprLogic(const ALeftArg, AAssertion, ARightArg: String): String;
  function SqlOR(const AExpressions: array of String): String;
  function SqlAND(const AExpressions: array of String): String;
  function SqlCROSS(const AMin1, AMax1, AMin2, AMax2: String): String;
  function SqlSELECT(const AFields: array of String;
                     const ATableName: String; const ATablePseud: String = SQL_EMPTY): String; overload;
  function SqlSELECT(const AFieldsList, ATableName: String;
                     const ATablePseud: String = SQL_EMPTY): String; overload;
  function SqlUPDATE(const ATableName: String; const AExpressions: array of String): String; overload;
  function SqlUPDATE(const ATableName, AExpressionList: String): String; overload;
  function SqlWHERE(const AExpressions: array of String): String; overload;
  function SqlWHERE(const AExpressionsList: String): String; overload;
  function SqlORDER(const AFields: array of String): String; overload;
  function SqlORDER(const AFieldsList: String): String; overload;

implementation

var
  SqlUtilsQuery: TSQLQuery;

{Query Utils}

procedure SetQuery(AQuery: TSQLQuery);
begin
  SqlUtilsQuery:= AQuery;
end;

procedure SetSQL(const ASQLText: String);
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

procedure ShowSQL;
begin
  ShowInfo(SqlUtilsQuery.SQL.Text);
end;

procedure OpenSQL;
begin
  SqlUtilsQuery.Open;
end;

procedure ExecSQL;
begin
  SqlUtilsQuery.ExecSQL;
end;

procedure CloseSQL;
begin
  SqlUtilsQuery.Close;
end;

procedure CommitSQL;
begin
  SqlUtilsQuery.SQLTransaction.CommitRetaining;
end;

procedure CommitEndSQL;
begin
  SqlUtilsQuery.SQLTransaction.Commit;
end;

procedure RollbackSQL;
begin
  SqlUtilsQuery.SQLTransaction.RollbackRetaining;
end;

procedure RollbackEndSQL;
begin
  SqlUtilsQuery.SQLTransaction.Rollback;
end;

function IsNullSQL(const AFieldName: String): Boolean;
begin
  Result:= SqlUtilsQuery.FieldByName(AFieldName).IsNull;
end;

function IsEmptySQL: Boolean;
begin
  Result:= SqlUtilsQuery.IsEmpty;
end;

function EOFSQL: Boolean;
begin
  Result:= SqlUtilsQuery.EOF;
end;

procedure FirstSQL;
begin
  SqlUtilsQuery.First;
end;

procedure NextSQL;
begin
  SqlUtilsQuery.Next;
end;

function GetBookmarkSQL: TBookmark;
begin
  Result:= SqlUtilsQuery.GetBookmark;
end;

procedure GotoBookmarkSQL(ABookmark: TBookmark);
begin
  if SqlUtilsQuery.BookmarkValid(ABookmark) then
    SqlUtilsQuery.GotoBookmark(ABookmark)
  else
    SqlUtilsQuery.First;
end;

procedure DisableControlsSQL;
begin
  SqlUtilsQuery.DisableControls;
end;

procedure EnableControlsSQL;
begin
  SqlUtilsQuery.EnableControls;
end;

procedure ParamInt(const AParamName: String;
  const AParamValue: Integer);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsInteger:= AParamValue;
end;

procedure ParamInt64(const AParamName: String; const AParamValue: Int64);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsLargeInt:= AParamValue;
end;

procedure ParamStr(const AParamName: String;
  const AParamValue: String);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsString:= AParamValue;
end;

procedure ParamDT(const AParamName: String;
  const AParamValue: TDateTime);
begin
  SqlUtilsQuery.ParamByName(AParamName).AsDateTime:= AParamValue;
end;

function FieldInt(const AFieldName: String): Integer;
begin
  Result:= 0;
  if not IsNullSQL(AFieldName) then
    Result:= SqlUtilsQuery.FieldByName(AFieldName).AsInteger;
end;

function FieldInt64(const AFieldName: String): Int64;
begin
  Result:= 0;
  if not IsNullSQL(AFieldName) then
    Result:= SqlUtilsQuery.FieldByName(AFieldName).AsLargeInt;
end;

function FieldStr(const AFieldName: String): String;
begin
  Result:= EmptyStr;
  if not IsNullSQL(AFieldName) then
    Result:= SqlUtilsQuery.FieldByName(AFieldName).AsString;
end;

function FieldDT(const AFieldName: String): TDateTime;
begin
  Result:= 0;
  if not IsNullSQL(AFieldName) then
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
      Result:= Result + SQL_COMMA + SQL_SPACE + AExpressions[i];
  Result:= SqlSpaces(Result);
end;

function SqlSpaces(const AStr: String): String;
begin
  Result:= SQL_SPACE + AStr + SQL_SPACE;
end;

function SqlBrackets(const AStr: String): String;
begin
  Result:= SQL_OPENBRACKET + AStr + SQL_CLOSEBRACKET;
end;

function SqlExprLogic(const ALeftArg, AAssertion, ARightArg: String): String;
begin
  Result:= ALeftArg + SqlSpaces(AAssertion) + ARightArg;
end;

function SqlOR(const AExpressions: array of String): String;
begin
  Result:= SqlExprUnion(AExpressions, 'OR');
end;

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
  const ATableName: String; const ATablePseud: String = SQL_EMPTY): String;
begin
  Result:= 'SELECT';
  if Length(AFields)=0 then
    Result:= Result + ' * '
  else
    Result:= Result + SqlExprList(AFields);
  Result:= Result + 'FROM' + SQL_SPACE + ATableName;
  if ATablePseud<>SQL_EMPTY then
    Result:= Result + SQL_SPACE + ATablePseud;
  Result:= Result + SQL_SPACE;
end;

function SqlSELECT(const AFieldsList, ATableName: String;
                   const ATablePseud: String = SQL_EMPTY): String;
begin
  Result:= 'SELECT' + SQL_SPACE + AFieldsList + SQL_SPACE + 'FROM' + SQL_SPACE + ATableName;
  if ATablePseud<>SQL_EMPTY then
    Result:= Result + SQL_SPACE + ATablePseud;
  Result:= Result + SQL_SPACE;
end;

function SqlUPDATE(const ATableName: String;
  const AExpressions: array of String): String;
begin
  Result:= 'UPDATE' + SQL_SPACE + ATableName + SQL_SPACE + 'SET' + SqlExprList(AExpressions);
end;

function SqlUPDATE(const ATableName, AExpressionList: String): String;
begin
  Result:= 'UPDATE' + SQL_SPACE + ATableName + SQL_SPACE + 'SET' + SQL_SPACE + AExpressionList + SQL_SPACE;
end;

function SqlWHERE(const AExpressions: array of String): String;
begin
  Result:= 'WHERE' + SqlExprList(AExpressions);
end;

function SqlWHERE(const AExpressionsList: String): String; overload;
begin
  Result:= 'WHERE' + SQL_SPACE + AExpressionsList + SQL_SPACE;
end;

function SqlORDER(const AFields: array of String): String;
begin
  Result:= 'ORDER BY' + SqlExprList(AFields);
end;

function SqlORDER(const AFieldsList: String): String;
begin
  Result:= 'ORDER BY' + SQL_SPACE + AFieldsList + SQL_SPACE;
end;

end.

