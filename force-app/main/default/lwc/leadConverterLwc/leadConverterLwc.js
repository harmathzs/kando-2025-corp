/** leadConverterLwc */
import { LightningElement, api } from "lwc";

export default class LeadConverterLwc extends LightningElement {
  _recordId;
  @api get recordId() {
    return this._recordId
  }
  async handleRecordIdSet(value) {
    console.log('handleRecordIdSet value', value)
  }
  set recordId(value) {
    this._recordId = value
    this.handleRecordIdSet(value).catch(console.warn)
  }

  displayInfo = {
    primaryField: "Name",
    additionalFields: ["Company"],
  };

  connectedCallback() {
    console.log('LeadConverterLwc connectedCallback')
  }

  renderedCallback() {
    console.log('LeadConverterLwc renderedCallback')
    console.log('renderedCallback recordId', this.recordId)
  }

  disconnectedCallback() {
    console.log('LeadConverterLwc disconnectedCallback')
  }
}