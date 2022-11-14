unit DK_VMShow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ButtonPanel, ExtCtrls, DK_Vector, DK_Matrix;

type

  { TVMShowForm }

  TVMShowForm = class(TForm)
    ButtonPanel1: TButtonPanel;
    VectorGrid: TStringGrid;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  VMShowForm: TVMShowForm;

  procedure VShowAdd(const V: TIntVector;   const VName: String = '');
  procedure VShowAdd(const V: TInt64Vector; const VName: String = '');
  procedure VShowAdd(const V: TStrVector;   const VName: String = '');
  procedure VShowAddDate(const V: TDateVector;  const VName: String = '');
  procedure VShowAddTime(const V: TTimeVector;  const VName: String = '');
  procedure VShowAdd(const V: TBoolVector;  const VName: String = '');

  procedure VShow;

  procedure VShow(const V: TIntVector;   const VName: String = '');
  procedure VShow(const V: TInt64Vector; const VName: String = '');
  procedure VShow(const V: TStrVector;   const VName: String = '');
  procedure VShowDate(const V: TDateVector;  const VName: String = '');
  procedure VShowTime(const V: TTimeVector;  const VName: String = '');
  procedure VShow(const V: TBoolVector;  const VName: String = '');

  procedure MShow(const M: TIntMatrix);
  procedure MShow(const M: TInt64Matrix);
  procedure MShow(const M: TStrMatrix);
  procedure MShowDate(const M: TDateMatrix);
  procedure MShowTime(const M: TTimeMatrix);
  procedure MShow(const M: TBoolMatrix);

implementation

{$R *.lfm}

const
  DEFAULT_COLUMN_WIDTH = 100;
  INDEX_COLUMN_WIDTH   = 70;

procedure AddVector(const V: TStrVector; const VName: String);
var
  i, N, C: Integer;

  procedure SetColumnSettings(const AIndex, AWidth: Integer; const ACaption: String);
  begin
    VMShowForm.VectorGrid.Columns[AIndex].Title.Caption:= ACaption;
    VMShowForm.VectorGrid.Columns[AIndex].Title.Alignment:= taCenter;
    VMShowForm.VectorGrid.Columns[AIndex].Alignment:= taCenter;
    VMShowForm.VectorGrid.Columns[AIndex].Width:= AWidth;
  end;

begin
  N:= Length(V);
  if not Assigned(VMShowForm) then
  begin
    VMShowForm:= TVMShowForm.Create(Application);
    VMShowForm.VectorGrid.RowCount:= N + 1;
  end
  else begin
    if N+1 > VMShowForm.VectorGrid.RowCount then
      VMShowForm.VectorGrid.RowCount:= N + 1;
  end;

  C:= 0;
  SetColumnSettings(C, INDEX_COLUMN_WIDTH, 'Индекс');
  for i:= 1 to VMShowForm.VectorGrid.RowCount - 1 do
    VMShowForm.VectorGrid.Cells[C, i]:= IntToStr(i-1);

  VMShowForm.VectorGrid.Columns.Add;
  C:= VMShowForm.VectorGrid.ColCount - 1;
  if VName=EmptyStr then
    SetColumnSettings(C, DEFAULT_COLUMN_WIDTH, 'Вектор ' + IntToStr(C))
  else
    SetColumnSettings(C, DEFAULT_COLUMN_WIDTH, VName);
  for i:= 0 to N-1 do
    VMShowForm.VectorGrid.Cells[C, i+1]:= V[i];
end;

procedure VShowAdd(const V: TIntVector; const VName: String);
begin
  AddVector(VIntToStr(V), VName);
end;

procedure VShowAdd(const V: TInt64Vector; const VName: String);
begin
  AddVector(VIntToStr(V), VName);
end;

procedure VShowAdd(const V: TStrVector; const VName: String);
begin
  AddVector(V, VName);
end;

procedure VShowAddDate(const V: TDateVector; const VName: String);
begin
  AddVector(VDateToStr(V), VName);
end;

procedure VShowAddTime(const V: TTimeVector; const VName: String);
begin
  AddVector(VTimeToStr(V), VName);
end;

procedure VShowAdd(const V: TBoolVector; const VName: String);
begin
  AddVector(VBoolToStr(V), VName);
end;

procedure VShow;
begin
  VMShowForm.ShowModal;
  FreeAndNil(VMShowForm);
end;

procedure VShow(const V: TIntVector; const VName: String);
begin
  if VName=EmptyStr then
    VShowAdd(V, 'Значение')
  else
    VShowAdd(V, VName);
  VShow;
end;

procedure VShow(const V: TInt64Vector; const VName: String);
begin
  if VName=EmptyStr then
    VShowAdd(V, 'Значение')
  else
    VShowAdd(V, VName);
  VShow;
end;

procedure VShow(const V: TStrVector; const VName: String);
begin
  if VName=EmptyStr then
    VShowAdd(V, 'Значение')
  else
    VShowAdd(V, VName);
  VShow;
end;

procedure VShowDate(const V: TDateVector; const VName: String);
begin
  if VName=EmptyStr then
    VShowAddDate(V, 'Значение')
  else
    VShowAddDate(V, VName);
  VShow;
end;

procedure VShowTime(const V: TTimeVector; const VName: String);
begin
  if VName=EmptyStr then
    VShowAddTime(V, 'Значение')
  else
    VShowAddTime(V, VName);
  VShow;
end;

procedure VShow(const V: TBoolVector; const VName: String);
begin
  if VName=EmptyStr then
    VShowAdd(V, 'Значение')
  else
    VShowAdd(V, VName);
  VShow;
end;

procedure MShow(const M: TIntMatrix);
var
  i: Integer;
begin
  for i:= 0 to High(M) do
    VShowAdd(M[i]);
  VShow;
end;

procedure MShow(const M: TInt64Matrix);
var
  i: Integer;
begin
  for i:= 0 to High(M) do
    VShowAdd(M[i]);
  VShow;
end;

procedure MShow(const M: TStrMatrix);
var
  i: Integer;
begin
  for i:= 0 to High(M) do
    VShowAdd(M[i]);
  VShow;
end;

procedure MShowDate(const M: TDateMatrix);
var
  i: Integer;
begin
  for i:= 0 to High(M) do
    VShowAddDate(M[i]);
  VShow;
end;

procedure MShowTime(const M: TTimeMatrix);
var
  i: Integer;
begin
  for i:= 0 to High(M) do
    VShowAddTime(M[i]);
  VShow;
end;

procedure MShow(const M: TBoolMatrix);
var
  i: Integer;
begin
  for i:= 0 to High(M) do
    VShowAdd(M[i]);
  VShow;
end;




end.

