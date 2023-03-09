*** Settings ***
Resource    ..\\page-objects\\dashboardPontos-page-object.robot

*** Test Cases ***
Realizar validação de informações apresentadas no Dashboard de Pendências
    Fazer login no ADM Permissionários
    Verificar informações de Dashboard "Férias"
    Verificar informações de Dashboard "Sacolões"
    Verificar informações de Dashboard "Mercado Municipal de Curitiba"
    Verificar informações de Dashboard "Mercado Regional do Cajuru"
    Fechar Navegador