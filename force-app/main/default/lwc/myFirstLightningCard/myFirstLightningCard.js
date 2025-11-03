import { LightningElement, api } from 'lwc';

export default class MyFirstLightningCard extends LightningElement {
    @api recordId;

    connectedCallback() {
        console.log('connectedCallback recordId', this.recordId)
    }

    renderedCallback() {
        console.log('renderedCallback recordId', this.recordId)
    }

    disconnectedCallback() {
        console.log('disconnectedCallback recordId', this.recordId)
    }
}