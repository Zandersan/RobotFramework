*** Settings ***
Resource    D:\\Testes\\Automatizados\\Portal PMC\\Gerenciador\\page-objects\\gerenciadorCache-page-object.robot

*** Test Cases ***
Validação de regras de consulta, cadastro e edição de Banner
    Set Selenium Speed    0.1
    Fazer login no Gerenciador PMC
    Verificar funcionalidades da tela Limpar Cache dos Portais
    Fechar Navegador