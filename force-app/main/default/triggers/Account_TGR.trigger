trigger Account_TGR on Account (before insert, after insert) {

    AccountTriggerHandler handler = new AccountTriggerHandler();

    if(Trigger.isInsert){
        if(Trigger.isAfter){
            handler.onAfterInsert(Trigger.new);
        }

        if(Trigger.isBefore){
            handler.onBeforeInsert(Trigger.new);
        }
    }

}