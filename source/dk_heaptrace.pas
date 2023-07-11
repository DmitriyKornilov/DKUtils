unit DK_HeapTrace;

{$mode ObjFPC}{$H+}

interface

uses
  {Classes, }SysUtils, HeapTRC;

procedure HeapTraceOutputFile(const AFileName: String);

implementation

procedure HeapTraceOutputFile(const AFileName: String);
begin
  {$if declared(useHeapTrace)}
    if FileExists(AFileName) then
      DeleteFile(AFileName);
    GlobalSkipIfNoLeaks := True;     // отчет об утечках только при их наличии
    setHeapTraceOutput(AFileName);   // отчет в отдельном файле
  {$endIf}
end;

end.

