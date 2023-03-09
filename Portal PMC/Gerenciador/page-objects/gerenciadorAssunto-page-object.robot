*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

${SENHA}    \#.senhasenha

${INPUT_NOME_CONSULTA}    xpath://*[@id="Nome"]
${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrar"]
${ELEMENT_NOME_FILTRO}    xpath://*[@id="abrir2"]/div/div/div/div/table/tbody/tr[1]/td[1]
${BUTTON_LIMPAR}    xpath://*[@id="btnLimpar"]

${BUTTON_SALVAR_CADASTRO}    xpath://*[@id="formulario"]/div[3]/div/button
${ELEMENT_OBRIGATORIO}    xpath://*[@id="Nome-error"]
${INPUT_NOME_CADASTRO}    xpath://*[@id="Nome"]

${BUTTON_EDITAR}    xpath://*[@id="abrir2"]/div/div/div/div/table/tbody/tr[1]/td[2]/a

*** Keywords ***
Fazer login no Gerenciador PMC
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    Chrome
    Maximize Browser Window
    Title Should Be    Login - Portal PMC
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}

Verificar funcionalidades da tela Consulta de Assunto
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/Assunto/Listar
    Input Text    ${INPUT_NOME_CONSULTA}    Teste
    Click Element    ${BUTTON_FILTRAR}
    Element Should Contain    ${ELEMENT_NOME_FILTRO}    Teste
    Click Element    ${BUTTON_LIMPAR}
    Element Should Not Contain    ${INPUT_NOME_CONSULTA}    Teste

Verificar funcionalidades da tela Cadastro de Assunto
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/assunto/inserir
    Click Element    ${BUTTON_SALVAR_CADASTRO}
    Element Text Should Be    ${ELEMENT_OBRIGATORIO}    O campo Nome é obrigatório.
        ${word}=    FakerLibrary.Word
    Input Text    ${INPUT_NOME_CADASTRO}    Teste ${word}
    Click Element    ${BUTTON_SALVAR_CADASTRO}

Verificar funcionalidades da tela Edição de Assunto
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/Assunto/Listar 
    Input Text    ${INPUT_NOME_CONSULTA}    Teste
    Click Element    ${BUTTON_FILTRAR}
    Click Element    ${BUTTON_EDITAR}
        ${word2}=    FakerLibrary.Word
    Input Text    ${INPUT_NOME_CADASTRO}    Teste ${word2}
    Click Element    ${BUTTON_SALVAR_CADASTRO}

Fechar Navegador
    Close Browser