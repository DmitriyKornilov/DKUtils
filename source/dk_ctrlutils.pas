unit DK_CtrlUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Menus, Forms,

  DK_PPI;

const
  //sizes for 96 PPI
  TOOL_PANEL_HEIGHT_DEFAULT = 34;
  TOOL_BUTTON_WIDTH_DEFAULT = TOOL_PANEL_HEIGHT_DEFAULT;// - 2;

type

TFormClass = class of TForm;

procedure ControlHeight(const AControl: TControl; const ADefaultHeight{PPI=96}: Integer);
procedure ControlWidth(const AControl: TControl; const ADefaultWidth{PPI=96}: Integer);

procedure ControlPopupMenuShow(AObject: TObject; AMenu: TPopupMenu);

function FormModalShow(AFormClass: TFormClass): Integer;
function FormOnPanelCreate(AFormClass: TFormClass; APanel: TPanel): TForm;

implementation

function ControlSize(const AControl: TControl; const ADefaultSize: Integer): Integer;
begin
  AControl.AutoSize:= False;
  AControl.Constraints.MaxHeight:= 0;
  AControl.Constraints.MinHeight:= 0;
  AControl.Constraints.MaxWidth:= 0;
  AControl.Constraints.MinWidth:= 0;
  Result:= SizeFromDefaultToDesignTime(ADefaultSize, ControlDesignTimePPI(AControl));
end;

procedure ControlHeight(const AControl: TControl; const ADefaultHeight: Integer);
begin
  AControl.Height:= ControlSize(AControl, ADefaultHeight);
end;

procedure ControlWidth(const AControl: TControl; const ADefaultWidth: Integer);
begin
  AControl.Width:= ControlSize(AControl, ADefaultWidth);
end;

procedure ControlPopupMenuShow(AObject: TObject; AMenu: TPopupMenu);
var
  C: TControl;
  P: TPoint;
begin
  if not (AObject is TControl) then Exit;
  C := AObject as TControl;
  P := Point(0, C.Height);
  P := C.ClientToScreen(P);
  AMenu.Popup(P.X, P.Y);
end;

function FormModalShow(AFormClass: TFormClass): Integer;
var
  Frm: TForm;
begin
  Frm:= AFormClass.Create(nil);
  try
    Result:= Frm.ShowModal;
  finally
    FreeAndNil(Frm);
  end;
end;

function FormOnPanelCreate(AFormClass: TFormClass; APanel: TPanel): TForm;
begin
  Result:= AFormClass.Create(APanel);
  Result.BorderStyle:= bsNone;
  Result.Parent:= APanel;
  Result.Left:= 0;
  Result.Top:= 0;
  Result.Align:= alClient;
  Result.MakeFullyVisible();
end;

end.

