*** Settings ***
Resource    ..\\page-objects\\ediçãoAtendimento-page-object.robot

*** Test Cases ***
Realizar edição de atendimento e validar regras do sistema
    Fazer login no GpWeb
    Realizar consulta de atendimento
    Realizar edição de atendimento
    Fechar Navegador