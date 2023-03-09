*** Settings ***
Resource    ..\\page-objects\\aberturaAtendimento-Laudo-page-object.robot

*** Test Cases ***
Realizar abertura de atendimento tipo "Laudo" e validar regras do sistema
    Fazer login no GpWeb
    Realizar abertura de atendimento tipo "Laudo"
    Verificar Regra 12
        #REGRA 12: Se pediu abertura de atendimento para LAUDO 14-REVISÃO DE APOSENTADORIA e não é aposentado, o sistema mostra a seguinte mensagem "Não é permitida a abertura deste Tipo de Laudo para Servidores que não sejam Aposentados!".
    Verificar Regra 14
        #REGRA 14: Se pediu abertura de atendimento para LAUDO 4 -ISENÇÃO DE IMPOSTO DE RENDA LEI 8541/92 ART. 47º e o servidor não é aposentado, o sistema mostra a seguinte mensagem "Não é permitida a abertura deste Tipo de Laudo para Servidores que não sejam Aposentados!".
    Verificar Regra 15
        #REGRA 15: Se pediu abertura de atendimento para LAUDO 10 10-ISENÇÃO DE CONTRIBUIÇÃO PREVIDENCIÁRIA e não é aposentado ou é aposentado falecido, o sistema mostra a seguinte mensagem "Não é permitida a abertura deste Tipo de Laudo para Servidores que não sejam Aposentados ou  aposentado falecido!"
    Verificar Regra 16
        #REGRA 16: Se for selecionado tipo documento "03-Laudo" e subtipo de laudo "02-AVAL. CAP. LAB.", ou tipo documento "03-Laudo" e subtipo de laudo "17-INCLUSÃO DECRETO 430/2020 - ORDEM JUDICIAL" , o sistema torna obrigatório os seguintes campos: "Documento", "Número do documento", "Ano do documento" e "Médico Perito".
    Verificar Regra 17
        #REGRA 17: Para o documento "03 - Laudo", caso seja informado o subtipo de documento de laudo "13-ACIDENTE DE TRABALHO / DOENÇA OCUPACIONAL" é obrigatório informar número e ano do CAT. Caso não seja informado o sistema deverá mostrar a seguinte mensagem "É obrigatório informar o número e ano CAT.".
    Finalizar Cadastro
    Fechar Navegador