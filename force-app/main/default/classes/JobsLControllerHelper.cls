public class JobsLControllerHelper {
    
    public static List <Job_Advertisement__c> getPageRecords(String pageNumber, String pageSize, String nameFilter,String publishedDateString, String dateFilter, String salaryFilter, String salaryParamString){
        
        String queryString = formQuery(  nameFilter, publishedDateString, dateFilter, salaryFilter, salaryParamString);
        // String queryString = 'SELECT ID, CreatedDate from Job_Advertisement__c';
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        
        ssc.setPageSize( Integer.valueOf(pageSize) );
        ssc.setPageNumber(Integer.valueOf(pageNumber));
        //Integer noOfRecords = ssc.getResultSize();
        List <Job_Advertisement__c> jAs = ssc.getRecords();
        
        return jAs;
    }
    public static Integer getTotalRecordsCount( String nameFilter, String publishedDateString, String dateFilter, String salaryFilter, String salaryParamString){
        
        String queryString = formQuery( nameFilter, publishedDateString, dateFilter, salaryFilter, salaryParamString);
        // String queryString = 'SELECT ID, CreatedDate from Job_Advertisement__c';
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        
        Integer noOfRecords = ssc.getResultSize();
        
        return noOfRecords;
    }
	
    public static String formQuery( String nameFilter,String publishedDateString, String dateFilter, String salaryFilter, String salaryParamString){
       
        String queryString = 'Select Name,ID, Location__c, Status__c,Phone__c, Email__c,Education__c, Manager_name__c, SalaryMax__c, CreatedDate, SalaryMin__c from Job_Advertisement__c WHERE Status__c != \'Archived\'';
        List <String> paramsRows = new List <String>();
        if( nameFilter != null && nameFilter != '' ){
            paramsRows.add(' Name LIKE ' + '\'%' + nameFilter + '%\'');
        }
        
        if(publishedDateString != '' && publishedDateString != null){
            Date publishedDate = Date.valueOf(publishedDateString);
            if(publishedDate != null && publishedDate <= System.today()){
                if( dateFilter != 'ALL' || dateFilter != null || dateFilter!=''){
                    if( dateFilter == 'DAY' || dateFilter == null || dateFilter=='')paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) = :publishedDate' );
                    if( dateFilter == 'BEFORE' ) paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) <= :publishedDate' );
                    if( dateFilter == 'AFTER' ) paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) >= :publishedDate' );
                }
            }
        }
        
        
        if(salaryParamString != '' && salaryParamString != null){
            Integer salaryParam = Integer.valueOf(salaryParamString) ;
            if(salaryParam != null && salaryParam != 0 && salaryFilter != null){
                switch on salaryFilter{
                    when 'LESS' { paramsRows.add(' SalaryMin__c < :salaryParam '); }
                    when 'MORE' {paramsRows.add(' (SalaryMax__c > :salaryParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');}
                    when 'EQUAL' { paramsRows.add(' SalaryMin__c <= :salaryParam AND (SalaryMax__c >= :salaryParam OR SalaryMax__c = null )');}
                    when 'NOTEQUAL' {paramsRows.add(' ((SalaryMin__c > :salaryParam OR SalaryMax__c < :salaryParam) OR SalaryMin__c = null)');}
                    when 'LESSOREQUAL' { paramsRows.add(' SalaryMin__c <= :salaryParam '); }
                    when 'MOREOREQUAL' {
                        paramsRows.add(' (SalaryMax__c >= :salaryParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');
                    }
                }
            }            
        }
        
        if(paramsRows != null && !paramsRows.isEmpty()){
           
                for(integer i = 0; i< paramsRows.size(); i++){
                    queryString += ' AND ' + paramsRows[i];
                }
                              
        }
        System.debug('queryString => ' + queryString);
        queryString += ' ORDER BY Name ';
        return queryString;
        
    }
}