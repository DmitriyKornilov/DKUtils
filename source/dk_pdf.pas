unit DK_PDF;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpPDF, fpImage, fpTTF, DK_Vector, DK_TextUtils, DK_StrUtils;

type
  TPDFFloat = type fpPDF.TPDFFloat;
  TStringAlignment = (saLeft, saCenter, saRight, saFit);

  { TPDFWriter }

  TPDFWriter = class (TObject)
  private
    FDocument: TPDFDocument;
    FSection: TPDFSection;
    FPage: TPDFPage;

    FShowFrame: Boolean;

    FMarginLeft: TPDFFloat;
    FMarginRight: TPDFFloat;
    FMarginTop: TPDFFloat;
    FMarginBottom: TPDFFloat;

    //useful page coordinates
    FX1, FY1: TPDFFloat; // left top point
    FX2, FY2: TPDFFloat; // right bottom point

    FFontIndexes: TIntVector;
    FFontNames: TStrVector;
    FFontFamilies: TStrVector;
    FFontBolds: TBoolVector;
    FFontItalics: TBoolVector;

    FCurrentFontIndex: Integer;
    FCurrentFontSize: Integer;
    FCurrentFontHeight: TPDFFloat;
    FCurrentFontDesc: TPDFFloat;
    FCurrentFontColor: TARGBColor;

    function GetFontIndex(const AFontName: String): Integer;
    procedure GetWords(const AText: String;
                        out AWords: TStrVector;
                        out AWidths: TDblVector);


    function LoadImage(const AFileName: String;
                       out AImageWidth, AImageHeight: TPDFFloat): Integer;
    function LoadImage(const AStream: TMemoryStream; const AExtension: String;
                       out AImageWidth, AImageHeight: TPDFFloat): Integer;
  public
    constructor Create(const AFontDir: String);
    destructor  Destroy; override;

    procedure AddFont(const AFileName, AFontFamily, AFontName: String;
                      const ABold, AItalic: Boolean);
    procedure SetFont(const AFontName: String; const AFontSize: Integer);
    procedure SetFont(const AFontIndex, AFontSize: Integer);
    procedure SetFontColor(const AColor: TARGBColor);

    procedure AddPage(const ALeftMargin  : TPDFFloat = 20.0;
                      const ARightMargin : TPDFFloat = 10.0;
                      const ATopMargin   : TPDFFloat = 10.0;
                      const ABottomMargin: TPDFFloat = 10.0); virtual;


    procedure WriteImageTopLeft(const AFileName: String;
                                const AX, AY: TPDFFloat; // top left point
                                out AImageWidth, AImageHeight: TPDFFloat);
    procedure WriteImageTopLeft(const AStream: TMemoryStream;
                                const AExtension: String;
                                const AX, AY: TPDFFloat; // top left point
                                out AImageWidth, AImageHeight: TPDFFloat);

    procedure WriteImageBottomLeft(const AFileName: String;
                                const AX, AY: TPDFFloat; // bottom left point
                                out AImageWidth, AImageHeight: TPDFFloat);
    procedure WriteImageBottomLeft(const AStream: TMemoryStream;
                                const AExtension: String;
                                const AX, AY: TPDFFloat; // bottom left point
                                out AImageWidth, AImageHeight: TPDFFloat);

    procedure WriteImageTopLeftFitWidth(const AFileName: String;
                                const AX, AY: TPDFFloat; // top left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);
    procedure WriteImageTopLeftFitWidth(const AStream: TMemoryStream;
                                const AExtension: String;
                                const AX, AY: TPDFFloat; // top left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);

    procedure WriteImageBottomLeftFitWidth(const AFileName: String;
                                const AX, AY: TPDFFloat; // bottom left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);
    procedure WriteImageBottomLeftFitWidth(const AStream: TMemoryStream;
                                const AExtension: String;
                                const AX, AY: TPDFFloat; // bottom left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);

    procedure AlignString(const ALeftX, ARightX, AY: TPDFFloat;
                          const AText: String;
                          const AAlignment: TStringAlignment);
    procedure FitString(const ALeftX, ARightX, AY: TPDFFloat;
                          const AText: String);
    procedure WriteString(const ALeftX, ARightX, AY: TPDFFloat;
                          const AText: String;
                          const AAlignment: TStringAlignment);


    procedure WriteURL(const ALeftX, ARightX, AY: TPDFFloat;
                        const AText, AURL: String;
                        const AAlignment: TStringAlignment);


    procedure SaveToFile(const AFileName: String);

    property Document: TPDFDocument read FDocument;
    property Page: TPDFPage read FPage;

    property ShowFrame: Boolean read FShowFrame write FShowFrame;

    //left top page point in margins
    property PageX1: TPDFFloat read FX1;
    property PageY1: TPDFFloat read FY1;
    //right bottom page point in margins
    property PageX2: TPDFFloat read FX2;
    property PageY2: TPDFFloat read FY2;

    property MarginLeft: TPDFFloat read FMarginLeft;
    property MarginRight: TPDFFloat read FMarginRight;
    property MarginTop: TPDFFloat read FMarginTop;
    property MarginBottom: TPDFFloat read FMarginBottom;

    property FontColor: TARGBColor read FCurrentFontColor;
    property FontIndex: Integer read FCurrentFontIndex;
    property FontSize: Integer read FCurrentFontSize;
    property FontHeight: TPDFFloat read FCurrentFontHeight;
    property FontDesc: TPDFFloat read FCurrentFontDesc;
    function FontWidth(const AText: String): TPDFFloat;
  end;

  { TPDFLetter }

  TPDFLetter = class (TPDFWriter)
  private
    FCurrentY: TPDFFloat;
    procedure WriteSignature(const AText: TStrVector;
                             const AName: String;
                             const ASignIndex, AStampIndex: Integer;
                             const AInterval: TPDFFloat = 1.0;
                             const AIndentMM: TPDFFloat = 0.0;
                             const ASignWidth: TPDFFloat = 30.0;
                             const AStampWidth: TPDFFloat = 40.0;
                             const AAfterSpace: TPDFFloat = 0.0
                             );
    procedure GetImageIndexes(const ASignFileName, AStampFileName: String;
                              out ASignIndex, AStampIndex: Integer);
    procedure GetImageIndexes(const ASignImage: TMemoryStream;
                              const ASignFileExtension: String;
                              const AStampImage: TMemoryStream;
                              const AStampFileExtension: String;
                              out ASignIndex, AStampIndex: Integer);
  protected
    function BusyBottomSpace: TPDFFloat; virtual;
    procedure NextString(const AInterval: TPDFFloat=1.0);
    function NextPage(const ARowHeight, ANewPageTopSpace: TPDFFloat;
                      const AIsNotWrap: Boolean): Boolean;
  public
    property CurrentY: TPDFFloat read  FCurrentY;
    procedure WriteSpace(const ADeltaY: TPDFFloat);  // inc CurrentY

    procedure AddPage(const ALeftMargin  : TPDFFloat = 20.0;
                      const ARightMargin : TPDFFloat = 10.0;
                      const ATopMargin   : TPDFFloat = 10.0;
                      const ABottomMargin: TPDFFloat = 10.0); override;
    // fit from ACoordX1 to ACoordX2 with keep image proportions
    procedure WriteImageFitWidth(const AFileName: String;
                                 const ACoordX1, ACoordX2: TPDFFloat);
    procedure WriteImageFitWidth(const AStream: TMemoryStream;
                                 const AExtension: String;
                                 const ACoordX1, ACoordX2: TPDFFloat);



    procedure WriteHyperlink(const AText, AURL: String;
                        const AAlignment: TStringAlignment;
                        const AInterval: TPDFFloat = 1.0;
                        const AIndentMM: TPDFFloat = 0.0);
    procedure WriteTextRow(const AText: String;
                        const AAlignment: TStringAlignment;
                        const AInterval: TPDFFloat = 1.0;
                        const AIndentMM: TPDFFloat = 0.0);
    procedure WriteTextRows(const AText: TStrVector;
                        const AAlignment: TStringAlignment;
                        const AInterval: TPDFFloat = 1.0;
                        const AIndentMM: TPDFFloat = 0.0);
    procedure WriteTextParagraph(const AText: String;
                        const AAlignment: TStringAlignment;
                        const AInterval: TPDFFloat = 1.0;
                        const AFirstIndentMM: TPDFFloat = 0.0);

    procedure WriteSignature(const AText: TStrVector;
                             const AName: String;
                             const AInterval: TPDFFloat = 1.0;
                             const AIndentMM: TPDFFloat = 0.0;
                             const AAfterSpace: TPDFFloat = 0.0;
                             const ASignImage: TMemoryStream = nil;
                             const ASignFileExtension: String = '';
                             const ASignWidth: TPDFFloat = 30.0;
                             const AStampImage: TMemoryStream = nil;
                             const AStampFileExtension: String = '';
                             const AStampWidth: TPDFFloat = 40.0);
    procedure WriteSignature(const AText: TStrVector;
                             const AName: String;
                             const AInterval: TPDFFloat = 1.0;
                             const AIndentMM: TPDFFloat = 0.0;
                             const AAfterSpace: TPDFFloat = 0.0;
                             const ASignFileName: String = '';
                             const ASignWidth: TPDFFloat = 30.0;
                             const AStampFileName: String = '';
                             const AStampWidth: TPDFFloat = 40.0);

  end;



implementation

{ TPDFLetter }

function TPDFLetter.BusyBottomSpace: TPDFFloat;
begin
  Result:= 0;
end;

procedure TPDFLetter.WriteSignature(const AText: TStrVector;
                             const AName: String;
                             const ASignIndex, AStampIndex: Integer;
                             const AInterval: TPDFFloat = 1.0;
                             const AIndentMM: TPDFFloat = 0.0;
                             const ASignWidth: TPDFFloat = 30.0;
                             const AStampWidth: TPDFFloat = 40.0;
                             const AAfterSpace: TPDFFloat = 0.0);
var
  i: Integer;
  ImageWidth, ImageHeight, W, H, X, Y: TPDFFloat;
  RowHeight, LeftMaxWidth, TextHeight, TotalHeight: TPDFFloat;
begin
  //высота строки текста
  RowHeight:= FontHeight*(1+AInterval);
  //высота, занимаемая текстом слева
  TextHeight:= Length(AText)*RowHeight;

  //максимальная ширина подписи
  LeftMaxWidth:= 0;
  for i:= 0 to High(AText) do
  begin
    X:= FontWidth(AText[i]);
    if X>LeftMaxWidth then LeftMaxWidth:= X;
  end;

  NextString(AInterval);
  if (AStampIndex<0) and (ASignIndex<0) then //нет ни факсимиле ни печати
  begin
    TotalHeight:= TextHeight + AAfterSpace;
    NextPage(TotalHeight, 0, True {нельзя разрывать});
    WriteTextRows(AText, saLeft, AInterval, AIndentMM);
    AlignString(PageX1, PageX2, CurrentY, AName, saRight);
  end
  else begin
    if AStampIndex>=0 then //есть печать
    begin
      ImageWidth:= PDFtoMM(Document.Images[AStampIndex].Width);
      ImageHeight:= PDFtoMM(Document.Images[AStampIndex].Height);
      W:= AStampWidth;
      H:= ImageHeight * W / ImageWidth;

      //высота занимаемая всей подписью
      TotalHeight:= TextHeight + AAfterSpace;
      if H>TextHeight then
        TotalHeight:= H;
      NextPage(TotalHeight, 0, True {нельзя разрывать});

      Y:= H/2 - TextHeight;
      if Y>0 then
        WriteSpace(Y);
      WriteTextRows(AText, saLeft, AInterval, AIndentMM);
      AlignString(PageX1, PageX2, CurrentY, AName, saRight);

      Y:= CurrentY + H/2;
      X:= PageX1 + AIndentMM + LeftMaxWidth + 1.0{!!!};
      Page.DrawImage(X, Y, W, H, AStampIndex);
    end;
    if ASignIndex>=0 then   //есть факсимиле
    begin
      ImageWidth:= PDFtoMM(Document.Images[ASignIndex].Width);
      ImageHeight:= PDFtoMM(Document.Images[ASignIndex].Height);
      W:= ASignWidth;
      H:= ImageHeight * W / ImageWidth;
      if AStampIndex<0 then //нет печати
      begin
        //высота занимаемая всей подписью
        TotalHeight:= TextHeight  + AAfterSpace;
        if H>TextHeight then
          TotalHeight:= H;
        NextPage(TotalHeight, 0, True {нельзя разрывать});

        Y:= H/2 - TextHeight;
        if Y>0 then
          WriteSpace(Y);
        WriteTextRows(AText, saLeft, AInterval, AIndentMM);
        AlignString(PageX1, PageX2, CurrentY, AName, saRight);
      end;

      Y:= CurrentY + H/2;
      X:= PageX1 + AIndentMM + LeftMaxWidth + 1.0{!!!} + AStampWidth + 1.0{!!!};
      Page.DrawImage(X, Y, W, H, ASignIndex);
    end;
  end;
end;

procedure TPDFLetter.GetImageIndexes(const ASignFileName, AStampFileName: String;
                              out ASignIndex, AStampIndex: Integer);
begin
  ASignIndex:= -1;
  if not Sempty(ASignFileName) then
    if FileExists(ASignFileName) then
      ASignIndex:= Document.Images.AddFromFile(ASignFileName);

  AStampIndex:= -1;
  if not Sempty(AStampFileName) then
    if FileExists(AStampFileName) then
      AStampIndex:= Document.Images.AddFromFile(AStampFileName);
end;

procedure TPDFLetter.GetImageIndexes(const ASignImage: TMemoryStream;
                              const ASignFileExtension: String;
                              const AStampImage: TMemoryStream;
                              const AStampFileExtension: String;
                              out ASignIndex, AStampIndex: Integer);
var
  Handler: TFPCustomImageReaderClass;
begin
  ASignIndex:= -1;
  if Assigned(ASignImage) and (not SEmpty(ASignFileExtension)) then
  begin
    Handler:= TFPCustomImage.FindReaderFromExtension(ASignFileExtension);
    ASignIndex:= Document.Images.AddFromStream(ASignImage, Handler);
  end;

  AStampIndex:= -1;
  if Assigned(AStampImage) and (not SEmpty(AStampFileExtension)) then
  begin
    Handler:= TFPCustomImage.FindReaderFromExtension(AStampFileExtension);
    AStampIndex:= Document.Images.AddFromStream(AStampImage, Handler);
  end;
end;

procedure TPDFLetter.NextString(const AInterval: TPDFFloat = 1.0);
var
  H: TPDFFloat;
begin
  H:= FontHeight * (1 + AInterval);
  WriteSpace(H);
end;

procedure TPDFLetter.WriteSpace(const ADeltaY: TPDFFloat);
begin
  FCurrentY:= FCurrentY + ADeltaY;
end;

procedure TPDFLetter.AddPage(const ALeftMargin  : TPDFFloat = 20.0;
                      const ARightMargin : TPDFFloat = 10.0;
                      const ATopMargin   : TPDFFloat = 10.0;
                      const ABottomMargin: TPDFFloat = 10.0);
begin
  inherited AddPage(ALeftMargin, ARightMargin, ATopMargin, ABottomMargin);
  FCurrentY:= FY1;
end;

procedure TPDFLetter.WriteImageFitWidth(const AFileName: String;
                                const ACoordX1, ACoordX2: TPDFFloat);
var
  W, H: TPDFFloat;
begin
  W:= ACoordX2 - ACoordX1;
  WriteImageTopLeftFitWidth(AFileName, ACoordX1, FCurrentY, W, H);
  WriteSpace(H);
end;

procedure TPDFLetter.WriteImageFitWidth(const AStream: TMemoryStream;
                                 const AExtension: String;
                                 const ACoordX1, ACoordX2: TPDFFloat);
var
  W, H: TPDFFloat;
begin
  W:= ACoordX2 - ACoordX1;
  WriteImageTopLeftFitWidth(AStream, AExtension, ACoordX1, FCurrentY, W, H);
  WriteSpace(H);
end;

procedure TPDFLetter.WriteHyperlink(
                const AText, AURL: String;
                const AAlignment: TStringAlignment;
                const AInterval: TPDFFloat = 1.0;
                const AIndentMM: TPDFFloat = 0.0);
var
  RowHeight: TPDFFloat;
begin
  NextString(AInterval);
  RowHeight:= (1 + AInterval) * FontHeight;
  NextPage(RowHeight, RowHeight, False {можно перенести});
  WriteURL(PageX1+AIndentMM, PageX2, FCurrentY, AText, AURL, AAlignment);
end;

function TPDFLetter.NextPage(const ARowHeight, ANewPageTopSpace: TPDFFloat;
                             const AIsNotWrap: Boolean): Boolean;
var
  PageSpace: TPDFFloat;
begin
  Result:= False; //переход на следующую страницу не нужен
  //свободное место до конца страницы с учетом данных внизу страницы
  PageSpace:= PageY2 - BusyBottomSpace - FCurrentY;

  if ARowHeight>PageSpace then //текст не умещается на странице
  begin
    if AIsNotWrap then //текст не может быть разорван
      Result:= True    //т.е. обязательно нужен переход на следующую страницу
    else begin         //текст может быть разорван
      //свободное место до конца страницы без учета данных внизу страницы
      PageSpace:= PageY2 - FCurrentY;
      if ARowHeight>PageSpace then //текст все равно не умещается
        Result:= True;             //т.е. нужен переход на следующую страницу
    end;
  end;

  if not Result then Exit;
  AddPage(MarginLeft, MarginRight, MarginTop, MarginBottom);
  SetFont(FCurrentFontIndex, FCurrentFontSize);
  WriteSpace(ANewPageTopSpace);
end;

procedure TPDFLetter.WriteTextRow(
                    const AText: String;
                    const AAlignment: TStringAlignment;
                    const AInterval: TPDFFloat = 1.0;
                    const AIndentMM: TPDFFloat = 0.0);
var
  RowHeight: TPDFFloat;
begin
  NextString(AInterval);
  RowHeight:= (1 + AInterval) * FontHeight;
  NextPage(RowHeight, RowHeight, False {можно перенести});
  WriteString(PageX1+AIndentMM, PageX2, FCurrentY, AText, AAlignment);
end;

procedure TPDFLetter.WriteTextRows(const AText: TStrVector;
                                   const AAlignment: TStringAlignment;
                                   const AInterval: TPDFFloat = 1.0;
                                   const AIndentMM: TPDFFloat = 0.0);
var
  i: Integer;
begin
  for i:= 0 to High(AText) do
    WriteTextRow(AText[i], AAlignment, AInterval, AIndentMM);
end;

procedure TPDFLetter.WriteTextParagraph(const AText: String;
                                        const AAlignment: TStringAlignment;
                                        const AInterval: TPDFFloat = 1.0;
                                        const AFirstIndentMM: TPDFFloat = 0.0);
var
  i, j, k1, k2: Integer;
  TextRows: TStrVector;
  Words: TStrVector;
  Widths: TDblVector;
  SpaceWidth: TPDFFloat;

  W, TotalW: TPDFFloat;
  S: String;
begin
  TotalW:= PageX2 - PageX1;
  if FontWidth(AText)<=TotalW then // one row text
  begin
    WriteTextRow(AText, AAlignment, AInterval, AFirstIndentMM);
    Exit;
  end;

  TextRows:= nil;
  GetWords(AText, Words, Widths);
  SpaceWidth:= FontWidth(' ');

  k1:= 0;
  W:= AFirstIndentMM + Widths[k1];
  for i:= 1 to High(Words) do
  begin
    W:= W + SpaceWidth + Widths[i];
    if W>TotalW then  // overfull
    begin
      k2:= i-1;
      S:= Words[k1];
      for j:= k1+1 to k2 do
        S:= S + ' ' + Words[j];
      VAppend(TextRows, S);
      k1:= i;
      W:= Widths[k1];
    end;
  end;
  S:= Words[k1];
  for j:= k1+1 to High(Words) do
    S:= S + ' ' + Words[j];
  VAppend(TextRows, S);

  if VIsNil(TextRows) then Exit;

  if AAlignment<>saFit then
  begin
    WriteTextRow(TextRows[0], AAlignment, AInterval, AFirstIndentMM);
    for i:= 1 to High(TextRows) do
      WriteTextRow(TextRows[i], AAlignment, AInterval, 0.0);
  end else
  begin
    if Length(TextRows)=1 then
      WriteTextRow(TextRows[0], saLeft, AInterval, AFirstIndentMM)
    else
      WriteTextRow(TextRows[0], saFit, AInterval, AFirstIndentMM);
    for i:= 1 to High(TextRows)-1 do
      WriteTextRow(TextRows[i], saFit, AInterval, 0.0);
    WriteTextRow(VLast(TextRows), saLeft, AInterval, 0.0);
  end;
end;

procedure TPDFLetter.WriteSignature(const AText: TStrVector;
                             const AName: String;
                             const AInterval: TPDFFloat = 1.0;
                             const AIndentMM: TPDFFloat = 0.0;
                             const AAfterSpace: TPDFFloat = 0.0;
                             const ASignImage: TMemoryStream = nil;
                             const ASignFileExtension: String = '';
                             const ASignWidth: TPDFFloat = 30.0;
                             const AStampImage: TMemoryStream = nil;
                             const AStampFileExtension: String = '';
                             const AStampWidth: TPDFFloat = 40.0);
var
  I1, I2: Integer;
begin
  GetImageIndexes(ASignImage, ASignFileExtension,
                  AStampImage, AStampFileExtension, I1, I2);
  WriteSignature(AText, AName, I1, I2, AInterval, AIndentMM,
                 ASignWidth, AStampWidth, AAfterSpace);
end;

procedure TPDFLetter.WriteSignature(const AText: TStrVector;
                             const AName: String;
                             const AInterval: TPDFFloat = 1.0;
                             const AIndentMM: TPDFFloat = 0.0;
                             const AAfterSpace: TPDFFloat = 0.0;
                             const ASignFileName: String = '';
                             const ASignWidth: TPDFFloat = 30.0;
                             const AStampFileName: String = '';
                             const AStampWidth: TPDFFloat = 40.0);
var
  I1, I2: Integer;
begin
  GetImageIndexes(ASignFileName, AStampFileName, I1, I2);
  WriteSignature(AText, AName, I1, I2, AInterval, AIndentMM,
                 ASignWidth, AStampWidth, AAfterSpace);
end;


{ TPDFWriter }

function TPDFWriter.GetFontIndex(const AFontName: String): Integer;
var
  Ind: Integer;
begin
  Result:= -1;
  Ind:= VIndexOf(FFontNames, AFontName, False);
  if Ind>=0 then
    Result:= FFontIndexes[Ind];
end;

procedure TPDFWriter.GetWords(const AText: String;
                              out AWords: TStrVector;
                              out AWidths: TDblVector);
var
  i: Integer;
begin
  AWords:= TextToWords(AText);
  VDim(AWidths{%H-}, Length(AWords));
  for i:= 0 to High(AWords) do
    AWidths[i]:= FontWidth(AWords[i]);
end;

procedure TPDFWriter.AlignString(const ALeftX, ARightX, AY: TPDFFloat;
                                 const AText: String;
                                 const AAlignment: TStringAlignment);
var
  W, X: TPDFFloat;
begin
  if AAlignment=saLeft then
    X:= ALeftX
  else begin
    W:= FontWidth(AText);
    if AAlignment = saRight then
      X:= ARightX - W
    else if AAlignment = saCenter then
      X:= (ALeftX + ARightX - W) / 2;
  end;
  FPage.WriteText(X, AY, AText);
end;

procedure TPDFWriter.FitString(const ALeftX, ARightX, AY: TPDFFloat;
                               const AText: String);
var
  i: Integer;
  SpaceWidth, TotalWidth, X: TPDFFloat;
  Words: TStrVector;
  Widths: TDblVector;
begin
  SpaceWidth:= FontWidth(' ');
  GetWords(AText, Words, Widths);
  TotalWidth:= VSum(Widths);

  //extra space
  SpaceWidth:= (ARightX - ALeftX - TotalWidth) / High(Words);

  X:= ALeftX;
  for i:= 0 to High(Words) - 1 do
  begin
    AlignString(X, ARightX, AY, Words[i], saLeft);
    X:= X + Widths[i] + SpaceWidth;
  end;
  AlignString(ALeftX, ARightX, AY, VLast(Words), saRight);
end;


procedure TPDFWriter.WriteString(const ALeftX, ARightX, AY: TPDFFloat;
                                 const AText: String;
                                 const AAlignment: TStringAlignment);
begin
  if FontWidth(AText)>(ARightX - ALeftX) then Exit; // used field width less then text width

  if AAlignment = saFit then
    FitString(ALeftX, ARightX, AY, AText)
  else
    AlignString(ALeftX, ARightX, AY, AText, AAlignment);
end;

constructor TPDFWriter.Create(const AFontDir: String);
begin
  //Font cache
  gTTFontCache.SearchPath.Add(AFontDir);
  gTTFontCache.BuildFontCache;

  // Create document
  FDocument:= TPDFDocument.Create(nil);
  FDocument.FontDirectory:= AFontDir;
  FDocument.Options:= FDocument.Options + [poPageOriginAtTop];
  // Start document
  FDocument.StartDocument;
  // Add a section, at least one section is needed.
  FSection:= FDocument.Sections.AddSection;

  FShowFrame:= False;
  FCurrentFontColor:= clBlack;
end;

destructor TPDFWriter.Destroy;
begin
  FreeAndNil(FDocument);
  inherited Destroy;
end;

procedure TPDFWriter.AddFont(const AFileName, AFontFamily, AFontName: String;
                      const ABold, AItalic: Boolean);
var
  Ind: Integer;
begin
  if GetFontIndex(AFontName)>=0 then Exit; // font is alredy added
  Ind:= FDocument.AddFont(AFileName, AFontName);
  VAppend(FFontIndexes, Ind);
  VAppend(FFontNames, AFontName);
  VAppend(FFontFamilies, AFontFamily);
  VAppend(FFontBolds, ABold);
  VAppend(FFontItalics, AItalic);
end;

procedure TPDFWriter.SetFont(const AFontName: String; const AFontSize: Integer);
var
  Ind: Integer;
begin
  Ind:= GetFontIndex(AFontName);
  if Ind<0 then Exit; // font does not added
  SetFont(Ind, AFontSize);
end;

procedure TPDFWriter.SetFont(const AFontIndex, AFontSize: Integer);
var
  Ind: Integer;
  FontCache: TFPFontCacheItem;
  FontHeightPX, FontDescPX: TPDFFloat;
begin
  FCurrentFontIndex:= AFontIndex;
  FCurrentFontSize:= AFontSize;
  FPage.SetFont(FCurrentFontIndex, FCurrentFontSize);

  Ind:= VIndexOf(FFontIndexes, FCurrentFontIndex);
  FontCache:= gTTFontCache.Find(FFontFamilies[Ind], FFontBolds[Ind], FFontItalics[Ind]);
  if not Assigned(FontCache) then Exit; // font not found

  FontHeightPX:= FontCache.TextHeight('X', FCurrentFontSize, FontDescPX);
  FCurrentFontHeight:= (FontHeightPX * 25.4) / gTTFontCache.DPI;  // convert to mm
  FCurrentFontDesc:= (FontDescPX * 25.4) / gTTFontCache.DPI;  // convert to mm
end;

function TPDFWriter.FontWidth(const AText: String): TPDFFloat;
var
  Ind: Integer;
  FontCache: TFPFontCacheItem;
begin
  Result:= 0;
  Ind:= VIndexOf(FFontIndexes, FCurrentFontIndex);
  FontCache:= gTTFontCache.Find(FFontFamilies[Ind], FFontBolds[Ind], FFontItalics[Ind]);
  if not Assigned(FontCache) then Exit; // font not found
  Result:= FontCache.TextWidth(AText, FCurrentFontSize); // px
  Result:= (Result * 25.4) / gTTFontCache.DPI;  // convert to mm
end;

procedure TPDFWriter.SetFontColor(const AColor: TARGBColor);
begin
  FCurrentFontColor:= AColor;
  FPage.SetColor(FCurrentFontColor, False);
end;

procedure TPDFWriter.AddPage(const ALeftMargin  : TPDFFloat = 20.0;
                             const ARightMargin : TPDFFloat = 10.0;
                             const ATopMargin   : TPDFFloat = 10.0;
                             const ABottomMargin: TPDFFloat = 10.0);
var
  W: Integer;
begin
  // Add the Page to the Section
  FPage:= FDocument.Pages.AddPage;
  FSection.AddPage(FPage);
  // Set some properties:
  FPage.PaperType := ptA4;
  FPage.UnitOfMeasure := uomMillimeters;
  FPage.SetColor(clBlack, False);
  // Margins
  FMarginLeft:= ALeftMargin;
  FMarginRight:= ARightMargin;
  FMarginTop:= ATopMargin;
  FMarginBottom:= ABottomMargin;
  //useful part of page
  FX1:= FMarginLeft;
  FY1:= FMarginTop;
  FX2:= PDFToMM(FPage.Paper.W) - FMarginRight;
  FY2:= PDFToMM(FPage.Paper.H) - FMarginBottom;

  if ShowFrame then
  begin
    W:= 1;
    FPage.DrawLine(FX1, FY1, FX2, FY1, W, True);
    FPage.DrawLine(FX2, FY1, FX2, FY2, W, True);
    FPage.DrawLine(FX2, FY2, FX1, FY2, W, True);
    FPage.DrawLine(FX1, FY2, FX1, FY1, W, True);
  end;
end;

function TPDFWriter.LoadImage(const AFileName: String;
                              out AImageWidth, AImageHeight: TPDFFloat): Integer;
begin
  Result:= -1;
  if not FileExists(AFileName) then Exit;
  Result:= FDocument.Images.AddFromFile(AFileName);
  AImageWidth:= PDFtoMM(FDocument.Images[Result].Width);
  AImageHeight:= PDFtoMM(FDocument.Images[Result].Height);
end;

function TPDFWriter.LoadImage(const AStream: TMemoryStream;
  const AExtension: String; out AImageWidth, AImageHeight: TPDFFloat): Integer;
var
  Handler: TFPCustomImageReaderClass;
begin
  Result:= -1;
  AImageWidth:= 0;
  AImageHeight:= 0;
  if Assigned(AStream) and (not SEmpty(AExtension)) then
  begin
    Handler:= TFPCustomImage.FindReaderFromExtension(AExtension);
    Result:= Document.Images.AddFromStream(AStream, Handler);
    AImageWidth:= PDFtoMM(FDocument.Images[Result].Width);
    AImageHeight:= PDFtoMM(FDocument.Images[Result].Height);
  end;
end;

procedure TPDFWriter.WriteImageTopLeft(const AFileName: String;
                                       const AX, AY: TPDFFloat; // top left point
                                       out AImageWidth, AImageHeight: TPDFFloat);
var
  Ind: Integer;
begin
  Ind:= LoadImage(AFileName, AImageWidth, AImageHeight);
  if Ind<0 then Exit;
  FPage.DrawImage(AX, AY+AImageHeight, AImageWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteImageTopLeft(const AStream: TMemoryStream; const AExtension: String;
                                const AX, AY: TPDFFloat; // top left point
                                out AImageWidth, AImageHeight: TPDFFloat);
var
  Ind: Integer;
begin
  Ind:= LoadImage(AStream, AExtension, AImageWidth, AImageHeight);
  if Ind<0 then Exit;
  FPage.DrawImage(AX, AY+AImageHeight, AImageWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteImageBottomLeft(const AFileName: String;
                                       const AX, AY: TPDFFloat;  // bottom left point
                                       out AImageWidth, AImageHeight: TPDFFloat);
var
  Ind: Integer;
begin
  Ind:= LoadImage(AFileName, AImageWidth, AImageHeight);
  if Ind<0 then Exit;
  FPage.DrawImage(AX, AY, AImageWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteImageBottomLeft(const AStream: TMemoryStream; const AExtension: String;
                                const AX, AY: TPDFFloat; // bottom left point
                                out AImageWidth, AImageHeight: TPDFFloat);
var
  Ind: Integer;
begin
  Ind:= LoadImage(AStream, AExtension, AImageWidth, AImageHeight);
  if Ind<0 then Exit;
  FPage.DrawImage(AX, AY, AImageWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteImageTopLeftFitWidth(const AFileName: String;
                                const AX, AY: TPDFFloat; // top left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);
var
  Ind: Integer;
  ImageWidth, ImageHeight: TPDFFloat;
begin
  Ind:= LoadImage(AFileName, ImageWidth, ImageHeight);
  if Ind<0 then Exit;
  AImageHeight:= ImageHeight * ANeedWidth / ImageWidth;
  FPage.DrawImage(AX, AY+AImageHeight, ANeedWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteImageTopLeftFitWidth(const AStream: TMemoryStream;
                                const AExtension: String;
                                const AX, AY: TPDFFloat; // top left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);
var
  Ind: Integer;
  ImageWidth, ImageHeight: TPDFFloat;
begin
  Ind:= LoadImage(AStream, AExtension, ImageWidth, ImageHeight);
  if Ind<0 then Exit;
  AImageHeight:= ImageHeight * ANeedWidth / ImageWidth;
  FPage.DrawImage(AX, AY+AImageHeight, ANeedWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteImageBottomLeftFitWidth(const AFileName: String;
                                const AX, AY: TPDFFloat; // bottom left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);
var
  Ind: Integer;
  ImageWidth, ImageHeight: TPDFFloat;
begin
  Ind:= LoadImage(AFileName, ImageWidth, ImageHeight);
  if Ind<0 then Exit;
  AImageHeight:= ImageHeight * ANeedWidth / ImageWidth;
  FPage.DrawImage(AX, AY, ANeedWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteImageBottomLeftFitWidth(const AStream: TMemoryStream;
                                const AExtension: String;
                                const AX, AY: TPDFFloat; // bottom left point
                                const ANeedWidth: TPDFFloat;
                                out AImageHeight: TPDFFloat);
var
  Ind: Integer;
  ImageWidth, ImageHeight: TPDFFloat;
begin
  Ind:= LoadImage(AStream, AExtension, ImageWidth, ImageHeight);
  if Ind<0 then Exit;
  AImageHeight:= ImageHeight * ANeedWidth / ImageWidth;
  FPage.DrawImage(AX, AY, ANeedWidth, AImageHeight, Ind);
end;

procedure TPDFWriter.WriteURL(const ALeftX, ARightX, AY: TPDFFloat;
                        const AText, AURL: String;
                        const AAlignment: TStringAlignment);
var
  C: TARGBColor;
  W, H, Y: TPDFFloat;
begin
  C:= FCurrentFontColor;
  SetFontColor(clBlue);
  WriteString(ALeftX, ARightX, AY, AText, AAlignment);
  W:= FontWidth(AText);
  H:= FontHeight + FontDesc;
  Y:= AY + FontDesc;
  FPage.AddExternalLink(ALeftX, Y, W, H, AURL, False);
  Y:= AY + FontDesc/2;
  FPage.SetColor(clBlue, True);
  FPage.DrawLine(ALeftX, Y, ALeftX+W, Y,  0.5*FontDesc, True);
  SetFontColor(C);
end;

procedure TPDFWriter.SaveToFile(const AFileName: String);
begin
  FDocument.SaveToFile(AFileName);
end;

end.

