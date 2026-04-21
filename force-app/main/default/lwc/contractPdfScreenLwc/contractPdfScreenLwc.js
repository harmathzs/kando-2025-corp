import { LightningElement, api } from 'lwc';

export default class ContractPdfScreenLwc extends LightningElement {
    _contractId;
    pdfUrl;

    @api get recordId() {
        return this._contractId
    }
    set recordId(value) {
        this._contractId = value
        console.log('set recordId ', this.recordId)

        this.pdfUrl = '/apex/ContractPDF?id='+this.recordId
    }

}