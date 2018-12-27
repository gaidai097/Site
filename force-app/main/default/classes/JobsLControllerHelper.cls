public class JobsLControllerHelper {
    
    public static List <Job_Advertisement__c> getPageRecords(Map<String, String> params){
        
        String queryString = formQuery(  params);
        // String queryString = 'SELECT ID, CreatedDate from Job_Advertisement__c';
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        ssc.setPageSize( Integer.valueOf( params.get( 'pageSize' )));
        ssc.setPageNumber(Integer.valueOf( params.get( 'pageNumber' )));
        //Integer noOfRecords = ssc.getResultSize();
        List <Job_Advertisement__c> jAs = ssc.getRecords();
        
        return jAs;
    }
    public static Integer getTotalRecordsCount( Map<String, String> params){
        System.debug('getTotalRecordsCount =>>>>');
        System.debug(params);
        String queryString = formQuery( params);
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
        Integer noOfRecords = ssc.getResultSize();
        
        return noOfRecords;
    }
	
    public static String formQuery( Map<String, String> params ){
        System.debug('params =>>>> ' + params);
        String queryString = 'Select Name,ID, Location__c, Status__c,Phone__c, Email__c,Education__c, Manager_name__c, SalaryMax__c, CreatedDate, SalaryMin__c from Job_Advertisement__c WHERE Status__c != \'Archived\'';
        List <String> paramsRows = new List <String>();
        String nameFilter = params.get('nameFilter');
        if( nameFilter != null && nameFilter != '' ){
            paramsRows.add(' Name LIKE ' + '\'%' + nameFilter + '%\'');
        }
        String publishedDateString = params.get('publishedDate');
        if(publishedDateString != '' && publishedDateString != null){
            Date publishedDate = Date.valueOf(publishedDateString);
            if(publishedDate != null && publishedDate <= System.today()){
                String dateFilter = params.get('dateFilter');
                if( dateFilter != 'ALL' || dateFilter != null || dateFilter!=''){
                    if( dateFilter == 'DAY' || dateFilter == null || dateFilter=='')paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) = '+ publishedDate );
                    if( dateFilter == 'BEFORE' ) paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) <= ' + publishedDate );
                    if( dateFilter == 'AFTER' ) paramsRows.add(' DAY_ONLY(convertTimezone(CreatedDate)) >= '+ publishedDate );
                }
            }
        }
        
        String salaryParamString = params.get('salaryParam');
        String salaryFilter = params.get('salaryFilter');
        Integer salaryParam ;
        system.debug('salaryParamString ' + salaryParamString );
        if(salaryParamString != '' && salaryParamString != null){
            salaryParam = Integer.valueOf(salaryParamString) ;
             system.debug('salaryParam ' + salaryParam );
            if(salaryParam != null && salaryParam != 0 && salaryFilter != null){
                switch on salaryFilter{
                    when 'LESS' { paramsRows.add(' SalaryMin__c < ' + salaryParam + ' '); }
                    when 'MORE' {paramsRows.add(' (SalaryMax__c > ' + salaryParam + ' OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');}
                    when 'EQUAL' { paramsRows.add(' SalaryMin__c <= ' + salaryParam + ' AND (SalaryMax__c >= ' + salaryParam + ' OR SalaryMax__c = null )');}
                    when 'NOTEQUAL' {paramsRows.add(' ((SalaryMin__c > ' + salaryParam + ' OR SalaryMax__c < ' + salaryParam + ') OR SalaryMin__c = null)');}
                    when 'LESSOREQUAL' { paramsRows.add(' SalaryMin__c <= ' + salaryParam + ' '); }
                    when 'MOREOREQUAL' {
                        paramsRows.add(' (SalaryMax__c >= ' + salaryParam + ' OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');
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
        String r = '' + queryString;
        return r;
        
    }
}