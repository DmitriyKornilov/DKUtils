unit DK_HeapTrace;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, HeapTRC;

procedure HeapTraceOutputFile(const AFileName: String);

implementation

procedure HeapTraceOutputFile(const AFileName: String);
begin
  if FileExists(AFileName) then
    DeleteFile(AFileName);
  GlobalSkipIfNoLeaks := True;     // отчет об утечках только при их наличии
  setHeapTraceOutput(AFileName);   // отчет в отдельном файле
end;

end.

