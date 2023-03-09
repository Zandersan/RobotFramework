*** Settings ***
Resource    ..\\page-objects\\aberturaAtendimento-T2Medico-page-object.robot

*** Test Cases ***
Realizar abertura de atendimento tipo "T2 Médico" e validar regras do sistema
    Fazer login no GpWeb
    Realizar abertura de atendimento tipo "T2 Médico"
    Verificar Regra 4.1
        #REGRA 4.1: Verifica se a duração do atestado ultrapassa 3 dias. Caso isto ocorra, o sistema exibirá a seguinte mensagem: "Quantidade de dias de atestado não pode ser superior à 3 dias.".
    Finalizar Cadastro
    Fechar Navegador