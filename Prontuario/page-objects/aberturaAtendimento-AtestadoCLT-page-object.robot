*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    xpath://*[@id="Usuario"]
${INPUT_SENHA}    xpath://*[@id="Senha"]
${BUTTON_ENTRAR}    xpath://*[@id="loginForm"]/div/div/button[1]
${BUTTON_CONFIRMAR}    xpath://*[@id="Entrar"]

${LIST_FUNCAO}  xpath://*[@id="FuncaoId"]
${LIST_ENTIDADE}    id=IdEntidade
${INPUT_MATRICULA}    xpath://*[@id="MatriculaServidor"]
${LIST_TIPO_ATENDIMENTO}    xpath://*[@id="TipoAtendimento"]
${BUTTON_INICIAR_ATENDIMENTO}    xpath://*[@id="btnIniciarAtendimento"]

${BUTTON_BUSCAR_MATRICULA}    xpath://*[@id="btnBuscarMatriculaObterS"]
${INPUT_NOME_MATRICULA}    xpath://*[@id="NomeServidorBuscar"]

${UPLOAD_ANEXO}    xpath://*[@id="AtestadoClt_ArquivoUpload"]
${WAIT_CONFIRMACAO_UPLOAD}    xpath://*[@id="formAtestadoClt"]/div[1]/div[2]/div[5]/div/div/div[2]/div[1]/div[1]/div/span
${BUTTON_ANEXAR}    xpath://*[@id="btnAdicionarArquivoAtestadoCLT"]

${BUTTON_SALVAR}    xpath://*[@id="btnGravarAbrirModalAtestadoClt"]
${BUTTON_CONFIRMAR_SALVAR}    xpath://*[@id="btnValidarAtestadoCLT"]
${BUTTON_CONFIRMAR_FERIAS}    xpath://*[@id="btnGravarLaudo"]

*** Keywords ***
Aguardar carregamento da pagina
    Title Should Be    Página Inicial - Gestão de Pessoal Web 

Aguardar carregamento de cadastro
    Title Should Be    Abertura de Atendimento - Gestão de Pessoal Web

Aguardar mensagem de confirmação de cadastro
    Wait Until Element Is Enabled    ${BUTTON_CONFIRMAR_SALVAR}

Confirmação de Férias
    Element Should Be Visible    xpath://*[@id="btnGravarLaudo"]

*** Keywords ***
Fazer login no GpWeb
    Open Browser    http://hom-gpweb-v2.curitiba.pr.gov.br/login   chrome
    Maximize Browser Window
    Wait For Condition    return document.title == "Login - Gestão de Pessoal Web"
    Title Should Be    Login - Gestão de Pessoal Web
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}
    Sleep    3
    ${Element_Confirmar_Login}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR}
    Run Keyword If    ${Element_Confirmar_Login}  Click Element  ${BUTTON_CONFIRMAR}
    Wait Until Keyword Succeeds    15    10    Aguardar carregamento da pagina

Realizar abertura de atendimento tipo "Atestado CLT"
    Go To    http://hom-gpweb-v2.curitiba.pr.gov.br/aberturaatendimento/inserir
    Wait Until Keyword Succeeds    15    10    Aguardar carregamento de cadastro
    Wait Until Element Contains    ${LIST_ENTIDADE}    PMC
    Select From List By Value    ${LIST_ENTIDADE}    00
    Input Text    ${INPUT_MATRICULA}    181050
    Click Element    ${BUTTON_BUSCAR_MATRICULA}
    Wait Until Element Is Visible    ${INPUT_NOME_MATRICULA}
    Select From List By Value    ${LIST_TIPO_ATENDIMENTO}    4
    List Selection Should Be    ${LIST_TIPO_ATENDIMENTO}    ATESTADO CLT
    Click Element    ${BUTTON_INICIAR_ATENDIMENTO}
    Choose File    ${UPLOAD_ANEXO}    D:\\Testes\\Portal PMC\\REQ001 - Controle de acesso.pdf
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_UPLOAD}
    Click Element    ${BUTTON_ANEXAR}

Finalizar Cadastro
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}

Fechar Navegador
    Close Browser