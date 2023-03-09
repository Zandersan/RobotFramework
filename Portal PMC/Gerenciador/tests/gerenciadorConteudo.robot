*** Settings ***
Resource    D:\\Testes\\Automatizados\\Portal PMC\\Gerenciador\\page-objects\\gerenciadorConteudo-page-object.robot

*** Test Cases ***
Validação de regras de consulta, cadastro e edição de Banner
    Set Selenium Speed    0.3
    Fazer login no Gerenciador PMC
    Verificação de regras do Cadastro de Conteúdo
    Verificação de regras do Consulta de Conteúdo
    Verificação de regras do Edição de Conteúdo
    Fechar Navegador