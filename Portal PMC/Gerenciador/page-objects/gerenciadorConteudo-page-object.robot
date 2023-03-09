*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library         FakerLibrary    locale=pt_BR

*** Variables ***
${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

${BUTTON_SALVAR}    xpath://*[@id="formularioConteudo"]/div[5]/div/button
${WAIT_OBRIGATORIO}    xpath://*[@id="abrir1"]/div/div[2]/div/span[2]
${ELEMENT_AREA_OBRIGATORIO}    xpath://*[@id="AreaId-error"]
${ELEMENT_SINTESE_OBRIGATORIO}    xpath://*[@id="CON_STR_SINTESE-error"]
${ELEMENT_IFRAME_OBRIGATORIO}    xpath://*[@id="ErroPreencher "] 
${ELEMENT_MULTIMIDIA_OBRIGATORIO}    xpath://*[@id="nenhumDisplay"]

${LIST_ID}    xpath://*[@id="AreaId"]
${INPUT_TITULO}    xpath://*[@id="CON_STR_TITULO"]
${INPUT_SINTESE}    xpath://*[@id="CON_STR_SINTESE"]
${INPUT_IFRAME}    xpath://*[@id="CON_STR_TEXTO"]
${INPUT_JAVA}    id=CON_STR_SCRIPT
${INPUT_META_TITULO}    xpath://*[@id="CON_STR_META_TITULO"]
${INPUT_META_DESCRICAO}    id=CON_STR_META_DESCRICAO
${INPUT_META_TAG}    xpath://*[@id="CON_STR_META_TAG"]

${BUTTON_MULTIMIDIA}    xpath://*[@id="abrir1"]/div/div[6]/div/button
${WAIT_CADASTRO_MULTIMIDIA}    xpath://*[@id="nav-listar-imagens-tab"]
${SELECT_IMAGEM_UM}    xpath://*[@id="344940"]/img
${SELECT_IMAGEM_DOIS}    xpath://*[@id="343934"]/img
${BUTTON_SALVAR_MULTIMIDIA}    xpath://*[@id="submitMultimidia"]
${WAIT_SUCESSO_MULTIMIDIA}    xpath://*[@id="mensagemSucesso"]
${BUTTON_VOLTAR}    xpath://*[@id="ModalMultimidia"]/div/div/div[3]/button[1]

${INPUT_CODIGO}    xpath://*[@id="Codigo"]
${INPUT_TITULO}    xpath://*[@id="Titulo"]
${LIST_AREA}    xpath://*[@id="Area"]
${LIST_CONTEUDO}    xpath://*[@id="ConteudoPublicado"]
${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrar"]
${ELEMENT_CODIGO}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr/td[1]
${ELEMENT_TITULO}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr/td[2]
${ELEMENT_CONTEUDO}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr/td[4]

${BUTTON_EDITAR}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr[3]/td[8]/a
${LIST_AREA_ID}    xpath://*[@id="AreaId"]
${SELECT_IMAGEM_TRES}    xpath://*[@id="344946"]
${SELECT_IMAGEM_QUATRO}    xpath://*[@id="344941"]

*** Keywords ***
Fazer login no Gerenciador PMC
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    chrome
    Maximize Browser Window
    Title Should Be    Login - Portal PMC
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR} 

Verificação de regras do Cadastro de Conteúdo
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/conteudo/Inserir
        ${word}=    FakerLibrary.Word
        ${word2}=    FakerLibrary.Word

    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${WAIT_OBRIGATORIO}
    Element Text Should Be    ${ELEMENT_AREA_OBRIGATORIO}    Campo área obrigatório
    Element Text Should Be    ${ELEMENT_SINTESE_OBRIGATORIO}    Campo síntese obrigatório
    Element Text Should Be    ${ELEMENT_IFRAME_OBRIGATORIO}    O Preenchimento do campo é obrigatório.
    Element Text Should Be    ${ELEMENT_MULTIMIDIA_OBRIGATORIO}    Nenhum resultado encontrado

    Select From List By Label    ${LIST_ID}    Assessoria de Direitos Humanos
    Input Text    ${INPUT_TITULO}    ${word}
    Input Text    ${INPUT_SINTESE}   ${word}
    Input Text    ${INPUT_IFRAME}   teste
    Input Text    ${INPUT_JAVA}    document.write('Hello, World!');
    Input Text    ${INPUT_META_TITULO}    ${word2}
    Input Text    ${INPUT_META_DESCRICAO}    ${word2}
    Input Text    ${INPUT_META_TAG}    ${word2}
        Click Element    ${BUTTON_MULTIMIDIA}
        Wait Until Element Is Visible    ${WAIT_CADASTRO_MULTIMIDIA}
        Click Element    ${SELECT_IMAGEM_UM}
        Click Element    ${SELECT_IMAGEM_DOIS}
        Click Element    ${BUTTON_SALVAR_MULTIMIDIA}
        Wait Until Element Is Visible    ${WAIT_SUCESSO_MULTIMIDIA}
        Click Element    ${BUTTON_VOLTAR}

    Click Element    ${BUTTON_SALVAR}


Verificação de regras do Consulta de Conteúdo
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/Banner/Listar
    Input Text    ${INPUT_CODIGO}    26
    Input Text    ${INPUT_TITULO}    Teste
    Select From List By Label    ${LIST_AREA}   Urbanismo
    Select From List By Label    ${LIST_CONTEUDO}   Sim
    Click Element    ${BUTTON_FILTRAR}
    Sleep    3 seconds
    Element Should Contain   ${ELEMENT_CODIGO}    26 
    Element Should Contain   ${ELEMENT_TITULO}    Teste
    Element Should Contain   ${ELEMENT_CONTEUDO}    Urbanismo 

Verificação de regras do Edição de Conteúdo
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/conteudo/listar
    Click Element    ${BUTTON_EDITAR}
            ${word3}=    FakerLibrary.Word
    Select From List By Label    ${LIST_AREA_ID}    Urbanismo
    Input Text    ${INPUT_TITULO}    ${word3}
    Input Text    ${INPUT_SINTESE}   ${word3}
    Input Text    ${INPUT_JAVA}  document.write('Hello, World!');
    Input Text    ${INPUT_META_TITULO}    ${word3}
    Input Text    ${INPUT_META_DESCRICAO}    ${word3}
    Input Text    ${INPUT_META_TAG}    ${word3}
        Click Element    ${BUTTON_MULTIMIDIA}
        Wait Until Element Is Visible    ${WAIT_CADASTRO_MULTIMIDIA}
        Click Element    ${SELECT_IMAGEM_UM}
        Click Element    ${SELECT_IMAGEM_UM}
        Click Element    ${SELECT_IMAGEM_TRES}
        Click Element    ${SELECT_IMAGEM_QUATRO}
        Click Element    ${BUTTON_SALVAR_MULTIMIDIA}
        Wait Until Element Is Visible    ${WAIT_SUCESSO_MULTIMIDIA}
        Click Element    ${BUTTON_VOLTAR}
    Click Element    ${BUTTON_SALVAR}

Fechar Navegador
    Close Browser