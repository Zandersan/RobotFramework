*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR
Library    DateTime
Library    XML

*** Variables ***

${BUTTON_LOGIN}    xpath://*[@id="navbarSupportedContent"]/ul/li[3]
${BUTTON_CPF}    xpath://*[@id="nomeCidadao"]
${INPUT_CPF}    xpath://*[@id="documento"]
${BUTTON_PROXIMO}    xpath://*[@id="btnProximo"]
${INPUT_SENHA}    xpath://*[@id="senha"]
${BUTTON_ENTRAR}    xpath://*[@id="btnSenhaProximo"]

${PERGUNTA_1}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[1]/input[2]
${PERGUNTA_2}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[7]/input[2]
${PERGUNTA_3}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[2]/input[2]
${PERGUNTA_4}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[10]/input[2]
${PERGUNTA_5}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[12]/input[2]
${PERGUNTA_6}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[14]/input[2]
${PERGUNTA_7}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[18]/input[2]
${PERGUNTA_8}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[21]/input[2]
${PERGUNTA_9}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[25]/input[2]
${PERGUNTA_10}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[27]/input[2]
${PERGUNTA_11}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[29]/input[2]

${NUMERICO_1}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[2]/input[2]
${NUMERICO_2}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[5]/input[2]
${NUMERICO_3}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[8]/input[2]
${NUMERICO_4}    xpath://*[@id="formResponderFormularioPesquisa"]/div[1]/div[2]/div[10]/input[2]

${RADIO_1}    xpath://*[@id="radioSim_209"]
${RADIO_2}    xpath://*[@id="radioSim_208"]
${RADIO_3}    xpath://*[@id="radioSim_203"]
${RADIO_4}    xpath://*[@id="radioSim_197"]
${BUTTON_ENVIAR_FORMULARIO}    xpath://*[@id="btnEnviarFormularioPesquisa"]

*** Keywords ***

Aguardar carregamento da pagina
    Title Should Be    Minhas Guias - Sabores e Saberes

*** Keywords ***
Fazer login no ADM Permissionários
    Open Browser    https://dev-portalpermissionario.curitiba.pr.gov.br/login-off/01019120991   chrome
    Maximize Browser Window
    # Title Should Be    Início - Sabores e Saberes
    # Wait Until Element Is Visible    ${BUTTON_LOGIN}
    # Click Element    ${BUTTON_LOGIN}
    # Wait Until Keyword Succeeds    1    3    Aguardar carregamento da pagina
    # Wait Until Element Is Visible    ${BUTTON_CPF}
    # Click Element    ${BUTTON_CPF}
    # Wait Until Element Is Visible    ${INPUT_CPF}
    # Input Text    ${INPUT_CPF}    09669436940
    # Click Element    ${BUTTON_PROXIMO}
    # Wait Until Element Is Visible    ${INPUT_SENHA}
    # Input Password    ${INPUT_SENHA}    Gerontofilo1996
    # Click Element    ${BUTTON_ENTRAR}

Registrar respostas do formulario 88
    Go To    https://dev-portalpermissionario.curitiba.pr.gov.br/pesquisa/responder/91
    ${word}=    FakerLibrary.Word
    ${numbers}=    Evaluate    random.sample(range(1, 10), 4)    random
    Wait Until Element Is Visible    ${PERGUNTA_1}
    Input Text    ${PERGUNTA_1}    ${word}
    Input Text    ${PERGUNTA_2}    ${word}
    Input Text    ${PERGUNTA_3}    ${word}
    Input Text    ${PERGUNTA_4}    ${word}
    Input Text    ${PERGUNTA_5}    ${word}
    Input Text    ${PERGUNTA_6}    ${word}
    Input Text    ${PERGUNTA_8}    ${word}
    Input Text    ${PERGUNTA_9}    ${word}
    Input Text    ${PERGUNTA_10}    ${word}
    Input Text    ${PERGUNTA_11}    ${word}
    Input Text    ${NUMERICO_1}    ${numbers}
    Input Text    ${NUMERICO_2}    ${numbers}
    Input Text    ${NUMERICO_3}    ${numbers}
    Input Text    ${NUMERICO_4}    ${numbers}
    Click Element    ${RADIO_1}
    Click Element    ${RADIO_3}
    Click Element    ${RADIO_4}
    Click Element    ${BUTTON_ENVIAR_FORMULARIO}
    Wait Until Keyword Succeeds    1    2    Aguardar carregamento da pagina

Fechar Navegador
    Close Browser