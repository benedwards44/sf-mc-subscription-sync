/**
* @author	   	Ben Edwards (ben@edwards.nz)
* @date		 	2016-05-31
* @description  Handle the pushing of opt-in's and opt-outs to Marketing Cloud
* 
* CHANGE LOG
**/
public class mc_SubscriptionSyncHandler {

	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Process the syncing of opt-in/opt-out changes to Marketing Cloud
	* 	@return 	  void
	**/
	public static void syncEmailSubscriptionMarketingCloud (List<SObject> newList, Map<Id, SObject> oldMap, String objectName) {

		// Boolean to control whether the sync batch should be started
		Boolean startSyncBatch = false;

		// Iterate over the record set
		for (SObject record :newList) {

			// Get the record Id for the dynamic SObject
			Id recordId = (Id) record.get('Id');

			// If the email opt out has changed
			if (record.get('HasOptedOutOfEmail') != oldMap.get(recordId).get('HasOptedOutOfEmail')) {

				// If there is a record to sync, set a flag on the record. This enables the batch class to pick it up
				record.put('mc_Sync_to_Marketing_Cloud__c', true);

				// Set the variable flag to ensure batch is executed immediately from here
				startSyncBatch = true;
			}
		}

		// If there are records to sync, start the batch
		if (startSyncBatch) {

			// Start the batch and run in series of 1. As this has to make a single callout per contact or lead (not bulkified)
			// Only want to run in small batches
			// Also note, this process will only work for users who have an associated Marketing CLoud user account
			// for all other users, a scheduled batch will run as system admin to sync the opt-outs
			Database.executeBatch(new mc_SubscriptionSyncBatch(objectName), 1);
		}

	}

}