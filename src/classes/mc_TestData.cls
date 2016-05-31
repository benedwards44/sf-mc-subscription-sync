/**
* @author	   	Ben Edwards (ben@edwards.nz)
* @date		 	2016-05-31
* @description  Generic utility class for generating data for test methods
* 
* CHANGE LOG
**/
@isTest
public class mc_TestData {

	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Instantiates and creates a dummy test Contact
	* 	@return 	  Created Contact record
	**/
	public static Contact createContact () {

		// Create a new Contact
		Contact testContact 			= new Contact();
		testContact.FirstName 			= 'Snoop';
		testContact.LastName 			= 'Dogg';
		testContact.Email 				= 'snoop@dogg.com';
		testContact.MobilePhone 		= '12 1234 7890';
		testContact.MailingStreet 		= '1 Snoop Dogg Street';
		testContact.MailingCity 		= 'Snooptown';
		testContact.MailingState 		= 'California';
		testContact.MailingCountry 		= 'United States';
		testContact.MailingPostalCode 	= '12345';

		// Insert the contact
		insert testContact;

		return testContact;
	}


	/**
	*   @author		  Ben Edwards (ben@edwards.nz)
	*   @description  Instantiates and creates a dummy test Lead
	* 	@return 	  Created Lead record
	**/
	public static Lead createLead () {

		// Create a new Lead
		Lead testLead 				= new Lead();
		testLead.FirstName 			= 'Snoop';
		testLead.LastName 			= 'Dogg';
		testLead.Company 			= 'Snoop Enterprises';
		testLead.Email 				= 'snoop@dogg.com';
		testLead.MobilePhone 		= '12 1234 7890';
		testLead.Street 			= '1 Snoop Dogg Street';
		testLead.City 				= 'Snooptown';
		testLead.State 				= 'California';
		testLead.Country 			= 'United States';
		testLead.PostalCode 		= '12345';

		// Insert the lead
		insert testLead;

		return testLead;
	}
	
}