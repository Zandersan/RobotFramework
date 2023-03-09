*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

${INPUT_NOME_FILTRO}    id=Nome
${LIST_TEMAS_FILTRO}    xpath://*[@id="Tema"]
${LIST_PUBLICADO_FILTRO}    xpath://*[@id="Publicado"]
${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrar"]
${NOME_FILTRADO}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr/td[1]
${BUTTON_LIMPAR}    xpath://*[@id="btnLimpar"]

${BUTTON_SALVAR_CADASTRO}    xpath://*[@id="formularioConteudo"]/div/div[3]/button
${TEMA_OBRIGATORIO}    xpath://*[@id="abrir1"]/div/div[2]/div/span[2]
${INPUT_NOME_CADASTRO}    xpath://*[@id="LLI_STR_NOME_LISTA"]
${LIST_TEMA_CADASTRO}    xpath://*[@id="SIS_INT_IDF"]
${BUTTON_NOVO_ITEM}    xpath://*[@id="abrir1"]/div[1]/div/button
${INPUT_TITULO_ITEM}    xpath://*[@id="LIT_STR_NOME_PAGINA"]
${INPUT_URL_ITEM}    xpath://*[@id="LIT_STR_URL_PAGINA"]
${BUTTON_SALVAR_ITEM}    xpath://*[@id="submitMultimidia"]
${RADIO_CONTEUDO_ITEM}    xpath://*[@id="divTipoId"]/label[3]/input

${BUTTON_EDITAR}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr[1]/td[4]/a
${BUTTON_EXCLUIR_ITEM}    xpath://*[@id="dvItem_6"]/div[1]/div
${BUTTON_CONFIRMACAO_EXCLUIR}    xpath://*[@id="ModalExcluirListaLinks"]/div/div/div[3]/button[2]
${BUTTON_CONFIRMACAO_EXCLUIR_ITEM}    xpath://*[@id="ModalExcluirListaLinksItem"]/div/div/div[3]/button[2]

${BUTTON_EXCLUIR}    xpath://*[@id="formularioConteudo"]/div/div[3]/a

*** Keywords ***
Fazer login no Gerenciador PMC
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    chrome
    Maximize Browser Window
    Title Should Be    Login - Portal PMC
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}

Verificar funcionalidades da tela de Consulta da Lista de Links
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/ListaLinks/Listar
    Input Text    ${INPUT_NOME_FILTRO}    Teste
    Select From List By Label    ${LIST_TEMAS_FILTRO}    Urbanismo
    Select From List By Label    ${LIST_PUBLICADO_FILTRO}    Sim
    Click Element    ${BUTTON_FILTRAR}
    Element Should Contain    ${NOME_FILTRADO}    Teste
    Click Element    ${BUTTON_LIMPAR}
    Element Should Not Contain    ${INPUT_NOME_FILTRO}    Teste

Verificar funcionalidades da tela de Cadastro de Lista de Links
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/listalinks/Inserir
    Click Element    ${BUTTON_SALVAR_CADASTRO}
    Element Text Should Be    ${TEMA_OBRIGATORIO}    Campo tema obrigatório.
        ${word}=    FakerLibrary.Word
    Input Text    ${INPUT_NOME_CADASTRO}    Teste ${word}
    Select From List By Label    ${LIST_TEMA_CADASTRO}    156
    Click Element    ${BUTTON_SALVAR_CADASTRO}
    Click Element    ${BUTTON_NOVO_ITEM}
    Input Text    ${INPUT_TITULO_ITEM}    Teste ${word}
    Input Text    ${INPUT_URL_ITEM}    http://${word}.com
    Click Element    ${BUTTON_SALVAR_ITEM}
    Click Element    ${BUTTON_NOVO_ITEM}

Verificar funcionalidades da tela de Edição de Lista de Links
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/ListaLinks/Listar
    Input Text    ${INPUT_NOME_FILTRO}    Teste
    Select From List By Label    ${LIST_PUBLICADO_FILTRO}    Sim
    Click Element    ${BUTTON_FILTRAR}
    Click Element    ${BUTTON_EDITAR}
      ${word}=    FakerLibrary.Word  
    Input Text    ${INPUT_NOME_CADASTRO}    Teste ${word}
    Unselect From List By Label    ${LIST_TEMA_CADASTRO}    Servidor
    Select From List By Label    ${LIST_TEMA_CADASTRO}    Urbanismo   
    Click Element    ${BUTTON_NOVO_ITEM}
    Input Text    ${INPUT_TITULO_ITEM}    Teste ${word}
    Input Text    ${INPUT_URL_ITEM}    http://${word}.com
    Click Element    ${BUTTON_SALVAR_ITEM}
    Click Element    ${BUTTON_EXCLUIR_ITEM}
    Click Element    ${BUTTON_CONFIRMACAO_EXCLUIR_ITEM}
    Click Element    ${BUTTON_SALVAR_CADASTRO}
    

Verificar funcionalidades da tela de Exclusão de Lista de Links
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/ListaLinks/Listar
    Input Text    ${INPUT_NOME_FILTRO}    Teste
    Select From List By Label    ${LIST_PUBLICADO_FILTRO}    Sim
    Click Element    ${BUTTON_EDITAR}
    Click Element    ${BUTTON_EXCLUIR}
    Click Element    ${BUTTON_CONFIRMACAO_EXCLUIR}

Fechar Navegador
    Close Browser