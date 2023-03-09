*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

*** Keywords ***
Abrir navegador
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    chrome
    Maximize Browser Window

Fazer login no Gerenciador PMC
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR} 

Fazer Logout no Gerenciador PMC
    Click Element    xpath://*[@id="btnUsuarioPerfil"]
    Click Element    xpath: /html/body/div/header/div/div/div[2]/div/div/ul/li[3]/a

Fechar Navegador
    Close Browser