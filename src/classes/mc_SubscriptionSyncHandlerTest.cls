/**
* @author	   	Ben Edwards (ben@edwards.nz)
* @date		 	2016-05-31
* @description  Test class for the triggers and mc_SubscriptionSyncHandler
* 
* CHANGE LOG
**/
@isTest
public class mc_SubscriptionSyncHandlerTest {
	
	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Test scenario of creating a Contact and checking HasOptedOutOfEmail
	**/
	@isTest
	static void testContactTrigger () {

		// Create a new Contact
		Contact testContact = mc_TestData.createContact();

		// Set opt-out
		testContact.HasOptedOutOfEmail = true;
		update testContact;
	}


	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Test scenario of creating a Lead and checking HasOptedOutOfEmail
	**/
	@isTest
	static void testLeadTrigger () {

		// Create a new Lead
		Lead testLead = mc_TestData.createLead();

		// Set opt-out
		testLead.HasOptedOutOfEmail = true;
		update testLead;
	}


	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Create all test data for the test methods
	**/
	@testSetup
	static void testSetupData () {

		// Enable the Lead and Contact auto-sync
		mc_Marketing_Cloud_Sync_Settings__c syncSettings = new mc_Marketing_Cloud_Sync_Settings__c(SetupOwnerId = System.Userinfo.getOrganizationId());
		syncSettings.Contact_Sync__c = true;
		syncSettings.Lead_Sync__c = true;
		insert syncSettings;
	}

}