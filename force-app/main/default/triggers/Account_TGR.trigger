trigger Account_TGR on Account (before insert, before update, after insert) {

    AccountTriggerHandler handler = new AccountTriggerHandler();

    if(Trigger.isInsert){
        if(Trigger.isAfter){
            handler.onAfterInsert(Trigger.new);
        }

        if(Trigger.isBefore){
            handler.onBeforeInsert(Trigger.new);
        }
    }

    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            handler.onBeforeUpdate(Trigger.new);
        }
    }

}