public class salesDocNightlyUpdate {
    public static string removeSales(){
        date ninetyAgo = Date.today() - 90; 
        list<sales_doc_detail__c> updateDocs = new list<sales_doc_detail__c>(); 
        list<sales_doc_detail__c> docs = [select id,name, Qualify_90_Day_Sale__c from sales_doc_detail__c where Qualify_90_Day_Sale__c = true
                                          and sales_document__r.doc_date__c <:ninetyAgo and track_margin__c = true];
        system.debug(docs.size());
        system.debug(docs);
        if(docs.size()>1){
            for(sales_doc_detail__c x:docs){
                x.Qualify_90_Day_Sale__c = false; 
                updateDocs.add(x);
            }
        }
        update updateDocs; 
        return 'done';
    }
}