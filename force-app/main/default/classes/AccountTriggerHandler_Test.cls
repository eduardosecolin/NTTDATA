
@isTest
public class AccountTriggerHandler_Test {

    @TestSetup
    static void makeData(){
        

        List<Account> accounts = new List<Account>();

        Account acc1 = new Account(
            Name = 'Test Opp',
            AccountNumber = '12345678901',
            Type = 'CPF',
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId()
        );

        accounts.add(acc1);

        Account acc2 = new Account(
            Name = 'Test Task',
            AccountNumber = '12345678901234',
            Type = 'CNPJ',
            RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumidor_final').getRecordTypeId()
        );

        accounts.add(acc2);
        
        insert accounts;
    }

    @isTest
    static void testValidaCPF(){

        Account acc = new Account(
            Name = 'Test CPF',
            AccountNumber = '123456',
            Type = 'CPF'
        );

        try{
            insert acc;
        }
        catch(Exception ex){
            System.assertEquals(ex.getMessage().contains('Número do cliente é inválido'), true);
        }
    }

    @isTest
    static void testValidaCNPJ(){

        Account acc = new Account(
            Name = 'Test CNPJ',
            AccountNumber = '123456789012345',
            Type = 'CNPJ'
        );

        try{
            insert acc;
        }
        catch(Exception ex){
            System.assertEquals(ex.getMessage().contains('Número do cliente é inválido'), true);
        }
    }

    @isTest
    static void testValidaOpp(){

        Test.startTest();
        Opportunity opp = [SELECT Name, StageName, CloseDate, Account.Name FROM Opportunity LIMIT 1];
        Test.stopTest();

        System.assertEquals(opp.Account.Name == 'Test Opp', true);
    }

    @isTest
    static void testValidaTask(){

        Test.startTest();
        Task task_obj = [SELECT Subject, Status, Priority, WhatId FROM Task LIMIT 1];
        Test.stopTest();

        System.assertEquals(task_obj.Subject == 'Consumidor Final', true);
    }
}
