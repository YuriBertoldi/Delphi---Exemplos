program Producer;

//Depencias: https://github.com/danieleteti/delphistompclient.git

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
