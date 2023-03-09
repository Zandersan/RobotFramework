*** Settings ***
Resource    ..\\page-objects\\dashboardPermissionarios-page-object.robot

*** Test Cases ***
Realizar validação de informações apresentadas no Dashboard de Permissionários
    Fazer login no ADM Permissionários
    Verificar informações de Dashboard "Publicações Pendentes de Aprovação"
    Verificar informações de Dashboard "Permissionários"
    Verificar informações de Dashboard "Equipamentos Urbanos"
    Fechar Navegador