/** leadConverterLwc */
import { LightningElement, api } from "lwc";

export default class LeadConverterLwc extends LightningElement {
  @api recordId;

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