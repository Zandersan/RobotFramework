*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    xpath://*[@id="Usuario"]
${INPUT_SENHA}    xpath://*[@id="Senha"]
${BUTTON_ENTRAR}    xpath://*[@id="loginEntrar"]

${LIST_STATUS}    xpath://*[@id="Status"]
${LIST_ATIVO}    xpath://*[@id="Ativo"]
${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrarPontoComercial"]

${FEIRAS_DISPONIVEIS}    xpath://html/body/div/div/div/main/section/div[2]/div[2]/div/a/div/div/div[5]/p[2]/i
${FEIRAS_OCUPADOS}    xpath://html/body/div/div/div/main/section/div[2]/div[2]/div/a/div/div/div[6]/p[2]
${FEIRAS_FEIRANTES}    xpath://html/body/div/div/div/main/section/div[2]/div[2]/div/a/div/div/div[7]/p[2]/i

${SACOLOES_DISPONIVEIS}    xpath://html/body/div/div/div/main/section/div[2]/div[3]/div/a/div/div/div[5]/p[2]
${SACOLOES_OCUPADOS}    xpath://html/body/div/div/div/main/section/div[2]/div[3]/div/a/div/div/div[6]/p[2]/i

${MERC_CWB_DISPONIVEIS}    xpath://html/body/div/div/div/main/section/div[2]/div[4]/div/a/div/div/div[5]/p[2]
${MERC_CWB_OCUPADOS}    xpath://html/body/div/div/div/main/section/div[2]/div[4]/div/a/div/div/div[6]/p[2]

${MERC_CAJURU_DISPONIVEIS}    xpath://html/body/div/div/div/main/section/div[2]/div[5]/div/a/div/div/div[5]/p[2]
${MERC_CAJURU_OCUPADOS}    xpath://html/body/div/div/div/main/section/div[2]/div[5]/div/a/div/div/div[6]/p[2]

*** Keywords ***
Aguardar carregamento da pagina
    Title Should Be    Página Inicial - Permissionários

*** Test Cases ***
Fazer login no ADM Permissionários
    Open Browser    https://dev-adm-permissionario.curitiba.pr.gov.br/   chrome
    Maximize Browser Window
    Title Should Be    Login - Permissionários
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}

Verificar informações de Dashboard "Férias"
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_FEIRAS_DIS}    Get Text    ${FEIRAS_DISPONIVEIS}
    ${GET_FEIRAS_OCP}    Get Text    ${FEIRAS_OCUPADOS}
    ${GET_FEIRAS_FEI}    Get Text    ${FEIRAS_FEIRANTES} 
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/pontocomercial/listar/tipoEquipamento-1
    Select From List By Label    ${LIST_ATIVO}    Ativado
    Select From List By Label    ${LIST_STATUS}    Disponível
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_FEIRAS_DIS}
    Select From List By Label    xpath://*[@id="Status"]    Ocupado
    Click Element    xpath://*[@id="btnFiltrarPontoComercial"]
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_FEIRAS_OCP}

Verificar informações de Dashboard "Sacolões"
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/Inicio/Inicial
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_SACOLOES_DIS}    Get Text    ${SACOLOES_DISPONIVEIS}
    ${GET_SACOLOES_OCP}    Get Text    ${SACOLOES_OCUPADOS}
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/pontocomercial/listar/tipoEquipamento-4
    Select From List By Label    ${LIST_ATIVO}    Ativado
    Select From List By Label    ${LIST_STATUS}    Disponível
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_SACOLOES_DIS}
    Select From List By Label    ${LIST_STATUS}    Ocupado
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_SACOLOES_OCP}

Verificar informações de Dashboard "Mercado Municipal de Curitiba"
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/Inicio/Inicial
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_MERC_CWB_DIS}    Get Text    ${MERC_CWB_DISPONIVEIS}
    ${GET_MERC_CWB_OCP}    Get Text    ${MERC_CWB_OCUPADOS}
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/pontocomercial/listar/tipoEquipamento-2
    Select From List By Label    ${LIST_ATIVO}    Ativado
    Select From List By Label    ${LIST_STATUS}    Disponível
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_MERC_CWB_DIS}
    Select From List By Label    ${LIST_STATUS}    Ocupado
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_MERC_CWB_OCP}    

Verificar informações de Dashboard "Mercado Regional do Cajuru"
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/Inicio/Inicial
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_MERC_CAJURU_DIS}    Get Text    ${MERC_CAJURU_DISPONIVEIS}
    ${GET_MERC_CAJURU_OCP}    Get Text    ${MERC_CAJURU_OCUPADOS}
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/pontocomercial/listar/tipoEquipamento-3
    Select From List By Label    ${LIST_ATIVO}    Ativado
    Select From List By Label    ${LIST_STATUS}    Disponível
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_MERC_CAJURU_DIS}
    Select From List By Label    ${LIST_STATUS}    Ocupado
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/div/span    ${GET_MERC_CAJURU_OCP}    

Fechar Navegador
    Close Browser