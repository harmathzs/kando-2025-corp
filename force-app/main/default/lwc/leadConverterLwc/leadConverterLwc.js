import { LightningElement } from "lwc";

import customConvertLead from '@salesforce/apex/LeadConversionService.customConvertLead';

export default class LeadConverterLwc extends LightningElement {
  leadId;
  result;

  async convertLead() {
    this.result = await customConvertLead({leadId: this.leadId})
  }
}