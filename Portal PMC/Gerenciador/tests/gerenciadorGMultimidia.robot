*** Settings ***
Resource    D:\\Testes\\Automatizados\\Portal PMC\\Gerenciador\\page-objects\\gerenciadorGrupoMultimidia-page-object.robot

*** Test Cases ***
Validação de regras de consulta, cadastro e edição de Grupo Multimídia
    Set Selenium Speed    0.1
    Fazer login no Gerenciador PMC
    Verificar funcionalidades da tela Consulta de Grupos Multimídia
    Verificar funcionalidades da tela Cadastro de Grupos Multimídia
    Verificar funcionalidades da tela Edição de Grupos Multimídia
    Fechar Navegador