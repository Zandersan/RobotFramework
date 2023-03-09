*** Settings ***
Resource    ..\\page-objects\\aberturaAtendimento-Atestado-page-object.robot

*** Test Cases ***
Realizar abertura de atendimento tipo "Atestado" e validar regras do sistema
    Fazer login no GpWeb
    Realizar abertura de atendimento tipo "Atestado"
    Verificar Regra 4.4
        #REGRA 4.4: Verifica se a quantidade de dias retroativos deve ser <= 6 dias, nessa situação mostrar a mensagem: “Quantidade de dias retroativos não pode ser superior a 6 dias!” e não permite a gravação
    Verificar Regra 4.5
        #REGRA 4.5: Data de início do atestado não pode ser a data futura superior a 1 dia, se acontecer, exibir a mensagem “Para atestados a DATA INÍCIO máxima permitida é " + V_DATA_MAXIMA_X)”  onde V_DATA_MAXIMA_X é a data de hoje + 1 dia.".
    Verificar Regra 4.6
        #REGRA 4.6: Verificar os CIDs em comum:
        # Os CIDs devem começar com uma letra.
        # CIDs anteriores devem ser informados primeiro (VALIDAR CID 2,3 E 4)
        # Se informar dependente o CID principal deve ser Z76.3 e informar CID secundário.
        # Se CID principal é Z76.3, tipo de conclusão deve ser 07 (T12).
        # Se informar Z54.0, tem que informar próximo CID.  
        # CID Z33 tipo conclusão deve ser T11-LICENÇA GESTANTE.
        # CID Z33 apenas para o sexo feminino.
    Finalizar Cadastro
    Fechar Navegador