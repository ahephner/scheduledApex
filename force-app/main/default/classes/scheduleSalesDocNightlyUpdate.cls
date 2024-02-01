public without sharing class scheduleSalesDocNightlyUpdate implements Schedulable{
    public void execute(SchedulableContext ctx){
         salesDocNightlyUpdate.removeSales(); 
        
    }

}