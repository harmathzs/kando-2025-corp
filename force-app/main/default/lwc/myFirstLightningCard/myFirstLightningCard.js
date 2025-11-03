import { LightningElement, api } from 'lwc';

export default class MyFirstLightningCard extends LightningElement {
    @api recordId;

    connectedCallback() {
        console.log('connectedCallback recordId', this.recordId)
    }
}