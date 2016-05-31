/**
* @author	   	Ben Edwards (ben@edwards.nz)
* @date		 	2016-05-31
* @description  Test class for the mc_SubscriptionSyncBatch class
* 
* CHANGE LOG
**/
@isTest
public class mc_SubscriptionSyncBatchTest {


	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Test scenario of processing batch for Contacts
	**/
	@isTest
	static void testContactBatchProcessingSubscribe () {

		// Create a new Contact
		Contact testContact = mc_TestData.createContact();

		// Set the Contact to sync
		testContact.mc_Sync_to_Marketing_Cloud__c = true;
		update testContact;

		// Process the batch
		Database.executeBatch(new mc_SubscriptionSyncBatch('Contact'));

		// Not asserting any results - the Marketing Cloud package will do it's thing
	}


	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Test scenario of processing batch for Leads
	**/
	@isTest
	static void testLeadBatchProcessingUnsubscribe () {

		// Create a new Lead
		Lead testLead = mc_TestData.createLead();

		// Set the Lead to sync
		testLead.mc_Sync_to_Marketing_Cloud__c = true;

		// Set Opt Out to test both cases
		testLead.HasOptedOutOfEmail = true;
		update testLead;

		// Process the batch
		Database.executeBatch(new mc_SubscriptionSyncBatch('Lead'));

		// Not asserting any results - the Marketing Cloud package will do it's thing
	}


	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Simple method to test scheduling the class
	**/
	@isTest
	static void testSchedulable () {

		System.schedule('Test Hourly Schedule', '0 0 * * * ?', new mc_SubscriptionSyncBatch('Contact') );
	}
	
}