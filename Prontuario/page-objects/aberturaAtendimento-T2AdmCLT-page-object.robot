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

${BUTTON_SALVAR}    xpath://*[@id="btnGravarT2"]
${BUTTON_CONFIRMAR_SALVAR}    xpath://*[@id="btnValidarT2Medico"]
${BUTTON_CONFIRMAR_FERIAS}    xpath://*[@id="btnGravarLaudo"]

${LIST_FUNCAO}  xpath://*[@id="FuncaoId"]
${LIST_ENTIDADE}    id=IdEntidade
${INPUT_MATRICULA}    xpath://*[@id="MatriculaServidor"]
${LIST_TIPO_ATENDIMENTO}    xpath://*[@id="TipoAtendimento"]
${BUTTON_INICIAR_ATENDIMENTO}    xpath://*[@id="btnIniciarAtendimento"]
${BUTTON_BUSCAR_MATRICULA}    xpath://*[@id="btnBuscarMatriculaObterS"]
${INPUT_NOME_MATRICULA}    xpath://*[@id="NomeServidorBuscar"]

${UPLOAD_ANEXO}    xpath://*[@id="T2_ArquivoUpload"]
${WAIT_CONFIRMACAO_UPLOAD}    xpath://*[@id="divAnexos"]/div/div/div[2]/div[1]/div[1]/div/span
${BUTTON_ANEXAR}    xpath://*[@id="btnAdicionarT2Arquivo"]

${INPUT_DATA_INICIO}    xpath://*[@id="T2_DataInicio"]
${INPUT_DATA_FIM}    xpath://*[@id="T2_DataFim"]
${BUTTON_DEPENDENTE}    xpath://*[@id="btnBuscarT2Dependente"]
${BUTTON_FECHAR_DEPENDENTE}    xpath://*[@id="btnFecharModalT2Dependente"]
${BUTTON_DEPENDENTE_1}    xpath://*[@id="gridT2Dependente"]/table/tbody/tr[1]/td[4]/a
${LIST_TIPO_CONCLUSAO}    xpath://*[@id="T2_TipoConclusao"]
${INPUT_CID_1}    xpath://*[@id="T2_CID1"]
${INPUT_CID_2}    xpath://*[@id="T2_CID2"]
${INPUT_CID_3}    xpath://*[@id="T2_CID3"]
${INPUT_CID_4}    xpath://*[@id="T2_CID4"]

${ERRO_10DIAS}    xpath://html/body/div/div/div/main/section/div[3]
${ERRO_INICIO_2DIAS}    xpath://html/body/div/div/div/main/section/div[3]
${ERRO_CID_Z76.3}    xpath//html/body/div/div/div/main/section/div[3]
${ERRO_CID_Z54.0}    xpath://html/body/div/div/div/main/section/div[3]
${ERRO_CID_Z33}    xpath://html/body/div/div/div/main/section/div[3]
${ERRO_CID_1_BRANCO}    xpath://*[@id="T2_CID1-error"]
${ERRO_CID_3_BRANCO}    xpath://html/body/div/div/div/main/section/div[3]
${ERRO_CID_2_BRANCO}    xpath://html/body/div/div/div/main/section/div[3]

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

Realizar abertura de atendimento tipo "T2 Administrativo CLT"
    Go To    http://hom-gpweb-v2.curitiba.pr.gov.br/aberturaatendimento/inserir
    Wait Until Keyword Succeeds    15    10    Aguardar carregamento de cadastro
    Wait Until Element Contains    ${LIST_ENTIDADE}    PMC
    Select From List By Value    ${LIST_ENTIDADE}    00
    Input Text    ${INPUT_MATRICULA}    181050
    Click Element    ${BUTTON_BUSCAR_MATRICULA}
    Wait Until Element Is Visible    ${INPUT_NOME_MATRICULA}
    Select From List By Value    ${LIST_TIPO_ATENDIMENTO}    7
    List Selection Should Be    ${LIST_TIPO_ATENDIMENTO}    T2 ADMINISTRATIVO CLT
    Click Element    ${BUTTON_INICIAR_ATENDIMENTO}
    Choose File    ${UPLOAD_ANEXO}    D:\\Testes\\Portal PMC\\REQ001 - Controle de acesso.pdf
    Wait Until Element Is Visible    ${WAIT_CONFIRMACAO_UPLOAD}
    Click Element    ${BUTTON_ANEXAR}

Verificar Regra 4.1
    #REGRA 4.1: Verifica se a duração do atestado ultrapassa 10 dias. Caso isto ocorra, o sistema exibirá a seguinte mensagem: "Quantidade de dias de atestado não pode ser superior à 10 dias.".
    Input Text    ${INPUT_DATA_INICIO}    15/01/2023
    Input Text    ${INPUT_DATA_FIM}    30/01/2023
    Input Text    ${INPUT_CID_1}    a123    
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_10DIAS}
    Element Should Be Visible    ${ERRO_10DIAS}

Verificar Regra 4.2
    #REGRA 4.2: Verifica se a data de início do atestado ultrapassa o limite máximo (que é o segundo dia, a ser contado à partir da data em que é realizado o atendimento). Caso ultrapasse este limite, o sistema exibirá a seguinte mensagem: "Para atestados, a data de início não pode ser superior à DD/MM/AAAA." e não permite a gravação.
    ${PROXIMA_DATA_2}    Get Current Date    increment=2 day    result_format=%d/%m/%Y
    ${PROXIMA_DATA_3}    Get Current Date    increment=3 day    result_format=%d/%m/%Y
    Input Text    ${INPUT_DATA_FIM}    ${PROXIMA_DATA_2} 
    Input Text    ${INPUT_DATA_INICIO}    ${PROXIMA_DATA_3}  
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_INICIO_2DIAS}
    Element Should Be Visible    ${ERRO_INICIO_2DIAS}

Verificar Regra 4.6
    #REGRA 4.6: Verificar os CIDs em comum:
    # Os CIDs devem começar com uma letra.
    # CIDs anteriores devem ser informados primeiro (VALIDAR CID 2,3 E 4)
    Input Text    ${INPUT_DATA_INICIO}    25/01/2023
    Input Text    ${INPUT_DATA_FIM}    25/01/2023
    Input Text    ${INPUT_CID_4}    123
    Clear Element Text    ${INPUT_CID_1}
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_CID_1_BRANCO}
    Element Should Be Visible    ${ERRO_CID_1_BRANCO}

    Input Text    ${INPUT_CID_1}    a123
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_CID_3_BRANCO}
    Element Should Be Visible    ${ERRO_CID_3_BRANCO}

    Input Text    ${INPUT_CID_3}    a123               
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_CID_2_BRANCO}
    Element Should Be Visible    ${ERRO_CID_2_BRANCO}
    Clear Element Text    ${INPUT_CID_3}
    Clear Element Text    ${INPUT_CID_4}

    # Se informar dependente o CID principal deve ser Z76.3 e informar CID secundário.
    Input Text    ${INPUT_CID_1}    Z76.3
    Click Element    ${BUTTON_SALVAR}
    Sleep    3
    Wait Until Element Is Visible    ${ERRO_CID_Z76.3}
    Element Should Be Visible    ${ERRO_CID_Z76.3}
    
    Click Element    ${BUTTON_DEPENDENTE}
    Wait Until Element Is Visible    ${BUTTON_FECHAR_DEPENDENTE}
    Click Element    ${BUTTON_DEPENDENTE_1}
    Wait Until Element Is Visible    ${BUTTON_SALVAR}
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_CID_2_BRANCO}
    Element Should Be Visible    ${ERRO_CID_2_BRANCO}

    # Se CID principal é Z76.3, tipo de conclusão deve ser 07 (T12).
    Input Text    ${INPUT_CID_2}    a123
    Click Element    ${BUTTON_SALVAR}
    Sleep    3
    Wait Until Element Is Visible    ${ERRO_CID_Z76.3}
    Element Should Be Visible    ${ERRO_CID_Z76.3}

    # Se informar Z54.0, tem que informar próximo CID.  
    Input Text    ${INPUT_CID_2}    Z54.0
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_CID_Z54.0}
    Element Should Be Visible    ${ERRO_CID_Z54.0}  
    Input Text    ${INPUT_CID_3}    Z54.0
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_CID_Z54.0}
    Element Should Be Visible    ${ERRO_CID_Z54.0}  

    # CID Z33 tipo conclusão deve ser T11-LICENÇA GESTANTE.
    # CID Z33 apenas para o sexo feminino.
    Clear Element Text    ${INPUT_CID_2}
    Clear Element Text    ${INPUT_CID_3}
    Clear Element Text    ${INPUT_CID_4}
    Input Text    ${INPUT_CID_1}    Z33
    Click Element    ${BUTTON_SALVAR}
    Wait Until Element Is Visible    ${ERRO_CID_Z33}
    Element Should Be Visible    ${ERRO_CID_Z33}

    Select From List By Value    ${LIST_TIPO_CONCLUSAO}    11  

Finalizar Cadastro
    Click Element    ${BUTTON_SALVAR}
    Wait Until Keyword Succeeds    15    10   Aguardar mensagem de confirmação de cadastro
    Sleep    5
    Click Element    ${BUTTON_CONFIRMAR_SALVAR}
    ${Element_Ferias}=  Run Keyword And Return Status    Element Should Be Visible   ${BUTTON_CONFIRMAR_FERIAS}
    Run Keyword If    ${Element_Ferias}  Click Element    ${BUTTON_CONFIRMAR_FERIAS}

Fechar Navegador
    Close Browser