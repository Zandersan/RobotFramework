*** Settings ***
Resource    ..\\page-objects\\aberturaAtendimento-AtestadoCLT-page-object.robot

*** Test Cases ***
Realizar abertura de atendimento tipo "Atestado CLT" e validar regras do sistema
    Fazer login no GpWeb
    Realizar abertura de atendimento tipo "Atestado CLT"
    Finalizar Cadastro
    Fechar Navegador