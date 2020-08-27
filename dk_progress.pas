unit DK_Progress;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls;

type

  { TProgress }

  TProgress = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    procedure FormShow(Sender: TObject);
  public
    procedure WriteLine1(const ACaption: String);
    procedure WriteLine2(const ACaption: String);
  end;

var
  Progress: TProgress;

implementation

{$R *.lfm}

procedure TProgress.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
end;

procedure TProgress.WriteLine1(const ACaption: String);
begin
  Label1.Caption:= ACaption;
  Application.ProcessMessages;
end;

procedure TProgress.WriteLine2(const ACaption: String);
begin
  Label2.Caption:= ACaption;
  Application.ProcessMessages;
end;

end.

