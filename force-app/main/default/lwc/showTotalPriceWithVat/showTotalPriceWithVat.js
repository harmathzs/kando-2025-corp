import { LightningElement, api } from "lwc";

export default class ShowTotalPriceWithVAT extends LightningElement {
  totalPriceWithVAT;

  _recordId;
  @api get recordId() {
    return this._recordId;
  }
  set recordId(value) {
    this._recordId = value;
    console.log('recordId', this._recordId)
  }
}