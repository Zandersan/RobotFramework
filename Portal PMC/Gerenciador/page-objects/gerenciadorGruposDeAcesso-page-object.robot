*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    FakerLibrary    locale=pt_BR

*** Variables ***

${INPUT_USUARIO}    id=Usuario
${INPUT_SENHA}    id=Senha
${BUTTON_ENTRAR}    id=loginEntrar

${BUTTON_USUARIOS_ADMICI}    xpath://*[@id="divFiltro"]/div/div/table/tbody/tr[1]/td[7]/a
${INPUT_NOME_FILTRO}    xpath://*[@id="Nome"]
${ELEMENT_NOME}    xpath://*[@id="divFiltro"]/div/div/div/table/tbody/tr/td[1]
${BUTTON_FILTRAR}    xpath://*[@id="btnFiltrar"]
${BUTTON_LIMPAR_FILTRO}    xpath://*[@id="btnLimpar"]
${ELEMENT_OBRIGATORIO_FILTRO}    xpath://*[@id="GrupoUsuario-error"]
${BUTTON_EDITAR}    xpath://*[@id="divFiltro"]/div/div/table/tbody/tr[1]/td[8]/a

${LIST_TEMAS}    xpath://*[@id="TemasAssociadosOriginal"]
${BUTTON_TEMAS_CADASTRO}    xpath://*[@id="abrir2"]/div/div/div/div/div[2]/button[2]
${LIST_AREAS}    xpath://*[@id="AreasAssociadasOriginal"]
${BUTTON_AREAS_CADASTRO}    xpath://*[@id="abrir3"]/div/div/div/div/div[2]/button[2]
${BUTTON_SALVAR_PERMISSAO}    xpath://*[@id="formulario"]/div[4]/div/button
${WAIT_SUCESSO}    xpath//*[@id="mensagemSucessoDisplay"]
${BUTTON_VOLTAR_PERMISSAO}    xpath://*[@id="formulario"]/div[4]/div/a[2]
${LIST_TEMAS_DESASSOCIAR}    xpath://*[@id="TemasAssociados"]
${BUTTON_TEMAS_DESCADASTRO}    xpath://*[@id="abrir2"]/div/div/div/div/div[2]/button[3]
${LIST_AREAS_DESASSOCIAR}    xpath://*[@id="AreasAssociadas"]
${BUTTON_AREAS_DESCADASTRO}    xpath://*[@id="abrir3"]/div/div/div/div/div[2]/button[3]


*** Keywords ***
Fazer login no Gerenciador PMC
    Open Browser    https://dev-gerenciador.curitiba.pr.gov.br/inicio/login    chrome
    Maximize Browser Window
    Title Should Be    Login - Portal PMC
    Input Text    ${INPUT_USUARIO}    alexrocha
    Input Password    ${INPUT_SENHA}    \#.senhasenha
    Click Element    ${BUTTON_ENTRAR}

Verificar funcionalidades da tela de Consulta de Grupos de Acesso
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/gruposacesso/listar

Verificar funcionalidades da tela de Consulta de Usuários
    Click Element    ${BUTTON_USUARIOS_ADMICI}
    Input Text    ${INPUT_NOME_FILTRO}    Teste
    Click Element    ${BUTTON_FILTRAR}
    Element Should Contain    ${ELEMENT_NOME}    Teste
    Click Element    ${BUTTON_LIMPAR_FILTRO}
    Click Element    ${BUTTON_FILTRAR}
    Element Text Should Be    ${ELEMENT_OBRIGATORIO_FILTRO}    Campo "Grupo de Usuário" obrigatório.

Verificar funcionalidades da tela de Edição de Permissões
    Go To    https://dev-gerenciador.curitiba.pr.gov.br/gruposacesso/listar
    Click Element    ${BUTTON_EDITAR}
    Select From List By Label    ${LIST_TEMAS}    Teste common
    Click Element    ${BUTTON_TEMAS_CADASTRO}
    Select From List By Label    ${LIST_AREAS}    Teste Lista
    Click Element    ${BUTTON_AREAS_CADASTRO}
    Click Element    ${BUTTON_SALVAR_PERMISSAO}
    Click Element    ${BUTTON_VOLTAR_PERMISSAO}
    Click Element    ${BUTTON_EDITAR}
    Select From List By Label    ${LIST_TEMAS_DESASSOCIAR}    Teste common
    Click Element    ${BUTTON_TEMAS_DESCADASTRO}
    Select From List By Index    ${LIST_AREAS_DESASSOCIAR}    Teste Lista
    Click Element    ${BUTTON_AREAS_DESCADASTRO}
    Click Element    ${BUTTON_SALVAR_PERMISSAO}
    Wait Until Element Is Visible    ${WAIT_SUCESSO}
    Click Element    ${BUTTON_VOLTAR_PERMISSAO}

Fechar Navegador
    Close Browser