/**
* @author	   Ben Edwards (ben@edwards.nz)
* @date		 2016-05-31
* @description  Batch class to execute the physical callout of the update to Marketing Cloud
* 
* CHANGE LOG
**/
public class mc_SubscriptionSyncBatch implements Database.Batchable<sObject>, Schedulable, Database.AllowsCallouts {

	// The object to process for the batch
	public final String objectType;

	// CONSTRUCTOR
	public mc_SubscriptionSyncBatch (String objType) {

		// Assign the object type from the constructor variable
		objectType = objType;
	}

	/*
		BATCH CLASS METHODS
	*/
	
	// The Start of the Batch
	public Database.QueryLocator start(Database.BatchableContext BC) {

		// Query all contacts that require to be synced
		return Database.getQueryLocator('SELECT Id, HasOptedOutOfEmail FROM ' + objectType + ' WHERE mc_Sync_to_Marketing_Cloud__c = true');
	}

	// Execute the job logic
	public void execute(Database.BatchableContext BC, List<SObject> scope) {

		// Iterate over contacts
		for (SObject recordTypeSync :scope) {

			// Execute the opt-out sync and capture result
			String result = executeUnSubReSubCallout ((Id) recordTypeSync.get('Id'), (Boolean) recordTypeSync.get('HasOptedOutOfEmail'));

			// If the contact is successfully synced
			if (result == 'success' || result == 'not found') {

				// Set sync flag to false, so it doesn't get picked up again
				recordTypeSync.put('mc_Sync_to_Marketing_Cloud__c', false);
				recordTypeSync.put('mc_Marketing_Cloud_Sync_Error__c', null);
			}
			else {

				// Set any errors against the contact
				recordTypeSync.put('mc_Marketing_Cloud_Sync_Error__c', result);
			}

			// If failed, leave the flag as true as it will get picked up in a scheduled batch and retried.
		}

		// Update the contacts so they aren't synced again
		update scope;
	}

	// Finish silently
	public void finish(Database.BatchableContext BC) {}
		
	/*
		SCHEDULABLE METHODS
	*/

	// The Schedulable execute method
	public void execute(SchedulableContext sc) {

		// Start the batch and run in seriers of 5. As this has to make a single callout per contact (not bulkified)
		// Only want to run in small batches
		Database.executeBatch(new mc_SubscriptionSyncBatch(objectType), 1);
	}



	/**
	*   @author		 	Ben Edwards (ben@cloudinit.nz)
	*   @description	Execute callout asyncronously to MC API
	**/
	private String executeUnSubReSubCallout (Id recordId, Boolean isUnsub) {

		// Variable to capture the sync result. Set to failed.
		// The sync method will update to success if successful
		String syncResult = 'Not Started';

		try {

			// Different methods for unsubscribe and re-subscribe
			if (isUnsub) {

				// Attempt unsub integration
				syncResult = et4ae5.jsButtonMethods.performUnsub(recordId, objectType);
			}
			else {

				// Attempt re-sub integration
				syncResult = et4ae5.jsButtonMethods.performResub(recordId, objectType);
			}
		}
		catch (Exception ex) {

			// Set the result to failed for any errors
			syncResult = String.valueOf(ex);

			// Capture failure in debug
			system.debug('### Error syncing Contact to Marketing Cloud: ' + ex);
		}

		return syncResult;
	}

}