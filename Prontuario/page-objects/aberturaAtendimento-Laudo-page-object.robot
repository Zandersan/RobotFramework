*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    xpath://*[@id="Usuario"]
${INPUT_SENHA}    xpath://*[@id="Senha"]
${BUTTON_ENTRAR}    xpath://*[@id="loginForm"]/div/div/button[1]
${BUTTON_CONFIRMAR}    id=Entrar

${LIST_FUNCAO}  xpath://*[@id="FuncaoId"]
${LIST_ENTIDADE}    id=IdEntidade
${INPUT_MATRICULA}    xpath://*[@id="MatriculaServidor"]
${LIST_TIPO_ATENDIMENTO}    xpath://*[@id="TipoAtendimento"]
${BUTTON_INICIAR_ATENDIMENTO}    xpath://*[@id="btnIniciarAtendimento"]

${WAIT_LAUDO}    xpath://*[@id="tabLaudoTitulo"]
${LIST_TIPO_PEDIDO}    xpath://*[@id="Laudo_TipoPedido"]
${RADIO_ACIDENTE}    xpath://*[@id="formLaudo"]/div[1]/div[2]/div[3]/div[2]/div/label[2]/input
${RADIO_AGENDAR_LAUDO}  xpath://*[@id="formLaudo"]/div[1]/div[2]/div[2]/div[4]/div/div/label
${INPUT_NOME_MATRICULA}    xpath://*[@id="NomeServidorBuscar"]
${BUTTON_BUSCAR_MATRICULA}    xpath://*[@id="btnBuscarMatriculaObterS"]

${LIST_TIPO_LAUDO}    xpath://*[@id="Laudo_TipoLaudo"]
${UPLOAD_ANEXO}    xpath://*[@id="Laudo_ArquivoUpload"]
${BUTTON_ANEXAR}    xpath://*[@id="btnAdicionarArquivo"]
${INPUT_DIAS}    xpath://*[@id="Laudo_NumeroDias"]
${BUTTON_SALVAR}    xpath://*[@id="btnGravarAbrirModal"]
${BUTTON_CONFIRMAR_SALVAR}    id=btnValidarLaudo
${BUTTON_CONFIRMAR_FERIAS}    xpath://*[@id="btnGravarLaudo"]

${FERIAS}    Confirmação de Férias

${Element_Confirmar_Login}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR}

${ERRO_APOSENTADO}    xpath://html/body/div/div/div/main/section/div[3]
${OBRIGATORIO_TIPO_DOCUMENTO}    xpath://*[@id="formLaudo"]/div[1]/div[2]/div[8]/div[4]/div/span[2]  
${OBRIGATORIO_NUMERO_DOCUMENTO}    xpath://*[@id="formLaudo"]/div[1]/div[2]/div[8]/div[5]/div/span
${OBRIGATORIO_ANO_DOCUMENTO}    xpath://*[@id="formLaudo"]/div[1]/div[2]/div[8]/div[6]/div/span
${ERRO_OBRIGATORIO_CAT}    xpath://html/body/div/div/div/main/section/div[3]

${INPUT_NUMERO_CAT}    xpath://*[@id="Laudo_NumeroCAT"]
${INPUT_ANO_CAT}    xpath://*[@id="Laudo_NumeroCAT"]
${SELECT_LIST_CAT}    xpath://*[@id="Laudo_Documento"]
${CHECKBOX_CAT}    xpath://*[@id="Laudo_ApresentouCAT"]

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

Realizar abertura de atendimento tipo "Laudo"
    Go To    http://hom-gpweb-v2.curitiba.pr.gov.br/aberturaatendimento/inserir
    Wait Until Keyword Succeeds    15    10    Aguardar carregamento de cadastro
    Wait Until Element Contains    ${LIST_ENTIDADE}    PMC
    Select From List By Value    ${LIST_ENTIDADE}    00
    Input Text    ${INPUT_MATRICULA}    135309
    Click Element    ${BUTTON_BUSCAR_MATRICULA}
    Wait Until Element Is Visible    ${INPUT_NOME_MATRICULA}
    Select From List By Value    ${LIST_TIPO_ATENDIMENTO}    3
    List Selection Should Be    ${LIST_TIPO_ATENDIMENTO}    LAUDO
    Click Element    ${BUTTON_INICIAR_ATENDIMENTO}
    Choose File    ${UPLOAD_ANEXO}    D:\\Testes\\Portal PMC\\REQ001 - Controle de acesso.pdf
    Wait Until Element Is Visible    xpath://*[@id="formLaudo"]/div[1]/div[2]/div[10]/div/div/div[2]/div[1]/div[1]/div/span
    Click Element    ${BUTTON_ANEXAR}
    Input Text    ${INPUT_DIAS}    2

Verificar Regra 12
    #REGRA 12: Se pediu abertura de atendimento para LAUDO 14-REVISÃO DE APOSENTADORIA e não é aposentado, o sistema mostra a seguinte mensagem "Não é permitida a abertura deste Tipo de Laudo para Servidores que não sejam Aposentados!".
    Select From List By Label    ${LIST_TIPO_PEDIDO}    1-NORMAL
    Wait Until Element Is Visible    xpath://*[@id="Laudo_TipoLaudo"]/option[8]
    Select From List By Label    ${LIST_TIPO_LAUDO}    14-REVISÃO DE APOSENTADORIA
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${ERRO_APOSENTADO}
    Element Should Be Visible    ${ERRO_APOSENTADO}

Verificar Regra 14
#REGRA 14: Se pediu abertura de atendimento para LAUDO 4 -ISENÇÃO DE IMPOSTO DE RENDA LEI 8541/92 ART. 47º e o servidor não é aposentado, o sistema mostra a seguinte mensagem "Não é permitida a abertura deste Tipo de Laudo para Servidores que não sejam Aposentados!".
    Select From List By Label    ${LIST_TIPO_LAUDO}    04-ISENÇÃO DE IMPOSTO DE RENDA LEI 8541/92 ART. 47º
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${ERRO_APOSENTADO}
    Element Should Be Visible    ${ERRO_APOSENTADO}

Verificar Regra 15
#REGRA 15: Se pediu abertura de atendimento para LAUDO 10 10-ISENÇÃO DE CONTRIBUIÇÃO PREVIDENCIÁRIA e não é aposentado ou é aposentado falecido, o sistema mostra a seguinte mensagem "Não é permitida a abertura deste Tipo de Laudo para Servidores que não sejam Aposentados ou  aposentado falecido!"
    Select From List By Label    ${LIST_TIPO_LAUDO}    10-ISENÇÃO DE CONTRIBUIÇÃO PREVIDENCIÁRIA
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${ERRO_APOSENTADO}
    Element Should Be Visible    ${ERRO_APOSENTADO}

Verificar Regra 16
#REGRA 16: Se for selecionado tipo documento "03-Laudo" e subtipo de laudo "02-AVAL. CAP. LAB.", ou tipo documento "03-Laudo" e subtipo de laudo "17-INCLUSÃO DECRETO 430/2020 - ORDEM JUDICIAL" , o sistema torna obrigatório os seguintes campos: "Documento", "Número do documento", "Ano do documento" e "Médico Perito".
    Select From List By Label    ${LIST_TIPO_LAUDO}    AVAL. CAP. LAB.
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${OBRIGATORIO_TIPO_DOCUMENTO}
    Element Should Be Visible    ${OBRIGATORIO_TIPO_DOCUMENTO}
    Element Should Be Visible    ${OBRIGATORIO_NUMERO_DOCUMENTO}
    Element Should Be Visible    ${OBRIGATORIO_ANO_DOCUMENTO}

    Select From List By Label    ${LIST_TIPO_LAUDO}    INCLUSÃO DECRETO 430/2020 - ORDEM JUDICIAL
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${OBRIGATORIO_TIPO_DOCUMENTO}
    Element Should Be Visible    ${OBRIGATORIO_TIPO_DOCUMENTO}
    Element Should Be Visible    ${OBRIGATORIO_NUMERO_DOCUMENTO}
    Element Should Be Visible    ${OBRIGATORIO_ANO_DOCUMENTO}

Verificar Regra 17
#REGRA 17: Para o documento "03 - Laudo", caso seja informado o subtipo de documento de laudo "13-ACIDENTE DE TRABALHO / DOENÇA OCUPACIONAL" é obrigatório informar número e ano do CAT. Caso não seja informado o sistema deverá mostrar a seguinte mensagem "É obrigatório informar o número e ano CAT.".
    Select From List By Label    ${LIST_TIPO_LAUDO}    13-ACIDENTE DE TRABALHO / DOENÇA OCUPACIONAL
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}
    Wait Until Element Is Visible    ${ERRO_OBRIGATORIO_CAT}
    Element Should Be Visible    ${ERRO_OBRIGATORIO_CAT}
    Input Text    ${INPUT_NUMERO_CAT}    2
    Input Text    ${INPUT_ANO_CAT}    2023
    Select From List By Label    ${SELECT_LIST_CAT}    ORDEM DE SERVIÇO
    Select Checkbox    ${CHECKBOX_CAT}

Finalizar Cadastro
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}

Fechar Navegador
    Close Browser