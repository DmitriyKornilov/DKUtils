unit DK_XlsxExport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, fpstypes, fpspreadsheet, DK_Dialogs, DK_StrUtils;

const
  MAX_SHEETNAME_LENGTH = 31;

type
    TPageFit = (pfOnePage, //всё на одной странице
                pfWidth,   //заполнить по ширине 1 страницы (по высоте - сколько нужно, чтобы вместить все)
                pfHeight); //заполнить по высоте 1 страницы (по ширине - сколько нужно, чтобы вместить все)

    { TXLSXExport }

    TXLSXExport = class (TObject)
    private
      FWorkbook: TsWorkbook;
      function GetWorksheet: TsWorksheet;
    public
      constructor Create;
      destructor  Destroy; override;
      function AddWorksheet(const AName: String): TsWorksheet;
      procedure Save(const ADoneMessage: String = '';
                     const ADefaultFileName: String = '';
                     const ANeedShowSaveDialog: Boolean = True);
      procedure PageSettings(const AWorkSheet: TsWorksheet;
                             const AOrient: TsPageOrientation;
                             const APageFit: TPageFit;
                             const ATMargin, ALMargin, ARMargin, ABMargin: Double;
                             const AFooterMargin: Double=0; const AHeaderMargin: Double=0);
      property Worksheet: TsWorksheet read GetWorksheet;
    end;

    function TextToSheetName(const AText: String): String;



implementation

function TextToSheetName(const AText: String): String;
const
  INVALID_CHARS: array [0..6] of String = ('[', ']', ':', '*', '?', '/', '\');
var
  i: Integer;
begin
  Result:= SCopy(AText, 1, MAX_SHEETNAME_LENGTH);
  for i:=0 to High(INVALID_CHARS) do
    StringReplace(Result, INVALID_CHARS[i], '-', [rfReplaceAll]);
end;

function DK_OpenSaveDialog(var AFileName: String; out AFormat: TsSpreadsheetFormat): Boolean;
var
  SD: TSaveDialog;
begin
  Result:= False;
  SD:= TSaveDialog.Create(nil);
  SD.FileName:= AFileName;
  SD.Filter:= 'Электронная таблица (*.xlsx)|*.xlsx';
  SD.DefaultExt:= '.xlsx';
  SD.Title:= 'Сохранить как';
  Result:= SD.Execute;
  if Result then
  begin
    AFileName:= SD.FileName;
    AFormat:= sfOOXML;
  end;
  FreeAndNil(SD);
end;

procedure DK_SetExportDefault(const AWorksheet: TsWorksheet;
                              const AOrient: TsPageOrientation; const APageFit: TPageFit;
                              const ATMargin, ALMargin, ARMargin, ABMargin: Double;
                              const AFooterMargin: Double = 0;
                              const AHeaderMargin: Double = 0);
begin
  AWorksheet.Options:= [soShowHeaders];
  AWorksheet.PageLayout.Orientation:= AOrient;
  AWorksheet.PageLayout.TopMargin:= ATMargin;
  AWorksheet.PageLayout.LeftMargin:= ALMargin;
  AWorksheet.PageLayout.RightMargin:= ARMargin;
  AWorksheet.PageLayout.BottomMargin:= ABMargin;
  AWorksheet.PageLayout.HeaderMargin:= AHeaderMargin;
  AWorksheet.PageLayout.FooterMargin:= AFooterMargin;
  AWorksheet.PageLayout.Options:= AWorksheet.PageLayout.Options +
                                 [poFitPages, poHorCentered];
  case APageFit of
    pfOnePage: begin
                 AWorksheet.PageLayout.FitWidthToPages:= 1;
                 AWorksheet.PageLayout.FitHeightToPages:= 1;
               end;
    pfWidth  : begin
                 AWorksheet.PageLayout.FitWidthToPages:= 1;
                 AWorksheet.PageLayout.FitHeightToPages:= 0;
               end;
    pfHeight : begin
                 AWorksheet.PageLayout.FitWidthToPages:= 0;
                 AWorksheet.PageLayout.FitHeightToPages:= 1;
               end;
  end;
end;

procedure DK_ExportToExcel(AWorkbook: TsWorkbook;
                           const ADoneMsg: String = '';
                           const ADefaultFileName: String = '';
                           const ANeedShowSaveDialog: Boolean = True);
var
  FName: String;
  FFormat: TsSpreadsheetFormat;
begin
  FName:= ADefaultFileName;
  if ANeedShowSaveDialog then
  begin
    if not DK_OpenSaveDialog(FName, FFormat) then Exit;
  end
  else begin
    if FName=EmptyStr then Exit;
    FFormat:= sfOOXML;
  end;
  AWorkbook.WriteToFile(FName, FFormat);
  if ADoneMsg<>EmptyStr then ShowInfo(ADoneMsg);
end;

{ TXLSXExport }

function TXLSXExport.GetWorksheet: TsWorksheet;
begin
  GetWorksheet:=  FWorkbook.ActiveWorksheet;
end;

constructor TXLSXExport.Create;
begin
  inherited Create;
  FWorkbook:= TsWorkbook.Create;
end;

destructor TXLSXExport.Destroy;
begin
  FreeAndNil(FWorkbook);
  inherited Destroy;
end;

function TXLSXExport.AddWorksheet(const AName: String): TsWorksheet;
begin
  AddWorksheet:= FWorkbook.AddWorksheet(TextToSheetName(AName));
end;

procedure TXLSXExport.Save(const ADoneMessage: String = '';
                           const ADefaultFileName: String = '';
                           const ANeedShowSaveDialog: Boolean = True);
begin
  DK_ExportToExcel(FWorkbook, ADoneMessage, ADefaultFileName, ANeedShowSaveDialog);
end;

procedure TXLSXExport.PageSettings(const AWorkSheet: TsWorksheet; const AOrient: TsPageOrientation;
  const APageFit: TPageFit; const ATMargin, ALMargin, ARMargin,
  ABMargin: Double; const AFooterMargin: Double=0; const AHeaderMargin: Double=0);
begin
  DK_SetExportDefault(AWorkSheet, AOrient, APageFit,
                      ATMargin, ALMargin, ARMargin, ABMargin,
                      AFooterMargin, AHeaderMargin);
end;

end.

