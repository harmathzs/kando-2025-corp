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

  isLoading = false;

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
      this.isLoading = true

      customConvertLead({leadId})
      .then(resultJson=>{
        console.log('resultJson', resultJson)
        const result = JSON.parse(resultJson)
        console.log('result', result)
        // TODO - redirect to contact (record) page
      })
      .catch(console.warn)
      .finally(()=>this.isLoading=false)
    }
  }

  disconnectedCallback() {
    console.log('LeadConverterLwc disconnectedCallback')
  }
}