*** Settings ***
Resource    D:\\Testes\\Automatizados\\Portal PMC\\Gerenciador\\page-objects\\gerenciadorBanner-page-object.robot

*** Test Cases ***
Validação de regras de consulta, cadastro e edição de Banner
    Set Selenium Speed    0.1
    Fazer login no Gerenciador PMC
    Verificação de regras do Cadastro de Banner com o tipo WebSite_Programas
    Verificação de regras do Cadastro de Banner com o tipo WebSite_Central
    Verificação de regras do Consulta de Banner
    Verificação de regras do Edição de Banner
    Verificação de regras da Exclusão de Banner
    Fechar Navegador