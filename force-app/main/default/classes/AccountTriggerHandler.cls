public class AccountTriggerHandler {
    
    public void onBeforeInsert(List<Account> accounts){
        for(Account acc : accounts){
            validaCPFCNPJ(acc);
        }
    }

    public void onBeforeUpdate(List<Account> accounts){
        for(Account acc : accounts){
            validaCPFCNPJ(acc);
        }
    }

    public void onAfterInsert(List<Account> accounts){
        Id parceiro_RT_id = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
        Id consumidorFinal_RT_id = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumidor_final').getRecordTypeId();
        
        List<Opportunity> opps = new List<Opportunity>();
        List<Task> tasks = new List<Task>();
        
        for(Account acc : accounts){
            if(acc.RecordTypeId == parceiro_RT_id){
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name + ' - opp Parceiro';
                opp.CloseDate = System.today().addDays(30);
                opp.StageName = 'Qualification';
                opps.add(opp);
            }

            if(acc.RecordTypeId == consumidorFinal_RT_id){
                Task task_obj = new Task();
                task_obj.Subject = 'Consumidor Final';
                task_obj.WhatId = acc.Id;
                task_obj.Status = '	Not Started';
                task_obj.Priority = 'Normal';
                tasks.add(task_obj);
            }
        }

        if(opps.size() > 0){
            insert opps;
        }

        if(tasks.size() > 0){
            insert tasks;
        }
    }

    private void validaCPFCNPJ(Account acc){
        if(acc.Type == 'CPF'){
            if(!Utils.validaCPF(acc.AccountNumber)){
                acc.addError('“Número do cliente é inválido');
            }
        }
    
        if(acc.Type == 'CNPJ'){
            if(!Utils.validaCNPJ(acc.AccountNumber)){
                acc.addError('“Número do cliente é inválido');
            }
        }
    }
}
