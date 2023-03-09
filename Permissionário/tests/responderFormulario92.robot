*** Settings ***
Resource    ..\\page-objects\\responderFormulario92-page-object.robot

*** Test Cases ***
Responder formulario 88
    Fazer login no ADM Permissionários
    Registrar respostas do formulario 88
    Repeat Keyword    15    Registrar respostas do formulario 88
    Fechar Navegador