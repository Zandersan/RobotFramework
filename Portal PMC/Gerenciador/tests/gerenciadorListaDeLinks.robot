*** Settings ***
Resource    D:\\Testes\\Automatizados\\Portal PMC\\Gerenciador\\page-objects\\gerenciadorListaDeLinks-page-object.robot

*** Test Cases ***
Validação de regras de consulta, cadastro e edição de Assunto
    Set Selenium Speed    0.1
    Fazer login no Gerenciador PMC
    Verificar funcionalidades da tela de Consulta da Lista de Links
    Verificar funcionalidades da tela de Cadastro de Lista de Links
    Verificar funcionalidades da tela de Edição de Lista de Links
    Verificar funcionalidades da tela de Exclusão de Lista de Links
    Fechar Navegador