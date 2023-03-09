*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR
Library    DateTime
Library    XML

*** Variables ***

${INPUT_USUARIO}    xpath://*[@id="Usuario"]
${INPUT_SENHA}    xpath://*[@id="Senha"]
${BUTTON_ENTRAR}    xpath://*[@id="loginEntrar"]

${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrarPesquisa"]
${PESQUISA_EQUIPAMENTO}    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/table/tbody/tr/td[3]
${PESQUISA_CATEGORIA}    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/table/tbody/tr/td[4]
${PESQUISA_ATIVIDADE}    xpath://html/body/div/div/div/main/section/div[5]/div[2]/div/div/div/table/tbody/tr[1]/td[5]
${BUTTON_LIMPAR}    xpath://*[@id="btnLimparPesquisa"]

${INPUT_DATA_INICIO}    xpath://*[@id="DataInicio"]
${INPUT_DATA_FIM}    xpath://*[@id="DataFim"]
${LIST_TIPO_EQUIPAMENTO}    xpath://*[@id="TipoEquipamento"]
${LIST_EQUIPAMENTO_URBANO}    xpath://*[@id="EquipamentoUrbanoId"]
${LIST_CATEGORIA}    xpath://*[@id="CategoriaId"]
${LIST_RAMO_ATIVIDADE}    xpath://*[@id="RamoAtividadeId"]
${INPUT_TITULO_PESQUISA}    xpath://*[@id="Titulo"]
${INPUT_DESCRICAO_PESQUISA}    xpath://*[@id="Descricao"]
${INPUT_TEXTO_PERGUNTA}    xpath://*[@id="TextoPergunta"]
${LIST_TIPO_RESPOSTA}    xpath://*[@id="TipoResposta"]
${BUTTON_ADIOCONAR_PERGUNTA}    xpath://*[@id="BtnAdicionarPergunta"]
${BUTTON_SALVAR_FORMULARIO}    xpath://*[@id="btnSalvarFormularioPesquisa"]

${ERRO_SELECIONE_UMA_PERGUNTA}    xpath://*[@id="formAdicionarFormularioPesquisa"]/div[5]
${TITULO_OBRIGATORIO}    xpath://*[@id="Titulo-error"]
${DESCRICAO_OBRIGATORIA}    xpath://*[@id="Descricao-error"]
${MENSAGEM_SUCESSO}    xpath://html/body/div/div/div/main/section/div[1]

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

Teste de filtros e consulta de formulário de pesquisa
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/formulario-pesquisa/listar
    Wait Until Element Is Visible    ${LIST_TIPO_EQUIPAMENTO}
    Select From List By Label    ${LIST_TIPO_EQUIPAMENTO}    Mercado Municipal
    Select From List By Label    ${LIST_EQUIPAMENTO_URBANO}    DIRETO DA ROÇA ABRANCHES
    Select From List By Label    ${LIST_CATEGORIA}    AÇOUGUE
    Select From List By Label    ${LIST_RAMO_ATIVIDADE}    AQUÁRIO
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2
    Element Should Contain    ${PESQUISA_EQUIPAMENTO}    DIRETO DA ROÇA ABRANCHES
    Element Should Contain    ${PESQUISA_CATEGORIA}    AÇOUGUE
    Element Should Contain    ${PESQUISA_ATIVIDADE}    AQUÁRIO
    Click Element    ${BUTTON_LIMPAR}
    Click Element    ${BUTTON_FILTRAR}

Teste de campos obrigatórios e cadastro de formulário de pesquisa
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/formulario-pesquisa/inserir
    Wait Until Element Is Visible    ${BUTTON_SALVAR_FORMULARIO}
    Click Element    ${BUTTON_SALVAR_FORMULARIO}
    Element Should Be Visible    ${ERRO_SELECIONE_UMA_PERGUNTA}
            ${word}=    FakerLibrary.Word
    Input Text    ${INPUT_TEXTO_PERGUNTA}    ${word}
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Descritiva
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
    Click Element    ${BUTTON_SALVAR_FORMULARIO}
    Element Should Contain    ${TITULO_OBRIGATORIO}    obrigatório
    Element Should Contain    ${DESCRICAO_OBRIGATORIA}    obrigatório
        ${PROXIMA_DATA_2}    Get Current Date    increment=2 day    result_format=%d/%m/%Y
        ${PROXIMA_DATA_3}    Get Current Date    increment=4 day    result_format=%d/%m/%Y
        ${word}=    FakerLibrary.Word

    Input Text    ${INPUT_DATA_FIM}    ${PROXIMA_DATA_3} 
    Input Text    ${INPUT_DATA_INICIO}    ${PROXIMA_DATA_2} 
    Select From List By Label    ${LIST_TIPO_EQUIPAMENTO}    Feira
    Select From List By Label    ${LIST_EQUIPAMENTO_URBANO}    DIRETO DA ROÇA ABRANCHES
    Select From List By Label    ${LIST_CATEGORIA}    BEBIDAS FECHADAS
    Select From List By Label    ${LIST_RAMO_ATIVIDADE}    BEBIDAS
    Input Text    ${INPUT_TITULO_PESQUISA}    ${word}
    Input Text    ${INPUT_DESCRICAO_PESQUISA}    ${word}
    Click Element    ${BUTTON_SALVAR_FORMULARIO}
    Wait Until Element Is Visible    ${MENSAGEM_SUCESSO}
    Element Should Be Visible    ${MENSAGEM_SUCESSO}

Fechar Navegador
    Close Browser