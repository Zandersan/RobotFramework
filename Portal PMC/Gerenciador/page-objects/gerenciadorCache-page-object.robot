*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

${ELEMENT_LIMPAR_PORTAIS}    xpath:/html/body/div/div[3]/div/main/section/div[2]/div[1]/h2
${ELEMENT_LIMPAR_CACHE}    xpath:/html/body/div/div[3]/div/main/section/form/div/div[1]
${ELEMENT_SITE}    xpath://*[@id="abrir1"]/div/div[1]/div/label
${BUTTON_LIMPAR_SITE}    xpath://*[@id="abrir1"]/div/div[2]/button[1]
${BUTTON_LIMPAR_TODOS}    xpath://*[@id="abrir1"]/div/div[2]/button[2]
${ELEMENT_MENSAGEM_ERRO}    xpath://*[@id="Site-error"]
${ELEMENT_MENSAGEM_SUCESSO}    xpath://*[@id="mensagemSucesso"]
${LIST_SITE}    xpath://*[@id="Site"]

*** Keywords ***
Fazer login no Gerenciador PMC
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    chrome
    Maximize Browser Window
    Title Should Be    Login - Portal PMC
    Input Text    ${INPUT_USUARIO}     alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}

Verificar funcionalidades da tela Limpar Cache dos Portais
    Go to    https://dev-gerenciador.curitiba.pr.gov.br/Cache/Listar
    Element Text Should Be    ${ELEMENT_LIMPAR_PORTAIS}    Limpar Cache dos Portais
    Element Text Should Be    ${ELEMENT_LIMPAR_CACHE}    Limpar Cache
    Element Text Should Be    ${ELEMENT_SITE}    Site
    Click Element    ${BUTTON_LIMPAR_SITE}
    Element Text Should Be    ${ELEMENT_MENSAGEM_ERRO}    Campo "Site" obrigatório!
    Click Element    ${BUTTON_LIMPAR_TODOS}
    Wait Until Element Is Visible    ${ELEMENT_MENSAGEM_SUCESSO} 
    Select From List By Label    ${LIST_SITE}    https://dev-urbanismo.curitiba.pr.gov.br
    Click Element    ${BUTTON_LIMPAR_SITE}

Fechar Navegador
    Close Browser