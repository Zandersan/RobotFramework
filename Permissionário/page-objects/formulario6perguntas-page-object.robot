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

${CHECKBOX_OBRIGATORIO}    xpath://*[@id="formAdicionarFormularioPesquisa"]/div[3]/div[2]/div[1]/div[3]/div/label

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


Teste de campos obrigatórios e cadastro de formulário de pesquisa
    Go To    https://dev-adm-permissionario.curitiba.pr.gov.br/formulario-pesquisa/inserir
    Wait Until Element Is Visible    ${BUTTON_SALVAR_FORMULARIO}

            ${word}=    FakerLibrary.Word
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Descritivo ${word} 1
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Descritiva
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Descritivo ${word} 2
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Descritiva
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Descritivo ${word} 3
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Descritiva
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}

        Input Text    ${INPUT_TEXTO_PERGUNTA}    Numérica ${word} 1
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Numérica
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Numérica ${word} 2
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Numérica
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Numérica ${word} 3
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Numérica
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}

        Input Text    ${INPUT_TEXTO_PERGUNTA}    Sim/Não ${word} 1
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Sim/Não
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Sim/Não ${word} 2
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Sim/Não
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Sim/Não ${word} 3
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Sim/Não
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}

            ${word2}=    FakerLibrary.Word
    Wait Until Element Is Visible    ${CHECKBOX_OBRIGATORIO}
    Click Element    ${CHECKBOX_OBRIGATORIO}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Descritivo ${word2} 4
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Descritiva
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Descritivo ${word2} 5
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Descritiva
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Descritivo ${word2} 6
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Descritiva
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}

        Input Text    ${INPUT_TEXTO_PERGUNTA}    Numérica ${word2} 4
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Numérica
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Numérica ${word2} 5
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Numérica
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Numérica ${word2} 6
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Numérica
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}

            Input Text    ${INPUT_TEXTO_PERGUNTA}    Sim/Não ${word2} 4
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Sim/Não
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Sim/Não ${word2} 5
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Sim/Não
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}
        Input Text    ${INPUT_TEXTO_PERGUNTA}    Sim/Não ${word2} 6
    Select From List By Label    ${LIST_TIPO_RESPOSTA}    Sim/Não
    Click Element    ${BUTTON_ADIOCONAR_PERGUNTA}

        ${PROXIMA_DATA_2}    Get Current Date    increment=2 day    result_format=%d/%m/%Y
        ${PROXIMA_DATA_3}    Get Current Date    increment=30 day    result_format=%d/%m/%Y
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