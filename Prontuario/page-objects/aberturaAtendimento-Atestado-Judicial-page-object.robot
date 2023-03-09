*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR
Library    DateTime

*** Variables ***

${INPUT_USUARIO}    xpath://*[@id="Usuario"]
${INPUT_SENHA}    xpath://*[@id="Senha"]
${BUTTON_ENTRAR}    xpath://*[@id="loginForm"]/div/div/button[1]
${BUTTON_CONFIRMAR}    id=Entrar

${BUTTON_SALVAR}    xpath://*[@id="btnGravarAbrirModalAtestadoJudicial"]
${BUTTON_CONFIRMAR_SALVAR}    xpath://*[@id="btnValidarAtestadoJudicial"]
${BUTTON_CONFIRMAR_FERIAS}    xpath://*[@id="btnGravarLaudo"]

${LIST_FUNCAO}  xpath://*[@id="FuncaoId"]
${LIST_ENTIDADE}    id=IdEntidade
${INPUT_MATRICULA}    xpath://*[@id="MatriculaServidor"]
${LIST_TIPO_ATENDIMENTO}    xpath://*[@id="TipoAtendimento"]
${BUTTON_INICIAR_ATENDIMENTO}    xpath://*[@id="btnIniciarAtendimento"]
${BUTTON_BUSCAR_MATRICULA}    xpath://*[@id="btnBuscarMatriculaObterS"]
${INPUT_NOME_MATRICULA}    xpath://*[@id="NomeServidorBuscar"]

${UPLOAD_ANEXO}    xpath://*[@id="AtestadoJudicial_ArquivoUpload"]
${WAIT_CONFIRMACAO_UPLOAD}    xpath://*[@id="tabAtestadoJudicialConteudo"]/form/div[1]/div[2]/div[6]/div/div/div[2]/div[1]/div[1]/div/span
${BUTTON_ANEXAR}    xpath://*[@id="btnAdicionarArquivoAtestadoJudicial"]

${INPUT_DATA_INICIO}    xpath://*[@id="AtestadoJudicial_DataInicio"]
${INPUT_DATA_FIM}    xpath://*[@id="AtestadoJudicial_DataFim"]
${LIST_TIPO_DOCUMENTO}    xpath://*[@id="AtestadoJudicial_Documento"]
${INPUT_NUMERO_DOCMENTO}    xpath://*[@id="AtestadoJudicial_NumeroDocumento"] 
${INPUT_ANO_DOCUMENTO}    xpath://*[@id="AtestadoJudicial_AnoDocumento"]
${LIST_TIPO_CONCLUSAO}    xpath://*[@id="AtestadoJudicial_TipoConclusao"]

${ERRO_6DIAS}    xpath://html/body/div/div/div/main/section/div[3]
${ERRO_INICIO_2DIAS}    xpath://html/body/div/div/div/main/section/div[3]

*** Keywords ***
Aguardar carregamento da pagina
    Title Should Be    Página Inicial - Gestão de Pessoal Web 

Aguardar carregamento de cadastro
    Title Should Be    Abertura de Atendimento - Gestão de Pessoal Web

Aguardar mensagem de confirmação de cadastro
    Wait Until Element Is Enabled    ${BUTTON_CONFIRMAR_SALVAR}

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

Realizar abertura de atendimento tipo "Atestado Judicial"
    Go To    http://hom-gpweb-v2.curitiba.pr.gov.br/aberturaatendimento/inserir
    Wait Until Keyword Succeeds    15    10    Aguardar carregamento de cadastro
    Wait Until Element Contains    ${LIST_ENTIDADE}    PMC
    Select From List By Value    ${LIST_ENTIDADE}    00
    Input Text    ${INPUT_MATRICULA}    135309
    Click Element    ${BUTTON_BUSCAR_MATRICULA}
    Wait Until Element Is Visible    ${INPUT_NOME_MATRICULA}
    Select From List By Value    ${LIST_TIPO_ATENDIMENTO}    6
    List Selection Should Be    ${LIST_TIPO_ATENDIMENTO}    ATESTADO JUDICIAL
    Click Element    ${BUTTON_INICIAR_ATENDIMENTO}
    Choose File    ${UPLOAD_ANEXO}    D:\\Testes\\Portal PMC\\REQ001 - Controle de acesso.pdf
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_UPLOAD}
    Click Element    ${BUTTON_ANEXAR}

Verificar Regra 4.1
    #REGRA 4.1: Verifica se a data de início do atestado retroage à um período superior à 6 dias. Caso isto ocorra, o sistema exibirá a seguinte mensagem: "Quantidade de dias retroativos não pode ser superior a 6 dias."
    ${DATA_ANTERIOR_6}    Get Current Date    increment=-6 day    result_format=%d/%m/%Y
    ${DATA_ATUAL}    Get Current Date    result_format=%d/%m/%Y
    Input Text    ${INPUT_DATA_INICIO}    ${DATA_ANTERIOR_6}
    Input Text    ${INPUT_DATA_FIM}    ${DATA_ATUAL}
    Select From List By Value    ${LIST_TIPO_DOCUMENTO}    1
    List Selection Should Be    ${LIST_TIPO_DOCUMENTO}    PROCESSO
    Input Text    ${INPUT_NUMERO_DOCMENTO}    1
    Input Text    ${INPUT_ANO_DOCUMENTO}    2023  
    Select From List By Value    ${LIST_TIPO_CONCLUSAO}    29
    List Selection Should Be    ${LIST_TIPO_CONCLUSAO}    T08-AFASTAMENTO POR ORDEM JUDICIAL
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${ERRO_6DIAS}
    Element Should Be Visible    ${ERRO_6DIAS}

Verificar Regra 4.2
    #REGRA 4.2: Verifica se a data de início do atestado ultrapassa o limite máximo (que é o segundo dia, a ser contado à partir da data do atendimento). Caso ultrapasse este limite, o sistema exibirá a seguinte mensagem: "Para atestados, a data de início não pode ser superior à DD/MM/AAAA.".
    ${PROXIMA_DATA_2}    Get Current Date    increment=2 day    result_format=%d/%m/%Y
    ${PROXIMA_DATA_3}    Get Current Date    increment=3 day    result_format=%d/%m/%Y
    Input Text    ${INPUT_DATA_FIM}    ${PROXIMA_DATA_2} 
    Input Text    ${INPUT_DATA_INICIO}    ${PROXIMA_DATA_3}  
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${ERRO_INICIO_2DIAS}
    Element Should Be Visible    ${ERRO_INICIO_2DIAS}

Fechar Navegador
    Close Browser