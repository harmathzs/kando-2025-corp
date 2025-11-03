import { LightningElement, api } from 'lwc';

export default class MyFirstLightningCard extends LightningElement {
    _recordId;
    @api get recordId() {
        console.log('get recordId', this._recordId)
        return this._recordId
    }
    set recordId(value) {
        console.log('set recordId', this._recordId)
        this._recordId = value
    }

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