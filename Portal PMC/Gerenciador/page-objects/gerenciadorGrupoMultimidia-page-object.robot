*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR
Library    XML

*** Variables ***
${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

${INPUT_CONSULTA_DESCRICAO}    id=Descricao
${LIST_CONTEUDO}    xpath: //*[@id="ConteudoPublicado"]
${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrar"]
${BUTTON_LIMPAR}    xpath://*[@id="btnLimpar"]

${INPUT_CADASTRO_DESCRICAO}    xpath://*[@id="Descricao"]
${INPUT_ID_FILTRO}    xpath://*[@id="IdfFiltroMultimidia"]
${BUTTON_FILTRAR_CADASTRO}    xpath://*[@id="btnFiltrar"]
${BUTTON_MULTIMIDIA_362517}    xpath://*[@id="362517"]
${BUTTON_SALVAR_CADASTRO}    xpath:/html/body/div/div[3]/div/main/section/div[4]/div/button

${BUTTON_FILTRO_TESTE}    xpath://*[@id="abrir2"]/div/div/div/table/tbody/tr/td[4]/a
${BUTTON_MULTIMIDIA_362516}    xpath://*[@id="362516"]
${BUTTON_REMOVER_MULTIMIDIA}    xpath://*[@id="tabelaAssociadas"]/tbody/tr/td[4]/button

*** Keywords ***
Fazer login no Gerenciador PMC
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    chrome
    Maximize Browser Window
    Title Should Be    Login - Portal PMC
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR} 

Verificar funcionalidades da tela Consulta de Grupos Multimídia
    Go to    https://dev-gerenciador.curitiba.pr.gov.br/grupoMultimidia/Listar
    Input Text    ${INPUT_CONSULTA_DESCRICAO}    Novo Teste
    Select From List By Label    ${LIST_CONTEUDO}    Sim
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2s
    Click Element    ${BUTTON_LIMPAR}

Verificar funcionalidades da tela Cadastro de Grupos Multimídia
    Go to    https://dev-gerenciador.curitiba.pr.gov.br/grupoMultimidia/InserirNovo

    Click Element    xpath:/html/body/div/div[3]/div/main/section/div[4]/div/button
        ${word}=    FakerLibrary.Word
    Input Text    ${INPUT_CADASTRO_DESCRICAO}    Teste ${word}
    Input Text    ${INPUT_ID_FILTRO}    362517
    Click Element    ${BUTTON_FILTRAR_CADASTRO}
    Wait Until Element Is Visible    ${BUTTON_MULTIMIDIA_362517}
    Click Element    ${BUTTON_MULTIMIDIA_362517}
    Click Element    ${BUTTON_SALVAR_CADASTRO}
  
Verificar funcionalidades da tela Edição de Grupos Multimídia
    Go to    https://dev-gerenciador.curitiba.pr.gov.br/grupoMultimidia/Listar
    Input Text    ${INPUT_CONSULTA_DESCRICAO}    Teste
    Select From List By Label    ${LIST_CONTEUDO}    Sim
    Click Element    ${BUTTON_FILTRAR}
    Sleep    2s
    Click Element    ${BUTTON_FILTRO_TESTE}
        ${word2}=    FakerLibrary.Word
    Input Text    ${INPUT_CADASTRO_DESCRICAO}    Teste ${word2}
    Click Element    ${BUTTON_REMOVER_MULTIMIDIA}
    Input Text    ${INPUT_ID_FILTRO}    362516
    Click Element    ${BUTTON_FILTRAR_CADASTRO}
    Click Element    ${BUTTON_MULTIMIDIA_362516}
    Click Element    ${BUTTON_SALVAR_CADASTRO}
    
Fechar Navegador
    Close Browser