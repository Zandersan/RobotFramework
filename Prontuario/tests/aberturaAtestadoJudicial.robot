*** Settings ***
Resource    ..\\page-objects\\aberturaAtendimento-Atestado-Judicial-page-object.robot

*** Test Cases ***
    Fazer login no GpWeb
    Realizar abertura de atendimento tipo "Atestado Judicial"
    Verificar Regra 4.1
        #REGRA 4.1: Verifica se a data de início do atestado retroage à um período superior à 6 dias. Caso isto ocorra, o sistema exibirá a seguinte mensagem: "Quantidade de dias retroativos não pode ser superior a 6 dias."
    Verificar Regra 4.2
        #REGRA 4.2: Verifica se a data de início do atestado ultrapassa o limite máximo (que é o segundo dia, a ser contado à partir da data do atendimento). Caso ultrapasse este limite, o sistema exibirá a seguinte mensagem: "Para atestados, a data de início não pode ser superior à DD/MM/AAAA.".
    Fechar Navegador