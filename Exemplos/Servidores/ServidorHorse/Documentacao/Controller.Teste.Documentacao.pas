unit Controller.Teste.Documentacao;

interface

uses JSON,
     Horse.GBSwagger,
     SysUtils;

procedure SwaggerDocumentacao;
procedure TesteConexao;
procedure ReverseString;

implementation

procedure SwaggerDocumentacao;
begin
  TesteConexao;
  ReverseString;
end;

procedure TesteConexao;
begin
  Swagger.Path('Teste/TesteConexao')
    .Tag('Teste')
      .GET('Conex�o', 'Verifica se servidor est� ativo.')
        .AddResponse(200, 'Servidor Operante').&end
        .AddResponse(400).&end
        .AddResponse(500).&end
  .&end
end;

procedure ReverseString;
begin
  Swagger.Path('Teste/ReverseString/{value}')
    .Tag('Teste')
      .GET('Reverse String', 'Retorna o reverso da string passada como parametro.')
        .AddParamPath('value', 'Valor que ser� revertido')
          .Schema(SWAG_STRING).&End
        .AddResponse(200, 'eulav').&end
        .AddResponse(400).&end
        .AddResponse(500).&end
  .&end
end;

end.
