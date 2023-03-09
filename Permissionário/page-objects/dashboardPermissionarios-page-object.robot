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

${PUBLICACOES_PENDENTES}    xpath://html/body/div/div/div/main/section/div[1]/div[1]/div/a/div/div[2]/div/div[1]
${QUANTIDADE_PERMISSIONARIOS}    xpath://html/body/div/div/div/main/section/div[1]/div[2]/div/a/div/div[2]/div/div[1]
${EQUIPAMENTOS_URBANOS}    xpath://html/body/div/div/div/main/section/div[1]/div[3]/div/a/div/div[2]/div/div[1]

${RESULTADO_PUBLICACOES}    xpath://*[@id="resultado-panel-anuncios"]/div/div/span
${RESULTADO_PERMISSIONARIO}    xpath://html/body/div/div/div/main/section/div[4]/div[2]/div/div/div/div/span
${CHECKBOX_EQUIPAMENTOS}    xpath://*[@id="Ativo"]
${CHECKBOX_ATIVO_EQUIPAMENTOS}    xpath://*[@id='Ativo'][@value='true']

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

Verificar informações de Dashboard "Publicações Pendentes de Aprovação"
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_PUBLICACAO}    Get Text    ${PUBLICACOES_PENDENTES}
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/Anuncio/Listar
    Wait Until Element Is Visible    ${RESULTADO_PUBLICACOES}
    Element Should Contain    ${RESULTADO_PUBLICACOES}    ${GET_PUBLICACAO}

Verificar informações de Dashboard "Permissionários"
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/Inicio/Inicial
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_PERMISSIONARIO}    Get Text    ${QUANTIDADE_PERMISSIONARIOS}
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/Permissionario/Listar
    Wait Until Element Is Visible    ${RESULTADO_PERMISSIONARIO}
    Element Should Contain    ${RESULTADO_PERMISSIONARIO}    ${GET_PERMISSIONARIO}

Verificar informações de Dashboard "Equipamentos Urbanos"
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/Inicio/Inicial
    Wait Until Keyword Succeeds    5    10    Aguardar carregamento da pagina
    ${GET_EQUIPAMENTOS}    Get Text    ${EQUIPAMENTOS_URBANOS}
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/equipamentourbano/listar 
    Wait Until Element Is Enabled    ${CHECKBOX_EQUIPAMENTOS}
    ${Count}    Get Element Count    ${CHECKBOX_ATIVO_EQUIPAMENTOS}
    Should Be Equal As Numbers    ${Count}    ${GET_EQUIPAMENTOS}

Fechar Navegador
    Close Browser