*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    xpath://*[@id="Usuario"]
${INPUT_SENHA}    xpath://*[@id="Senha"]
${BUTTON_ENTRAR}    xpath://*[@id="loginEntrar"]

${LIST_STATUS}    xpath://*[@id="StatusPagamentoId"]
${LIST_ATIVO}    xpath://*[@id="Ativo"]
${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrarGuia"]

${GUIAS_PENDENTES}    xpath://*[@id="lbl_TotalGuiasPendentes"]/strong
${GUIAS_PAGAS}    xpath://*[@id="lbl_TotalGuiasPagas"]/strong
${GUIAS_VENCIDAS}    xpath://*[@id="lbl_TotalGuiasVencidas"]/strong

${RESULTADO_FILTRO_GUIAS}    xpath://*[@id="resultado-panel-consultar-guias"]/div/div/span
${RESULTADO_NULO_GUIA}    xpath://*[@id="resultado-panel-consultar-guias"]/div/table/tbody/tr/td

*** Keywords ***
Aguardar carregamento da pagina
    Title Should Be    Página Inicial - Permissionários

*** Keywords ***
Fazer login no ADM Permissionários
    Open Browser    https://dev-adm-permissionario.curitiba.pr.gov.br/   chrome
    Maximize Browser Window
    Title Should Be    Login - Permissionários
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}

Verificar informações do Dashboard
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_PENDENTES}    Get Text    ${GUIAS_PENDENTES}
    ${GET_PAGAS}    Get Text    ${GUIAS_PAGAS}
    ${GET_VENCIDAS}    Get Text    ${GUIAS_VENCIDAS}
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/guiapagamento/listar/statusPagamento-1
    Sleep    2

    ${GUIA_NULA}    Run Keyword And Return Status    Element Should Be Visible    ${RESULTADO_NULO_GUIA}
    Run Keyword If    ${GUIA_NULA}    Should Be Equal As Numbers    ${GET_PENDENTES}    0    ELSE    Element Should Contain    ${RESULTADO_FILTRO_GUIAS}    ${GET_PENDENTES}

    Select From List By Label    ${LIST_STATUS}    Paga
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Wait Until Element Is Visible    ${RESULTADO_FILTRO_GUIAS}
    Element Should Contain    ${RESULTADO_FILTRO_GUIAS}    ${GET_PAGAS}

    Select From List By Label    ${LIST_STATUS}    Vencida
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Wait Until Element Is Visible    ${RESULTADO_FILTRO_GUIAS}
    Element Should Contain    ${RESULTADO_FILTRO_GUIAS}    ${GET_VENCIDAS}    

Fechar Navegador
    Close Browser