import { LightningElement, api } from "lwc";
import getOrderProductById from '@salesforce/apex/OrderProductService.getOrderProductById'

export default class ShowTotalPriceWithVAT extends LightningElement {
  totalPriceWithVAT;

  _recordId;
  @api get recordId() {
    return this._recordId;
  }
  set recordId(value) {
    this._recordId = value;
    console.log('recordId', this._recordId)

    getOrderProductById({orderProductId: this._recordId})
    .then(result => {
      console.log('result', result)
      this.totalPriceWithVAT = result.Total_Price_with_VAT__c;
    })
    .catch(error => {
      console.warn('error', error)
    })
  }
}