//SQLite 3
unit DK_DBUtils;


{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SqlDB, DK_StrUtils, DK_SQLUtils, DK_Vector;

var
  DBUtilsQuery: TSQLQuery;

  //кол-во записей - в обход глюков RecordCount
  function CalcRecordCount(const ADataSet: TDataSet): Integer;

  {РЕДАКТИРОВАНИЕ DATASET ИЗ ГРИДА---------------------------------------------}
  //сохранение данных ADataSet
  procedure DataSetChangesSave(const ADataSet: TDataSet);
  //отмена изменений ADataSet
  procedure DataSetChangesCancel(const ADataSet: TDataSet);
  //устанавливает в поле AIDFieldName редактируемого ADataSet значение AIDValue
  function SetNewID(const ADataSet: TDataSet; const AIDFieldName: String; const AIDValue: Integer): Boolean;

  {ОБНОВЛЕНИЕ}
  //DataSetRefreshWithLocate - обновление датасета с позиционированием на редактированную или вставленную строку
  procedure DataSetRefreshWithLocate(const ADataSet: TDataSet;
                              const ATableName, AIDFieldName: String; const AIDValue: Integer);

  {ПРОВЕРКА НАЛИЧИЯ В БАЗЕ ЗНАЧЕНИЙ--------------------------------------------}
  {IsValueInTable - проверяет наличие в таблице ATable наличие записи
  со значением в поле AField равным AValue}
  function IsValueInTable(const ATable, AField: String; const AValue: String): Boolean;
  function IsValueInTable(const ATable, AField: String; const AValue: Integer): Boolean;
  function IsValueInTable(const ATable, AField: String; const AValue: Int64): Boolean;
  function IsValueInTable(const ATable, AField: String; const AValue: TDateTime): Boolean;
  {IsValueInTable - проверяет наличие в таблице ATable наличие записи
  со значением в поле AField равным AValue, идентификатор которой, хранящийся в поле AIDField
  не равен значению AIDValue}
  function IsValueInTable(const ATable, AField: String; const AValue: String;
                          const AIDField: String; const AIDValue: Integer = 0): Boolean;
  function IsValueInTable(const ATable, AField: String; const AValue: Integer;
                          const AIDField: String; const AIDValue: Integer = 0): Boolean;
  function IsValueInTable(const ATable, AField: String; const AValue: Int64;
                          const AIDField: String; const AIDValue: Integer = 0): Boolean;
  function IsValueInTable(const ATable, AField: String; const AValue: TDateTime;
                          const AIDField: String; const AIDValue: Integer = 0): Boolean;
  function IsValueInTableIDInt64(const ATable, AField: String; const AValue: String;
                          const AIDField: String; const AIDValue: Int64 = 0): Boolean;
  function IsValueInTableIDInt64(const ATable, AField: String; const AValue: Integer;
                          const AIDField: String; const AIDValue: Int64 = 0): Boolean;
  function IsValueInTableIDInt64(const ATable, AField: String; const AValue: Int64;
                          const AIDField: String; const AIDValue: Int64 = 0): Boolean;
  function IsValueInTableIDInt64(const ATable, AField: String; const AValue: TDateTime;
                          const AIDField: String; const AIDValue: Int64 = 0): Boolean;

  {УДАЛЕНИЕ ДАННЫХ-------------------------------------------------------------}
  //удаление из таблицы ATable записей, где AIDField=AIDValue }
  procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: String);
  procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: Integer);
  procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: Int64);
  procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: TDateTime);
  //удаление из таблицы ATable записей, где AIDField=AIDValue и AValueField=AValue
  procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Integer; const AValue: String);
  procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Integer; const AValue: Integer);
  procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Integer; const AValue: Int64);
  procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Integer; const AValue: TDateTime);
  procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Int64; const AValue: String);
  procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Int64; const AValue: Integer);
  procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Int64; const AValue: Int64);
  procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Int64; const AValue: TDateTime);

  {ВЫБОРКА ДАННЫХ--------------------------------------------------------------}
  {GetLastWritedID - получение последнего записанного ID в таблицу}
  function GetLastWritedID(const ATableName, AIDFieldName: String): Integer;
  function GetLastWritedID(const ATableName: String): Integer;  //SQLite
  function GetLastWritedIDInt64(const ATableName, AIDFieldName: String): Int64;
  function GetLastWritedIDInt64(const ATableName: String): Int64;  //SQLite
  {GetPickFromKeyValue получает из таблицы ATable значение из поля APickField,
  для которого значение поля AKeyField равно AKeyValue}
  function GetPickFromKeyValue(const ATable, AKeyField, APickField: String;
                               const AKeyValue: Integer): String;
  {GetKeyPickList получает из таблицы ATable значения из полей AKeyField и APickField,
  отсортированные по AOrderField (если AOrderField=EmptyStr, то AOrderField=APickField),
  и записывает их в AKeyList, APickList
  Если AKeyValueNotZero=True - отбор значений AKeyField<>0}
  procedure GetKeyPickList(const ATable, AKeyField, APickField: String;
                           out AKeyVector: TIntVector; out APickVector: TStrVector;
                           const AKeyValueNotZero: Boolean = False;
                           AOrderField: String = '');
  procedure GetKeyPickList(const ATable, AKeyField, APickField: String;
                           out AKeyList, APickList: TStringList;
                           const AKeyValueNotZero: Boolean = False;
                           AOrderField: String = '');
  {SetKeyPickList - заполняет PickList/KeyList из таблицы ATable
  значениями в полях AKeyField и APickField,
  отсортированными по AOrderField (если AOrderField=EmptyStr, то AOrderField=APickField).
  Если AKeyValueNotZero=True - отбор значений AKeyField<>0}
  procedure SetKeyPickList(const ATable, AKeyField, APickField: String;
                           const AKeyList, APickList: TStrings;
                           const AKeyValueNotZero: Boolean = False;
                           const AOrderField: String = '');

implementation

function CalcRecordCount(const ADataSet: TDataSet): Integer;
var
  BM: TBookmark;
begin
  Result:= 0;
  if ADataSet.IsEmpty then Exit;
  BM:= ADataSet.GetBookmark;
  ADataSet.DisableControls;
  try
    ADataSet.First;
    while not ADataSet.EOF do
    begin
      Inc(Result);
      ADataSet.Next;
    end;
    ADataSet.GotoBookmark(BM);
  finally
    ADataSet.EnableControls;
  end;
end;

{РЕДАКТИРОВАНИЕ DATASET ИЗ ГРИДА---------------------------------------------}

procedure DataSetChangesSave(const ADataSet: TDataSet);
begin
  (ADataSet As TSQLQuery).ApplyUpdates;
  (ADataSet As TSQLQuery).SQLTransaction.CommitRetaining;
end;

procedure DataSetChangesCancel(const ADataSet: TDataSet);
begin
  (ADataSet As TSQLQuery).CancelUpdates;
end;

function SetNewID(const ADataSet: TDataSet; const AIDFieldName: String; const AIDValue: Integer): Boolean;
begin
  Result:= TSQLQuery(ADataSet).FieldByName(AIDFieldName).IsNull;
  if Result then
    TSQLQuery(ADataSet).FieldByName(AIDFieldName).AsInteger:= AIDValue;
end;

procedure DataSetRefreshWithLocate(const ADataSet: TDataSet;
     const ATableName, AIDFieldName: String; const AIDValue: Integer);
var
  IDValue: Integer;
begin
  IDValue:= AIDValue;
  ADataSet.Refresh;
  if IDValue=0 then
    IDValue:= GetLastWritedID(ATableName, AIDFieldName);
  ADataSet.Locate(AIDFieldName, IDValue, [{loCaseInsensitive, loPartialKey}]);
end;

{ПРОВЕРКА НАЛИЧИЯ В БАЗЕ ЗНАЧЕНИЙ--------------------------------------------}

function IsValueInTable(const ATable, AField: String; const AValue: String): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE UPPER(' + AField + ')= :AValue' );
  ParamStr('AValue', SUpper(AValue));
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTable(const ATable, AField: String; const AValue: Integer): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE ' + AField + '= :AValue' );
  ParamInt('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTable(const ATable, AField: String; const AValue: Int64): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE ' + AField + '= :AValue' );
  ParamInt64('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTable(const ATable, AField: String; const AValue: TDateTime): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE ' + AField + '= :AValue' );
  ParamDT('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTable(const ATable, AField: String; const AValue: String;
                        const AIDField: String; const AIDValue: Integer = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (UPPER(' + AField + ')= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt('AIDValue', AIDValue);
  ParamStr('AValue', SUpper(AValue));
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTable(const ATable, AField: String; const AValue: Integer;
                        const AIDField: String; const AIDValue: Integer = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (' + AField + '= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt('AIDValue', AIDValue);
  ParamInt('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTable(const ATable, AField: String; const AValue: Int64;
                        const AIDField: String; const AIDValue: Integer = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (' + AField + '= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt('AIDValue', AIDValue);
  ParamInt64('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTable(const ATable, AField: String; const AValue: TDateTime;
                        const AIDField: String; const AIDValue: Integer = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (' + AField + '= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt('AIDValue', AIDValue);
  ParamDT('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTableIDInt64(const ATable, AField: String; const AValue: String;
                        const AIDField: String; const AIDValue: Int64 = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (UPPER(' + AField + ')= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt64('AIDValue', AIDValue);
  ParamStr('AValue', SUpper(AValue));
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTableIDInt64(const ATable, AField: String; const AValue: Integer;
                        const AIDField: String; const AIDValue: Int64 = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (' + AField + '= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt64('AIDValue', AIDValue);
  ParamInt('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTableIDInt64(const ATable, AField: String; const AValue: Int64;
                        const AIDField: String; const AIDValue: Int64 = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (' + AField + '= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt64('AIDValue', AIDValue);
  ParamInt64('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

function IsValueInTableIDInt64(const ATable, AField: String; const AValue: TDateTime;
                        const AIDField: String; const AIDValue: Int64 = 0): Boolean;
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + AField + ' FROM ' + ATable + ' ' +
    'WHERE (' + AField + '= :AValue) AND ('+ AIDField+ '<> :AIDValue)' );
  ParamInt64('AIDValue', AIDValue);
  ParamDT('AValue', AValue);
  OpenSQL;
  Result:= not IsEmptySQL;
  CloseSQL;
end;

{УДАЛЕНИЕ ДАННЫХ-------------------------------------------------------------}

procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: String);
begin
  try
    SetQuery(DBUtilsQuery);
    SetSQL(
      'DELETE FROM ' + ATable + ' ' +
      'WHERE UPPER(' + AIDField + ') = :IDValue');
    ParamStr('IDValue', SUpper(AIDValue));
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDPrepair(const ATable, AIDField: String);
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'DELETE FROM ' + ATable + ' ' +
    'WHERE ' + AIDField + ' = :IDValue');
end;

procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: Integer);
begin
  try
    DeleteWithIDPrepair(ATable, AIDField);
    ParamInt('IDValue', AIDValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: Int64);
begin
  try
    DeleteWithIDPrepair(ATable, AIDField);
    ParamInt64('IDValue', AIDValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithID(const ATable, AIDField: String; const AIDValue: TDateTime);
begin
  try
    DeleteWithIDPrepair(ATable, AIDField);
    ParamDT('IDValue', AIDValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                               const AIDValue: Integer; const AValue: String);
begin
  try
    SetQuery(DBUtilsQuery);
    SetSQL(
      'DELETE FROM ' + ATable + ' ' +
      'WHERE (' + AIDField + ' = :IDValue) AND (UPPER(' + AValueField + ') = :AValue)');
    ParamInt('IDValue', AIDValue);
    ParamStr('AValue', SUpper(AValue));
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDAndValuePrepare(const ATable, AIDField, AValueField: String;
                                      const AIDValue: Integer);
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'DELETE FROM ' + ATable + ' ' +
    'WHERE (' + AIDField + ' = :IDValue) AND (' + AValueField + ' = :AValue)');
  ParamInt('IDValue', AIDValue);
end;

procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Integer; const AValue: Integer);
begin
  try
    DeleteWithIDAndValuePrepare(ATable, AIDField, AValueField, AIDValue);
    ParamInt('AValue', AValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Integer; const AValue: Int64);
begin
  try
    DeleteWithIDAndValuePrepare(ATable, AIDField, AValueField, AIDValue);
    ParamInt64('AValue', AValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDAndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Integer; const AValue: TDateTime);
begin
  try
    DeleteWithIDAndValuePrepare(ATable, AIDField, AValueField, AIDValue);
    ParamDT('AValue', AValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                               const AIDValue: Int64; const AValue: String);
begin
  try
    SetQuery(DBUtilsQuery);
    SetSQL(
      'DELETE FROM ' + ATable + ' ' +
      'WHERE (' + AIDField + ' = :IDValue) AND (UPPER(' + AValueField + ') = :AValue)');
    ParamInt64('IDValue', AIDValue);
    ParamStr('AValue', SUpper(AValue));
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDInt64AndValuePrepare(const ATable, AIDField, AValueField: String;
                                      const AIDValue: Int64);
begin
  SetQuery(DBUtilsQuery);
  SetSQL(
    'DELETE FROM ' + ATable + ' ' +
    'WHERE (' + AIDField + ' = :IDValue) AND (' + AValueField + ' = :AValue)');
  ParamInt64('IDValue', AIDValue);
end;

procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Int64; const AValue: Integer);
begin
  try
    DeleteWithIDInt64AndValuePrepare(ATable, AIDField, AValueField, AIDValue);
    ParamInt('AValue', AValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Int64; const AValue: Int64);
begin
  try
    DeleteWithIDInt64AndValuePrepare(ATable, AIDField, AValueField, AIDValue);
    ParamInt64('AValue', AValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

procedure DeleteWithIDInt64AndValue(const ATable, AIDField, AValueField: String;
                                 const AIDValue: Int64; const AValue: TDateTime);
begin
  try
    DeleteWithIDInt64AndValuePrepare(ATable, AIDField, AValueField, AIDValue);
    ParamDT('AValue', AValue);
    ExecSQL;
    CommitSQL;
  except
    RollbackSQL;
  end;
end;

{ВЫБОРКА ДАННЫХ-------------------------------------------------------------}

function GetLastWritedID(const ATableName, AIDFieldName: String): Integer;
begin
  Result:= 0;
  SetQuery(DBUtilsQuery);
  SetSQL('SELECT ' + AIDFieldName + ' FROM ' + ATableName +
         ' ORDER BY ' + AIDFieldName + ' DESC LIMIT 1');
  OpenSQL;
  if not IsEmptySQL then
    Result:= FieldInt(AIDFieldName);
  CloseSQL;
end;

function GetLastWritedID(const ATableName: String): Integer;  //SQLite
begin
  Result:= 0;
  SetQuery(DBUtilsQuery);
  SetSQL('SELECT last_insert_rowid() AS LastID FROM ' + ATableName + ' LIMIT 1');
  OpenSQL;
  if not IsEmptySQL then
    Result:= FieldInt('LastID');
  CloseSQL;
end;

function GetLastWritedIDInt64(const ATableName, AIDFieldName: String): Int64;
begin
  Result:= 0;
  SetQuery(DBUtilsQuery);
  SetSQL('SELECT ' + AIDFieldName + ' FROM ' + ATableName +
         ' ORDER BY ' + AIDFieldName + ' DESC LIMIT 1');
  OpenSQL;
  if not IsEmptySQL then
    Result:= FieldInt64(AIDFieldName);
  CloseSQL;
end;

function GetLastWritedIDInt64(const ATableName: String): Int64;
begin
  Result:= 0;
  SetQuery(DBUtilsQuery);
  SetSQL('SELECT last_insert_rowid() AS LastID FROM ' + ATableName + ' LIMIT 1');
  OpenSQL;
  if not IsEmptySQL then
    Result:= FieldInt64('LastID');
  CloseSQL;
end;

function GetPickFromKeyValue(const ATable, AKeyField, APickField: String;
                             const AKeyValue: Integer): String;
begin
  Result:= EmptyStr;
  SetQuery(DBUtilsQuery);
  SetSQL(
    'SELECT ' + APickField + ' FROM ' + ATable + ' ' +
    'WHERE ' + AKeyField + '= :AKeyValue');
  ParamInt('AKeyValue', AKeyValue);
  OpenSQL;
  if not IsEmptySQL then
  begin
    FirstSQL;
    Result:= FieldStr(APickField);
  end;
  CloseSQL;
end;

procedure GetKeyPickList(const ATable, AKeyField, APickField: String;
                         out AKeyList, APickList: TStringList;
                         const AKeyValueNotZero: Boolean = False;
                         AOrderField: String = '');
var
  VKey: TIntVector;
  VPick: TStrVector;
  i: Integer;
begin
  {%H-}APickList.Clear;
  {%H-}AKeyList.Clear;
  GetKeyPickList(ATable, AKeyField, APickField,
                 VKey, VPick, AKeyValueNotZero, AOrderField);
  for i:= 0 to High(VKey) do
  begin
    AKeyList.Add(IntToStr(VKey[i]));
    APickList.Add(VPick[i]);
  end;
end;

procedure GetKeyPickList(const ATable, AKeyField, APickField: String;
                         out AKeyVector: TIntVector; out APickVector: TStrVector;
                         const AKeyValueNotZero: Boolean = False;
                         AOrderField: String = '');
var
  SQLStr: String;
begin
  AKeyVector:= nil;
  APickVector:= nil;
  if AOrderField=EmptyStr then
    AOrderField:=  APickField;
  SQLStr:= 'SELECT ' + AKeyField + ', ' + APickField + ' ' +
           'FROM ' + ATable + ' ';
  if AKeyValueNotZero then
    SQLStr:= SQLStr + 'WHERE ' + AKeyField + '<>0 ';
  SQLStr:= SQLStr + 'ORDER BY ' + AOrderField;
  SetQuery(DBUtilsQuery);
  SetSQL(SQLStr);
  OpenSQL;
  if not IsEmptySQL then
  begin
    FirstSQL;
    while not EOFSQL do
    begin
      VAppend(AKeyVector, FieldInt(AKeyField));
      VAppend(APickVector, FieldStr(APickField));
      NextSQL;
    end;
  end;
  CloseSQL;
end;

procedure SetKeyPickList(const ATable, AKeyField, APickField: String;
                           const AKeyList, APickList: TStrings;
                           const AKeyValueNotZero: Boolean = False;
                           const AOrderField: String = '');
var
  AKeys, APicks: TStringList;
begin
  AKeys:= TStringList.Create;
  APicks:= TStringList.Create;
  GetKeyPickList(ATable, AKeyField, APickField, AKeys, APicks, AKeyValueNotZero, AOrderField);
  AKeyList.Assign(AKeys);
  APickList.Assign(APicks);
  FreeAndNil(AKeys);
  FreeAndNil(APicks);
end;

end.

