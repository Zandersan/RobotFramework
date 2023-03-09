*** Settings ***
Resource    D:\\Testes\\Automatizados\\Portal PMC\\Gerenciador\\page-objects\\gerenciadorGruposDeAcesso-page-object.robot

*** Test Cases ***
Validação de regras de consulta, cadastro e edição de Assunto
    Set Selenium Speed    0.1
    Fazer login no Gerenciador PMC
    Verificar funcionalidades da tela de Consulta de Grupos de Acesso
    Verificar funcionalidades da tela de Consulta de Usuários
    Verificar funcionalidades da tela de Edição de Permissões
    Fechar Navegador