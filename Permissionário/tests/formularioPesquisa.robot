*** Settings ***
Resource    ..\\page-objects\\formulárioPesquisa-page-object.robot

*** Test Cases ***
Realizar validação de informações apresentadas no Dashboard de Permissionários
    Fazer login no ADM Permissionários
    Teste de filtros e consulta de formulário de pesquisa
    Teste de campos obrigatórios e cadastro de formulário de pesquisa
    Fechar Navegador