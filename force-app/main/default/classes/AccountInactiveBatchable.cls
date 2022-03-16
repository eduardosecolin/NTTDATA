public class AccountInactiveBatchable implements DataBase.Batchable<SObject>{
    
    public DataBase.QueryLocator start(DataBase.BatchableContext bc){

        string query = 'SELECT Id, Inativa__c FROM Account WHERE Id NOT IN (' + 
               'SELECT AccountId FROM Opportunity WHERE (CloseDate = LAST_N_DAYS:120 AND StageName = \'Closed Won\') OR StageName = \'Negotiation/Review\')';

        return DataBase.getQueryLocator(query);
    }

    public void execute(DataBase.BatchableContext bc, List<Account> accounts){

        if(accounts.size() > 0){
            for(Account acc : accounts){
                acc.Inativa__c = true;
            }

            DataBase.SaveResult[] results = DataBase.update(accounts, false);
            for(DataBase.SaveResult sr : results){
                if(!sr.isSuccess()){
                    for(DataBase.Error err : sr.getErrors()){
                        System.debug(err.getStatusCode() + ' - ' + err.getMessage());
                        System.debug(err.getFields());
                    }
                }
            }
        }

    }

    public void finish(DataBase.BatchableContext bc){

    }
}
