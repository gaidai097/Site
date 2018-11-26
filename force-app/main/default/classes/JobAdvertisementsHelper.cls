public class JobAdvertisementsHelper{
    public  Map <String, String> params;
    public  List <String> statusList;
    public  String middleQueryPart;
    
	public  List <Job_Advertisement__c> selectAllJobAdvertisements(){             
        String query = 'SELECT id, Name, Manager_name__c, Skills_Required__c,'
            + 'Email__c, Description__c ,Location__c,Education__c,'
            + 'Status__c, Phone__c, SalaryMax__c , SalaryMin__c FROM Job_Advertisement__c '; 
        
        List <String> paramsRows = new List <String>();        
		if(params.get('name') != null){
            String filterName = params.get('name');
            paramsRows.add( ' Name LIKE ' + '\'%' + filterName + '%\'');
        }
        if( statusList != null && statusList.size() > 0 ){
            paramsRows.add(' Status__c IN :statusList');
        }
        if(params.get('salary_param') != null && params.get('salary_filter') != null){
            String filterName = params.get('salary_filter');
            Integer filterParam = Integer.valueof(params.get('salary_param'));
            switch on filterName{
                when 'LESS' { paramsRows.add(' SalaryMin__c < :filterParam '); }
                when 'MORE' {
                    paramsRows.add(' (SalaryMax__c > :filterParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');
                }
                when 'EQUAL' { 
                    paramsRows.add(' SalaryMin__c <= :filterParam AND (SalaryMax__c >= :filterParam OR SalaryMax__c = null )');
                }
                when 'NOTEQUAL' {
                    paramsRows.add(' ((SalaryMin__c > :filterParam OR SalaryMax__c < :filterParam) OR SalaryMin__c = null)');
                }
                when 'LESSOREQUAL' { paramsRows.add(' SalaryMin__c <= :filterParam '); }
                when 'MOREOREQUAL' {
                    paramsRows.add(' (SalaryMax__c >= :filterParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');
                }
            }
        }
        if( paramsRows.size() > 0){
            if( paramsRows.size() == 1 ){
                query += ' WHERE ' + paramsRows[0] ;
            }else{  
                query += ' WHERE ' + paramsRows[0] ;
                for( Integer i = 1; i < paramsRows.size() ; i++ ){
                    query += ' AND ' + paramsRows[i] ;
                }
            }
        }        
        
        
        if( params.get('orderSort') != null && params.get('orderSort') != ''){
            query += ' ORDER BY ' + params.get('orderSort') ;
            if( params.get('orderType') == 'DESC') query += ' DESC';
        }
        Integer page_limit = Integer.valueof(params.get('pageSize')) ;
        System.debug( '+++checkedLimit+++' + params.get('pageSize'));
        System.debug( '+++checkedLimit+++' + page_limit);
        Integer page_offset = Integer.valueof(params.get('page_offset'))*page_limit ;
        query += ' LIMIT :page_limit OFFSET :page_offset ' ;        
        System.debug('All query : ' + query);
        try{            
            return database.query(query);
        }catch(QueryException e){
            throw new Task6Exception('Query Exception during selecting' + e.getMessage());
        }
    }
    
    public  Integer countJobAdvertisements(){        
        List <String> paramsRows = new List <String>();
        String query = 'SELECT count() FROM Job_Advertisement__c ';   
        
		if(params.get('name') != null){
            String filterName = params.get('name');
            paramsRows.add( ' Name LIKE ' + '\'%' + filterName + '%\'');
        }
        if( statusList != null && statusList.size() > 0 ){
            paramsRows.add(' Status__c IN :statusList');
        }
        if(params.get('salary_param') != null && params.get('salary_filter') != null){
            String filterName = params.get('salary_filter');
            Integer filterParam = Integer.valueof(params.get('salary_param'));
            switch on filterName{
                when 'LESS' { paramsRows.add(' SalaryMin__c < :filterParam '); }
                when 'MORE' {
                    paramsRows.add(' (SalaryMax__c > :filterParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');
                }
                when 'EQUAL' { 
                    paramsRows.add(' SalaryMin__c <= :filterParam AND (SalaryMax__c >= :filterParam OR SalaryMax__c = null )');
                }
                when 'NOTEQUAL' {
                    paramsRows.add(' ((SalaryMin__c > :filterParam OR SalaryMax__c < :filterParam) OR SalaryMin__c = null)');
                }
                when 'LESSOREQUAL' { paramsRows.add(' SalaryMin__c <= :filterParam '); }
                when 'MOREOREQUAL' {
                    paramsRows.add(' (SalaryMax__c >= :filterParam OR (SalaryMin__c !=null AND SalaryMax__c = null)) ');
                }
            }
        }
        if( paramsRows.size() > 0){
            if( paramsRows.size() == 1 ){
                query += ' WHERE ' + paramsRows[0] ;
            }else{
                query += ' WHERE ' + paramsRows[0] ;
                for( Integer i = 1; i < paramsRows.size() ; i++ ){
                    query += ' AND ' + paramsRows[i] ;
                }
            }
        }
        
        try{
            return database.countQuery(query);
        }catch(QueryException e){
            throw new Task6Exception('Query Exception during counting ' + e.getMessage());
        }        
    }   
}