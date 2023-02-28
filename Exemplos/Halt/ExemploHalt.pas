unit ExemploHalt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure GravarLog;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    Halt(0);
  finally
    GravarLog;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);

begin

  try
    Application.Terminate;
  finally
    GravarLog;
  end;
end;

procedure TForm1.GravarLog;
var x : tStrings;
begin
 x := tStringList.Create;
 x.add('Entrou no finally');
 x.SaveToFile(GetCurrentDir + '\Log.txt');
 x.Free;
end;

end.
