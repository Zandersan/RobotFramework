*** Settings ***
Resource    ..\\page-objects\\dashboardPendencias-page-object.robot

*** Test Cases ***
Realizar validação de informações apresentadas no Dashboard de Permissionários
    Fazer login no ADM Permissionários
    Verificar informações do Dashboard
    Fechar Navegador