unit DK_CtrlUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Menus, Forms,

  DK_PPI;

type

TFormClass = class of TForm;

function ToolPanelHeight: Integer;
function ToolButtonWidth: Integer;

procedure ToolPanelSettings(const APanel: TPanel);
procedure ControlPopupMenuShow(AObject: TObject; AMenu: TPopupMenu);

function FormModalShow(AFormClass: TFormClass): Integer;
function FormOnPanelCreate(AFormClass: TFormClass; APanel: TPanel): TForm;

implementation

const
  //sizes for 96 PPI
  TOOL_PANEL_HEIGHT_DEFAULT = 34;
  TOOL_BUTTON_WIDTH_DEFAULT = TOOL_PANEL_HEIGHT_DEFAULT - 2;

function ToolPanelHeight: Integer;
begin
  Result:= HeightFromDefaultToScreen(TOOL_PANEL_HEIGHT_DEFAULT);
end;

function ToolButtonWidth: Integer;
begin
  Result:= WidthFromDefaultToScreen(TOOL_BUTTON_WIDTH_DEFAULT);
end;

procedure ToolPanelSettings(const APanel: TPanel);
begin
  APanel.AutoSize:= False;
  APanel.Height:= ToolPanelHeight;
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

