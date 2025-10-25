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

//control dimensions

procedure SetControlHeight(const AControl: TControl; const AHeight: Integer);
procedure SetControlWidth(const AControl: TControl; const AWidth: Integer);
procedure SetControlSize(const AControl: TControl; const AWidth, AHeight: Integer);

procedure SetControlHeight(const AControls: array of TControl; const AHeight: Integer);
procedure SetControlWidth(const AControls: array of TControl; const AWidth: Integer);
procedure SetControlSize(const AControls: array of TControl; const AWidth, AHeight: Integer);

procedure SetControlHeightScaleToForm(const AControl: TControl; const AHeight{PPI=96}: Integer);
procedure SetControlWidthScaleToForm(const AControl: TControl; const AWidth{PPI=96}: Integer);
procedure SetControlSizeScaleToForm(const AControl: TControl; const AWidth, AHeight{PPI=96}: Integer);

procedure SetControlHeightScaleToForm(const AControls: array of TControl; const AHeight{PPI=96}: Integer);
procedure SetControlWidthScaleToForm(const AControls: array of TControl; const AWidth{PPI=96}: Integer);
procedure SetControlSizeScaleToForm(const AControls: array of TControl; const AWidth, AHeight{PPI=96}: Integer);

//custom control dimensions and properties

procedure SetToolPanels(const AControls: array of TControl);
procedure SetFlatToolPanels(const AControls: array of TControl);
procedure SetCaptionPanels(const AControls: array of TControl);
procedure SetToolButtons(const AControls: array of TControl); //without captions
procedure SetSimpleButtons(const AControls: array of TControl); //tool buttons without panel
procedure SetEventButtons(const AControls: array of TControl); //with captions
procedure SetSpinEdits(const AControls: array of TControl);

//forms

procedure FormToScreenCenter(const AForm: TForm);
function FormModalShow(AFormClass: TFormClass): Integer;
function FormOnPanelCreate(AFormClass: TFormClass; APanel: TPanel): TForm;
procedure FormKeepMinSize(const AForm: TForm;
                          const AAutosizeBefore: Boolean = True); //use in TForm.OnShow

//menue

procedure ControlPopupMenuShow(AObject: TObject; AMenu: TPopupMenu);

//captionpanels

function ToggleCaptionPanel(const AExpanded: Boolean;
                            const ATopAllClientControl,
                                  ASplitterControl,
                                  ABottomParentControl,
                                  ASymbolControl,
                                  AToggleControl: TControl): Boolean;

//images

function ChooseImageListForScreenPPI(const AImages100, AImages125,
                                           AImages150, AImages175: TImageList): TImageList;
procedure SetSpeedButtonImagesForScreenPPI(const AImages100, AImages125,
                                           AImages150, AImages175: TImageList;
                                           const AButtons: array of TSpeedButton);


implementation

procedure ControlSizeUnlock(const AControl: TControl);
begin
  AControl.AutoSize:= False;
  AControl.Constraints.MaxHeight:= 0;
  AControl.Constraints.MinHeight:= 0;
  AControl.Constraints.MaxWidth:= 0;
  AControl.Constraints.MinWidth:= 0;
end;

procedure SetControlHeight(const AControl: TControl; const AHeight: Integer);
begin
  ControlSizeUnlock(AControl);
  AControl.Height:= AHeight;
end;

procedure SetControlWidth(const AControl: TControl; const AWidth: Integer);
begin
  ControlSizeUnlock(AControl);
  AControl.Width:= AWidth;
end;

procedure SetControlSize(const AControl: TControl; const AWidth, AHeight: Integer);
begin
  ControlSizeUnlock(AControl);
  AControl.Width:= AWidth;
  AControl.Height:= AHeight;
end;

procedure SetControlHeight(const AControls: array of TControl; const AHeight: Integer);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    SetControlHeight(AControls[i], AHeight);
end;

procedure SetControlWidth(const AControls: array of TControl; const AWidth: Integer);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    SetControlWidth(AControls[i], AWidth);
end;

procedure SetControlSize(const AControls: array of TControl; const AWidth, AHeight: Integer);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    SetControlSize(AControls[i], AWidth, AHeight);
end;

procedure SetControlHeightScaleToForm(const AControl: TControl; const AHeight: Integer);
begin
  SetControlHeight(AControl, AControl.Scale96ToForm(AHeight));
end;

procedure SetControlWidthScaleToForm(const AControl: TControl; const AWidth: Integer);
begin
  SetControlWidth(AControl, AControl.Scale96ToForm(AWidth));
end;

procedure SetControlSizeScaleToForm(const AControl: TControl; const AWidth, AHeight: Integer);
begin
  SetControlSize(AControl, AControl.Scale96ToForm(AWidth), AControl.Scale96ToForm(AHeight));
end;

procedure SetControlHeightScaleToForm(const AControls: array of TControl; const AHeight: Integer);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    SetControlHeightScaleToForm(AControls[i], AHeight);
end;

procedure SetControlWidthScaleToForm(const AControls: array of TControl; const AWidth: Integer);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    SetControlWidthScaleToForm(AControls[i], AWidth);
end;

procedure SetControlSizeScaleToForm(const AControls: array of TControl; const AWidth, AHeight: Integer);
var
  i: Integer;
begin
  for i:= 0 to High(AControls) do
    SetControlSizeScaleToForm(AControls[i], AWidth, AHeight);
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
begin
  SetControlHeightScaleToForm(AControls, TOOL_PANEL_HEIGHT_DEFAULT);
end;

procedure SetFlatToolPanels(const AControls: array of TControl);
begin
  SetControlHeightScaleToForm(AControls, TOOL_PANEL_HEIGHT_DEFAULT-4);
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
    SetControlHeightScaleToForm(AControls[i], h);
    AControls[i].Color:= c;
  end;
end;

procedure SetToolButtons(const AControls: array of TControl);
begin
  SetControlWidthScaleToForm(AControls, TOOL_BUTTON_WIDTH_DEFAULT);
end;

procedure SetSimpleButtons(const AControls: array of TControl);
begin
  SetControlSizeScaleToForm(AControls, TOOL_BUTTON_WIDTH_DEFAULT, TOOL_PANEL_HEIGHT_DEFAULT - 2);
end;

procedure SetEventButtons(const AControls: array of TControl);
begin
  SetControlHeightScaleToForm(AControls, TOOL_PANEL_HEIGHT_DEFAULT - 2);
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

