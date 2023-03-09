*** Settings ***
Resource    D:\\Testes\\Automatizados\\Portal PMC\\Gerenciador\\page-objects\\gerenciadorAssunto-page-object.robot

*** Test Cases ***
Validação de regras de consulta, cadastro e edição de Assunto
    Set Selenium Speed    0.1
    Fazer login no Gerenciador PMC
    Verificar funcionalidades da tela Cadastro de Assunto
    Verificar funcionalidades da tela Consulta de Assunto
    Verificar funcionalidades da tela Edição de Assunto
    Fechar Navegador