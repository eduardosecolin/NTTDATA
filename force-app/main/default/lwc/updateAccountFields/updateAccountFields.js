import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_NUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class UpdateAccountFields extends LightningElement {

    nameField = NAME_FIELD;
    accountNumberField = ACCOUNT_NUMBER_FIELD;
    typeField = TYPE_FIELD;

    @api recordId;
    @api objectApiName = 'Account';


    handleSuccess(event) {
        const even = new ShowToastEvent({
            title: 'Sucesso!',
            message: 'Registro atualizado!',
            variant: 'success'
        });
        this.dispatchEvent(even);
    }

    handleError(event){
        const evt = new ShowToastEvent({
            title: 'Erro!',
            message: event.detail.detail,
            variant: 'error',
            mode:'dismissable'
        });
        this.dispatchEvent(evt);
    }
}