*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***
${word}    FakerLibrary.Word

${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

${BUTTON_CADASTRO}    class:btn-primario
${WAIT_OBRIGATORIO}    xpath://*[@id="abrir1"]/div/div[1]/div/span
${ELEMENT_NOME_OBRIGATORIO}    xpath://*[@id="BPO_STR_NOME-error"]
${ELEMENT_TEMA_OBRIGATORIO}    xpath://*[@id="SIS_INT_IDF-error"]
${ELEMENT_TIPO_OBRIGATORIO}    xpath://*[@id="TBP_INT_IDF-error"] 

${INPUT_NOME_CADASTRO}    id=BPO_STR_NOME
${INPUT_URL_CADASTRO}    id=BPO_STR_URL
${INPUT_DATA_INICIO_CADASTRO}    id=BPO_DTM_INICIO
${INPUT_DATA_TERMINO_CADASTRO}    id=BPO_DTM_TERMINO
${LIST_TEMA_CADASTRO}    xpath://*[@id="SIS_INT_IDF"]
${LIST_TIPO_CADASTRO}    xpath://*[@id="TBP_INT_IDF"]
${WAIT_DESKTOP}    xpath://*[@id="displayUploadSimplesDesktop"]/div/label/span
${CHOOSE_DESKTOP}    xpath://*[@id="UploadSimplesDesktop"]
${WAIT_CONFIRMACAO_DESKTOP}    xpath://*[@id="displayUploadSimplesDesktop"]/div/span
${CHOOSE_MOBILE}    xpath://*[@id="UploadSimplesMobile"]
${WAIT_CONFIRMACAO_MOBILE}    xpath://*[@id="displayUploadSimplesMobile"]/div/span

${INPUT_NOME_CONSULTA}    id=Nome
${LIST_TIPO_CONSULTA}    xpath://*[@id="TipoBanner"]
${LIST_TEMA_CONSULTA}    xpath://*[@id="Tema"]
${LIST_PUBLICADO_CONSULTA}    xpath://*[@id="Publicado"]
${BUTTON_CONSULTA}    xpath://*[@id="btnFiltrar"]
${ELEMENT_NOME_CONSULTA}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr[1]/td[3]
${ELEMENT_TIPO_CONSULTA}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr[1]/td[4]
${ELEMENT_TEMA_CONSULTA}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr[1]/td[5]

${BUTTON_EDICAO}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr[1]/td[7]/a
${INPUT_DATA_INICIO_EDICAO}    xpath://*[@id="BPO_DTM_INICIOSTR"]
${INPUT_DATA_TERMINO_EDICAO}    xpath://*[@id="BPO_DTM_TERMINOSTR"]

${BUTTON_EXCLUIR}    xpath://*[@id="formulario"]/div[4]/div/a[3]

*** Keywords ***
Fazer login no Gerenciador PMC
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    Chrome
    Maximize Browser Window
    Title Should Be    Login - Portal PMC
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}

Verificação de regras do Cadastro de Banner com o tipo WebSite_Programas
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/Banner/Inserir
        ${word}=    FakerLibrary.Word
        Click Element    ${BUTTON_CADASTRO}
    Wait Until Element Is Visible    ${WAIT_OBRIGATORIO}
    Element Text Should Be    ${ELEMENT_NOME_OBRIGATORIO}    Campo nome obrigatório.
    Element Text Should Be    ${ELEMENT_TEMA_OBRIGATORIO}    Campo tema obrigatório.
    Element Text Should Be    ${ELEMENT_TIPO_OBRIGATORIO}    Campo tipo de banner obrigatório.

    Input Text    ${INPUT_NOME_CADASTRO}   Teste ${word}
    Input Text    ${INPUT_URL_CADASTRO}    http://${word}.com
    Input Text    ${INPUT_DATA_INICIO_CADASTRO}    21/01/2022
    Input Text    ${INPUT_DATA_TERMINO_CADASTRO}    21/12/2022
    Wait Until Element Is Enabled    ${LIST_TEMA_CADASTRO}
    Select From List By Label    ${LIST_TEMA_CADASTRO}    Cultura
    Select From List By Label    ${LIST_TIPO_CADASTRO}    WebSite_Programas
    Wait Until Element Is Visible    ${WAIT_DESKTOP}
    Choose File    ${CHOOSE_DESKTOP}    D:\\Testes\\Portal PMC\\Imagens\\Desktop Programas.jpg
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_DESKTOP}
    Choose File    ${CHOOSE_MOBILE}     D:\\Testes\\Portal PMC\\Imagens\\Mobile Programas.jpg
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_MOBILE}
    Click Element    ${BUTTON_CADASTRO}

Verificação de regras do Cadastro de Banner com o tipo WebSite_Central
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/Banner/Inserir
        ${word2}=    FakerLibrary.Word
        Click Element    ${BUTTON_CADASTRO}
    Input Text    ${INPUT_NOME_CADASTRO}   Teste ${word2}
    Input Text    ${INPUT_URL_CADASTRO}    http://${word2}.com
    Input Text    ${INPUT_DATA_INICIO_CADASTRO}    21/01/2022
    Input Text    ${INPUT_DATA_TERMINO_CADASTRO}    21/12/2022
    Select From List By Label    ${LIST_TEMA_CADASTRO}    Prefeitura    Servidor
    Select From List By Label    ${LIST_TIPO_CADASTRO}    WebSite_Central
    Wait Until Element Is Visible    ${WAIT_DESKTOP}
    Choose File    ${CHOOSE_DESKTOP}    D:\\Testes\\Portal PMC\\Imagens\\Desktop Central.jpg
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_DESKTOP}
    Choose File    ${CHOOSE_MOBILE}    D:\\Testes\\Portal PMC\\Imagens\\Mobile Central.jpg
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_MOBILE}
    Click Element    ${BUTTON_CADASTRO}

Verificação de regras do Consulta de Banner
        Go To    https://dev-gerenciador.curitiba.pr.gov.br/Banner/Listar
    Input Text    ${INPUT_NOME_CONSULTA}    Teste
    Select From List By Label    ${LIST_TIPO_CONSULTA}   WebSite_Programas
    Select From List By Label    ${LIST_PUBLICADO_CONSULTA}   Sim
    Select From List By Label    ${LIST_TEMA_CONSULTA}   Cultura
    Click Element    ${BUTTON_CONSULTA}
    Sleep    5 seconds
    Element Should Contain   ${ELEMENT_NOME_CONSULTA}    Teste 
    Element Should Contain   ${ELEMENT_TIPO_CONSULTA}    Website - Programas 
    Element Should Contain   ${ELEMENT_TEMA_CONSULTA}    Cultura 

Verificação de regras do Edição de Banner
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/Banner/Listar
    Click Element    ${BUTTON_EDICAO}
            ${word3}=    FakerLibrary.Word
    Input Text    ${INPUT_NOME_CADASTRO}   Teste ${word3}
    Input Text    ${INPUT_URL_CADASTRO}    http://${word3}.com
    Input Text    ${INPUT_DATA_INICIO_EDICAO}    11/03/2022
    Input Text    ${INPUT_DATA_TERMINO_EDICAO}    15/12/2024
    Select From List By Label    ${LIST_TEMA_CADASTRO}    COHAB
    Choose File    ${CHOOSE_DESKTOP}    D:\\Testes\\Portal PMC\\Imagens\\Desktop Programas.jpg
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_DESKTOP}
    Choose File    ${CHOOSE_MOBILE}    D:\\Testes\\Portal PMC\\Imagens\\Mobile Programas.jpg
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_MOBILE}
    Click Element    ${BUTTON_CADASTRO}

Verificação de regras da Exclusão de Banner
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/Banner/Listar
    Click Element    ${BUTTON_EDICAO}
    Click Element    ${BUTTON_EXCLUIR}
    
Fechar Navegador
    Close Browser


# Verificação de regras do Cadastro Banner WebSite_Programas
#     Go To    https://dev-gerenciador.curitiba.pr.gov.br/Banner/Inserir
#         ${word}=    FakerLibrary.Word
#         ${data}=    FakerLibrary.Date This Year    Date.between(from: '2022/01/01', to: '2022/12/31').strftime("%d/%m/%Y")
#     Element Text Should Be    xpath://*[@id="abrir1"]/div/div[1]/div/label    Nome
#     Element Text Should Be    xpath://*[@id="abrir1"]/div/div[2]/div/label    Marque Para Publicar
#     Element Text Should Be    xpath://*[@id="abrir1"]/div/div[3]/div/label    Link(Url)
#     Element Text Should Be    xpath://*[@id="abrir2"]/div/div[1]/label    Data Inicio
#     Element Text Should Be    xpath://*[@id="abrir2"]/div/div[2]/label    Data Término
#     Element Text Should Be    xpath://*[@id="abrir2"]/div/div[3]/div/label    Tema
#     Element Text Should Be    xpath://*[@id="abrir2"]/div/div[4]/div/label    Ordem
#     Element Text Should Be    xpath://*[@id="abrir2"]/div/div[5]/div/label    Abrir
#     Element Text Should Be    xpath://*[@id="abrir2"]/div/div[6]/div/label    Tempo de animação em segundos
#     Element Text Should Be    xpath://*[@id="abrir2"]/div/div[7]/div/label    Tipo de banner