/** leadConverterLwc */
import { LightningElement, api } from "lwc";

import customConvertLead from '@salesforce/apex/LeadConversionService.customConvertLead'

export default class LeadConverterLwc extends LightningElement {
  _recordId;
  @api get recordId() {
    return this._recordId
  }
  isRecordIdSet() {
    return this.recordId != null
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

  async handleButtonClick() {
    console.log('handleButtonClick start')
    if (this.isRecordIdSet()) {
      const leadId = this.recordId
      const resultJson = await customConvertLead({leadId})
      console.log('resultJson', resultJson)
    }
  }

  disconnectedCallback() {
    console.log('LeadConverterLwc disconnectedCallback')
  }
}