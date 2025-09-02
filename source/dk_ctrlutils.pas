unit DK_CtrlUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Controls, ExtCtrls, Menus, Forms, Buttons,

  DK_Color, DK_Const;

const
  //sizes for 96 PPI
  TOOL_PANEL_HEIGHT_DEFAULT  = 34;
  TOOL_BUTTON_WIDTH_DEFAULT  = TOOL_PANEL_HEIGHT_DEFAULT;
  EDIT_BUTTON_HEIGHT_DEFAULT = TOOL_PANEL_HEIGHT_DEFAULT - 2;
  EDIT_BUTTON_WIDTH_EXTRA    = 6;

type

TFormClass = class of TForm;

procedure ControlHeight(const AControl: TControl; const ADefaultHeight{PPI=96}: Integer);
procedure ControlWidth(const AControl: TControl; const ADefaultWidth{PPI=96}: Integer);

procedure ControlPopupMenuShow(AObject: TObject; AMenu: TPopupMenu);

procedure FormToScreenCenter(const AForm: TForm);
function FormModalShow(AFormClass: TFormClass): Integer;
function FormOnPanelCreate(AFormClass: TFormClass; APanel: TPanel): TForm;
procedure FormKeepMinSize(const AForm: TForm;
                          const AAutosizeBefore: Boolean = True); //use in TForm.OnShow

procedure SetToolPanels(const AControls: array of TControl);
procedure SetCaptionPanels(const AControls: array of TControl);
procedure SetToolButtons(const AControls: array of TControl); //without captions
procedure SetSimpleButtons(const AControls: array of TControl); //tool buttons without panel
procedure SetEventButtons(const AControls: array of TControl); //with captions
procedure SetSpinEdits(const AControls: array of TControl);

function ToggleCaptionPanel(const AExpanded: Boolean;
                            const ATopAllClientControl,
                                  ASplitterControl,
                                  ABottomParentControl,
                                  ASymbolControl,
                                  AToggleControl: TControl): Boolean;

function ChooseImageListForScreenPPI(const AImages100, AImages125,
                                           AImages150, AImages175: TImageList): TImageList;
procedure SetSpeedButtonImagesForScreenPPI(const AImages100, AImages125,
                                           AImages150, AImages175: TImageList;
                                           const AButtons: array of TSpeedButton);


implementation

function ControlSize(const AControl: TControl; const ADefaultSize: Integer): Integer;
begin
  AControl.AutoSize:= False;
  AControl.Constraints.MaxHeight:= 0;
  AControl.Constraints.MinHeight:= 0;
  AControl.Constraints.MaxWidth:= 0;
  AControl.Constraints.MinWidth:= 0;
  Result:= AControl.Scale96ToForm(ADefaultSize);
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

procedure FormToScreenCenter(const AForm: TForm);
begin
  AForm.Left:= (Screen.Width - AForm.Width) div 2;
  AForm.Top:= (Screen.Height - AForm.Height) div 2;
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

procedure FormKeepMinSize(const AForm: TForm;
                          const AAutosizeBefore: Boolean = True);
begin
  AForm.Autosize:= AAutosizeBefore;
  AForm.Constraints.MinHeight:= AForm.Height;
  AForm.Constraints.MinWidth:= AForm.Width;
  AForm.Autosize:= False;
end;

procedure SetToolPanels(const AControls: array of TControl);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    ControlHeight(AControls[i], TOOL_PANEL_HEIGHT_DEFAULT);
end;

procedure SetCaptionPanels(const AControls: array of TControl);
var
  i, h: Integer;
  c: TColor;
begin
  h:= Round(TOOL_PANEL_HEIGHT_DEFAULT*0.70);
  c:= ColorIncLightness(clBtnFace, -15);
  for i:= 0 to High(AControls) do
  begin
    ControlHeight(AControls[i], h);
    AControls[i].Color:= c;
  end;
end;

procedure SetToolButtons(const AControls: array of TControl);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    ControlWidth(AControls[i], TOOL_BUTTON_WIDTH_DEFAULT);
end;

procedure SetSimpleButtons(const AControls: array of TControl);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
  begin
    ControlWidth(AControls[i], TOOL_BUTTON_WIDTH_DEFAULT);
    ControlHeight(AControls[i], TOOL_PANEL_HEIGHT_DEFAULT - 2);
  end;
end;

procedure SetEventButtons(const AControls: array of TControl);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    ControlHeight(AControls[i], TOOL_PANEL_HEIGHT_DEFAULT - 2);
end;

procedure SetSpinEdits(const AControls: array of TControl);
var
  i, W: Integer;
begin
  for i:= 0 to High(AControls) do
  begin
    AControls[i].AutoSize:= True;
    W:= AControls[i].Width;
    AControls[i].AutoSize:= False;
    AControls[i].Width:= W + 5;
  end;
end;

function ToggleCaptionPanel(const AExpanded: Boolean;
                            const ATopAllClientControl,
                                  ASplitterControl,
                                  ABottomParentControl,
                                  ASymbolControl,
                                  AToggleControl: TControl): Boolean;
begin
  if Assigned(ATopAllClientControl) then
    ATopAllClientControl.Align:= alTop;
  if Assigned(ABottomParentControl) then
    ABottomParentControl.Visible:= False;
  if Assigned(ASplitterControl) then
    ASplitterControl.Align:= alTop;

  try

    AToggleControl.Visible:= AExpanded;
    if AToggleControl.Visible then
    begin
      if Assigned(ABottomParentControl) then
        ABottomParentControl.Height:= ABottomParentControl.Height + AToggleControl.Height;
      ASymbolControl.Caption:= SYMBOL_COLLAPSE;
    end
    else begin
      if Assigned(ABottomParentControl) then
        ABottomParentControl.Height:= ABottomParentControl.Height - AToggleControl.Height;
      ASymbolControl.Caption:= SYMBOL_DROPDOWN;
    end;
    Result:= AToggleControl.Visible;

  finally
    if Assigned(ABottomParentControl) then
      ABottomParentControl.Visible:= True;
    if Assigned(ASplitterControl) then
      ASplitterControl.Align:= alBottom;
    if Assigned(ATopAllClientControl) then
      ATopAllClientControl.Align:= alClient;
  end;
end;

function ChooseImageListForScreenPPI(const AImages100, AImages125, AImages150, AImages175: TImageList): TImageList;
var
  PPI: Integer;
begin
  PPI:= Screen.PixelsPerInch;
  if PPI<108 then
    Result:= AImages100
  else if PPI<132 then
    Result:= AImages125
  else if PPI<156 then
    Result:= AImages150
  else
    Result:= AImages175;
end;

procedure SetSpeedButtonImagesForScreenPPI(const AImages100, AImages125,
                                           AImages150, AImages175: TImageList;
                                           const AButtons: array of TSpeedButton);
var
  i: Integer;
  L: TImageList;
begin
  L:= ChooseImageListForScreenPPI(AImages100, AImages125, AImages150, AImages175);
  for i:= 0 to High(AButtons) do
    AButtons[i].Images:= L;
end;

end.

