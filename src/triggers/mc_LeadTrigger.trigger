/**
* @author       Ben Edwards (ben@edwards.nz)
* @date         2016-05-31
* @description  Trigger for the Lead object to process opt-ins and opt-outs
* 
* CHANGE LOG
**/
trigger mc_LeadTrigger on Lead (before update) {

	// Only process if enabled in Custom Setting
	if (mc_Marketing_Cloud_Sync_Settings__c.getInstance().Lead_Sync__c) {

		// Send to the handling class for processing
		mc_SubscriptionSyncHandler.syncEmailSubscriptionMarketingCloud (trigger.new, trigger.oldMap, 'Lead');
	}
}