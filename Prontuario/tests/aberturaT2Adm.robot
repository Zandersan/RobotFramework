*** Settings ***
Resource    ..\\page-objects\\aberturaAtendimento-T2Adm-page-object.robot

*** Test Cases ***
Realizar abertura de atendimento tipo "T2 Administrativo" e validar regras do sistema
    Fazer login no GpWeb
    Realizar abertura de atendimento tipo "T2 Administrativo"
    Verificar Regra 4.1
        #REGRA 4.1: Verifica se a duração do atestado ultrapassa 10 dias. Caso isto ocorra, o sistema exibirá a seguinte mensagem: "Quantidade de dias de atestado não pode ser superior à 10 dias.".
    Verificar Regra 4.2
        #REGRA 4.2: Verifica se a data de início do atestado ultrapassa o limite máximo (que é o segundo dia, a ser contado à partir da data em que é realizado o atendimento). Caso ultrapasse este limite, o sistema exibirá a seguinte mensagem: "Para atestados, a data de início não pode ser superior à DD/MM/AAAA." e não permite a gravação.
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