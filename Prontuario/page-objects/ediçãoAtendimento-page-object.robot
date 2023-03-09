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
${LIST_ENTIDADE}    xpath://*[@id="IdEntidade"]
${INPUT_MATRICULA}    xpath://*[@id="MatriculaServidor"]
${INPUT_ANO}    xpath://*[@id="AnoAtendimento"]
${INPUT_NUMERO_ATENDIMENTO}    xpath://*[@id="NumeroAtendimento"]
${BUTTON_FILTRAR}    class=btn-secundario
${NOME_SERVIDOR}    xpath://*[@id="gridListarAberturaAtendimento"]/table/tbody/tr/td[4]
${ANO_CONSULTA}    xpath://*[@id="gridListarAberturaAtendimento"]/table/tbody/tr/td[3]
${NUMERO_CONSULTA}    xpath://*[@id="gridListarAberturaAtendimento"]/table/tbody/tr/td[2]
${BUTTON_LIMPAR}    xpath://html/body/div/div/div/main/section/form/div/div[2]/div[3]/div/a

${BUTTON_EDITAR}    xpath://*[@id="gridListarAberturaAtendimento"]/table/tbody/tr[1]/td[6]/a

${BUTTON_BUSCAR_MATRICULA}    xpath://*[@id="btnBuscarMatriculaObterS"]
${INPUT_NOME_MATRICULA}    xpath://*[@id="NomeServidorBuscar"]

${UPLOAD_ANEXO}    xpath://*[@id="Laudo_ArquivoUpload"]
${WAIT_CONFIRMACAO_UPLOAD}    xpath://*[@id="Laudo_ArquivoUpload"]
${BUTTON_ANEXAR}    xpath://*[@id="btnAdicionarArquivo"]
${BUTTON_REMOVER}    xpath://*[@id="gridDocumentosLaudo"]/table/tbody/tr/td[3]/a

${BUTTON_SALVAR}    xpath://*[@id="btnGravarAbrirModalAtestadoClt"]
${BUTTON_CONFIRMAR_SALVAR}    xpath://*[@id="idRowLaudo_ArquivoUpload"]/div/div/div[2]/div[1]/div/div/span
${BUTTON_CONFIRMAR_FERIAS}    xpath://*[@id="btnGravarLaudo"]

*** Keywords ***
Aguardar carregamento da pagina
    Title Should Be    Página Inicial - Gestão de Pessoal Web 

Aguardar carregamento de consulta
    Title Should Be    Listar Abertura de Atendimento - Gestão de Pessoal Web

Aguardar carregamento de edição
    Element Text Should Be    xpath://html/body/div/div/div/main/section/div[1]/div[1]/h2    Abertura de Atendimento

Aguardar envio de documento
    Wait Until Element Is Enabled    ${BUTTON_REMOVER}

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

Realizar consulta de atendimento
    Go To    http://hom-gpweb-v2.curitiba.pr.gov.br/AberturaAtendimento/Listar
    Wait Until Keyword Succeeds    15    10    Aguardar carregamento de consulta
    Wait Until Element Contains    ${LIST_ENTIDADE}    PMC
    Select From List By Value    ${LIST_ENTIDADE}    00
    Input Text    ${INPUT_MATRICULA}    135309
    Input Text    ${INPUT_ANO}    2023
    Input Text    ${INPUT_NUMERO_ATENDIMENTO}    112
    Click Element    ${BUTTON_FILTRAR}
    Element Text Should Be    ${NOME_SERVIDOR}    FERNANDA FERRO LIMA
    Element Text Should Be    ${ANO_CONSULTA}    2023
    Element Text Should Be    ${NUMERO_CONSULTA}    112
    Click Element    ${BUTTON_LIMPAR}
    Element Should Not Contain    ${INPUT_MATRICULA}    135309
    Element Should Not Contain    ${INPUT_ANO}   2023
    Element Should Not Contain    ${INPUT_NUMERO_ATENDIMENTO}    112

Realizar edição de atendimento
    Click Element    ${BUTTON_EDITAR}
    Wait Until Keyword Succeeds    15    10    Aguardar carregamento de edição
    Choose File    ${UPLOAD_ANEXO}    D:\\Testes\\Portal PMC\\REQ001 - Controle de acesso.pdf
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_UPLOAD}
    Click Element    ${BUTTON_ANEXAR}
    Wait Until Keyword Succeeds    15    10    Aguardar envio de documento
    Click Element    ${BUTTON_REMOVER}
    Wait Until Element Is Not Visible    ${BUTTON_REMOVER}
    Element Should Be Visible    ${BUTTON_REMOVER}

Fechar Navegador
    Close Browser