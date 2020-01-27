//should be an @future class that implements schedulable
//and is fired off on a recurring basis  
public class CheckDelete {

    public static void deleteOCR(List<OpportunityContactRole> ocrList){
        
        List<OpportunityContactRole> ocrToDel = new List<OpportunityContactRole>();
        
        //create a map of OCRs to Contact Ids 
        Map<Id, OpportunityContactRole> mapOC = new Map<Id, OpportunityContactRole>();
        
        for(OpportunityContactRole ocr : ocrList){
        	mapOC.put(ocr.ContactId, ocr);
        }
        
        //List<Id> conIds = mapOC.values(); //get contact Ids 
            
        Set<Id> conIds = mapOC.keySet();
        
        //query for all contact Ids to get 
        List<Contact> contacts = [SELECT Id, Age__c FROM Contact where Id IN : conIds];
        
        //iterate through contacts - check which under 19 years old
        List<Contact> minors = new List<Contact>();
        for(Contact c : contacts){
            if(c.Age__c <= 19){
                minors.add(c);
            }
        }
        
        for(Contact minorContact : minors){
            //get associated OCR 
            OpportunityContactRole thisocr = mapOC.get(minorContact.Id);
            
            //check criteria of ocr
            if(thisocr.Role == 'Household Member'){
            	//add OCR to list
            	ocrToDel.add(thisocr);    
            }
            
            
        }
        //delete those ocrs from list 
        //Database.delete(ocrToDel);
        update ocrToDel;
       
        
    }
}