unit ufrmHelper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TEditClassHelper = Class helper for tEdit
    function TextoDoEdit : string;
  end;

  tCaptionHelper = record helper for TCaption
    function TextoDoCaption : String;
    end;

  TfrmHelper = class(TForm)
    EdtTeste: TEdit;
    btnClassHelper: TButton;
    btnRecordHelper: TButton;
    procedure btnClassHelperClick(Sender: TObject);
    procedure btnRecordHelperClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelper: TfrmHelper;

implementation

{$R *.dfm}

{ TEditClassHelper }

function TEditClassHelper.TextoDoEdit: string;
begin
  Result := Text + ' - Esse � meu class helper :)';
end;

{ tCaptionHelper }

function tCaptionHelper.TextoDoCaption: String;
begin
  Result := Self + ' - Esse � meu Record helper :)';
end;

procedure TfrmHelper.btnClassHelperClick(Sender: TObject);
begin
  ShowMessage(EdtTeste.TextoDoEdit);
end;

procedure TfrmHelper.btnRecordHelperClick(Sender: TObject);
begin
  ShowMessage(EdtTeste.Text.TextoDoCaption);
end;

end.
