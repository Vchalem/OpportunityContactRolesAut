@isTest
public class CheckDeleteTest {
	@isTest
    public static void testDelete(){
    //create contact
    	Contact c = new Contact();
    	c.FirstName = 'test';
    	c.LastName = 'minor';
    	c.Birthdate = System.Today()+3;
        insert c; 
        
        //query for contact
        Contact con = [SELECT Id, FirstName FROM Contact WHERE FirstName ='test'];
        
        //create opportunity
        Opportunity o = new Opportunity();
        o.CloseDate = System.Today();
        o.Name = 'testOppty';
        o.StageName = 'Closed Won';
        insert o;
        //query oppty
        Opportunity opp = [SELECT Id, Name FROM Opportunity LIMIT 1];
        
        //create OCR 
        OpportunityContactRole ocr = new OpportunityContactRole();
        ocr.OpportunityId = opp.Id;
        ocr.ContactId = con.Id;
        ocr.Role = 'Household Member';
        
        //query for OCR (to ensure was deleted)
        List<OpportunityContactRole> listOCR = [SELECT Id FROM OpportunityContactRole];
        
        System.assertEquals(listOCR.size(), 0);
     }
}