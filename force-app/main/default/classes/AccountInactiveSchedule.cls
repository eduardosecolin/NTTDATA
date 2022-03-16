global class AccountInactiveSchedule implements Schedulable{
    
    global void execute(SchedulableContext sc) {
        AccountInactiveBatchable batch = new AccountInactiveBatchable(); 
        DataBase.executebatch(batch);
    }

    // Script Execute Anonymous
    // Executar script abaixo para agendamento

    /*
    
    AccountInactiveSchedule schedule = new AccountInactiveSchedule();
    string sch = '0 0 0,6,12,18,23 ? * MON-FRI';
    System.schedule('Inactive Accounts', sch, schedule);
    
    */
}
