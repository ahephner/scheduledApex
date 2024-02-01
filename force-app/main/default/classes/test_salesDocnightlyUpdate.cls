@isTest
public class test_salesDocnightlyUpdate {
// Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2024';
    @isTest
    static void testScheduledJob(){
        Test.startTest();
        string jobId = System.schedule('ScheduledApexTest', CRON_EXP, new scheduleSalesDocNightlyUpdate());
        Test.stopTest();
    }
    
    @isTest
    static void testsalesDocNightlyUpdate(){
        //only runs with 90 day old line items looks at sales doc field
        date saleDate = date.today()-95;
        //create test customer
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.RecordTypeId = '01241000001Dy64AAC';
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;
        
        //ats product
        Product__c prod = new Product__c();
        prod.Name = 'ats-123';
        prod.Product_Name__c = 'fert';
        prod.Active__c = true;
        insert prod;
        
            //prod2
        product2 product = new product2(name ='product', IsActive= True, stockkeepingUnit='ats-123');
        insert product;
        
        Sales_Document__c header = new Sales_Document__c();
        header.Name = 'SO654';
        header.Customer__c = cust.Id;
        header.Doc_Type__c = 'Invoice';
        header.Sales_Doc_Num__c = '9877';
        header.Number_of_Payments__c = 1;
        header.Doc_Date__c = saleDate; 
        insert header;
        
        Sales_Doc_Detail__c footer = new Sales_Doc_Detail__c();
        footer.Name = 'SO654 line 1';
        footer.Sales_Document__c = header.id; 
        footer.Product__c = prod.id;
        footer.Qualify_90_Day_Sale__c = true;
        footer.Track_Margin__c = true; 
        insert footer; 
        test.startTest();
        	salesDocNightlyUpdate.removeSales();
        test.stopTest();
        
    }
}