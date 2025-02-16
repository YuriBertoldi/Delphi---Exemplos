unit FrmTesteAPI;

interface

{OBS1: Componente open source usado para relizar requisi��es � o Request4Delphi
 dispon�vel no link a seguir: https://github.com/viniciussanchez/RESTRequest4Delphi}

{OBS2: Este � apenas um exemplo, n�o foi realizado nenhum tipo de tratamento para erros,
 nem os possiveis tipos de requisi��es }

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.Objects, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.Edit, SyncObjs, Winapi.Windows, DateUtils, IdHTTP, RESTRequest4D;

type
  TfrmMain = class(TForm)
    edEndpoint: TEdit;
    edQtdeThreads: TEdit;
    checkSyncThreads: TCheckBox;
    btnExecutar: TButton;
    Panel1: TPanel;
    mmErros: TMemo;
    Label1: TLabel;
    lbExecutando: TLabel;
    lbSucesso: TLabel;
    lblErro: TLabel;
    Label2: TLabel;
    Line1: TLine;
    tmAtualizaStatus: TTimer;
    edQtdeRequisicoes: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmAtualizaStatusTimer(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
  private
    { Private declarations }
    fCriticalSection : TCriticalSection;
    procedure GravarLog(Log : String);
    procedure AtualizarStatus;
    procedure Executar;
    procedure ZerarContadores;
    procedure IniciarThread;
    procedure ReiniciarTempoStart;
  public
    { Public declarations }
    fTempoStart : TDateTime;
    class var
      FExecCount: Integer;
      FErrorCount: Integer;
      FOkCount: Integer;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

{ TfrmMain }

procedure TfrmMain.btnExecutarClick(Sender: TObject);
begin
  Executar;
end;

procedure TfrmMain.Executar;
var
  QtdThreads, j: Integer;
begin
  btnExecutar.Enabled := False;
  tmAtualizaStatus.Enabled := True;
  try
    ZerarContadores;

    QtdThreads := StrToIntDef(edQtdeThreads.Text, 1);
    for j := 1 to QtdThreads do
      IniciarThread;
  finally
    btnExecutar.Enabled := True;
  end;
end;

procedure tfrmMain.IniciarThread;
begin
  TThread.CreateAnonymousThread(
  procedure
  var
    URL_LOCAL: string;
    lHttp: TIdHTTP;
    qtdeRequisicoes, i : integer;
  begin
    URL_LOCAL       := frmMain.edEndpoint.Text;
    qtdeRequisicoes := StrToIntDef(frmMain.edQtdeRequisicoes.Text, 1);
    try
      try
        InterlockedIncrement(TfrmMain.FExecCount);
        if fTempoStart = 0 then
          Sleep(Random(1500) + 500)
        else Sleep(MilliSecondsBetween(Now, fTempoStart));

        i := 0;
        while i > qtdeRequisicoes do
        begin
          TRequest.New.BaseURL(URL_LOCAL)
          .Accept('application/json').Get;
          inc(i);
        end;

        InterlockedIncrement(TfrmMain.FOkCount);
      except on e:exception do
        begin
          InterlockedIncrement(TfrmMain.FErrorCount);
          frmMain.GravarLog(e.message);
        end;
      end;
    finally
      InterlockedDecrement(TfrmMain.FExecCount);
    end;
  end).Start;
end;

procedure TfrmMain.ReiniciarTempoStart;
begin
  if checkSyncThreads.isChecked then
    fTempoStart := IncSecond(Now, 6)
  else fTempoStart := 0;
end;

procedure TfrmMain.ZerarContadores;
begin
  { M�todos Interlocked(Somente Win) j� controlam a serealiza��o dos Threads,
      se n�o controlassem, ter�amos de utilizar CriticalSec ou outro }
  InterlockedExchange(FExecCount, 0);
  InterlockedExchange(FErrorCount, 0);
  InterlockedExchange(FOkCount, 0);

  ReiniciarTempoStart;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fCriticalSection.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  fCriticalSection := TCriticalSection.Create;
end;

procedure TfrmMain.GravarLog(Log : String);
begin
  fCriticalSection.Acquire;
  try
    mmErros.Lines.add(Log);
  finally
    fCriticalSection.Release;
  end;
end;

procedure TfrmMain.AtualizarStatus;
var finalizado : boolean;
begin
  tmAtualizaStatus.Enabled := False;
  try
    finalizado := (TfrmMain.FExecCount = 0);
    lbExecutando.Text := 'Executando: ' + IntToStr(TfrmMain.FExecCount);
    lbSucesso.Text    := 'Finalizados com sucesso: ' + IntToStr(TfrmMain.FOkCount);
    lblErro.Text      := 'Finalizado com erro:: ' + IntToStr(TfrmMain.FErrorCount);
    Application.ProcessMessages;
  finally
    tmAtualizaStatus.Enabled := not finalizado;
  end;
end;

procedure TfrmMain.tmAtualizaStatusTimer(Sender: TObject);
begin
  AtualizarStatus;
end;


end.
