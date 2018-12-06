public class JobAdvertisementsController {
	public Integer page_offset {public get; public set;}
    public Integer pageSize {public get; public set;}
    public Integer pagesTotal {public get; public set;}
    public Integer currentPage {public get; public set;}
    public Integer jobAdvertisementsDBCount {get; set;}
    public Integer salaryParam {public get; public set;}
    public String salaryFilter {public get; public set;}
    public String nameFilter{public get; public set;}
    public String orderSort {public get; public set;}
    public String orderType {public get; public set;}
    public List <Job_Advertisement__c> allJAs {public get; public set;}   
    public String[] checkedStatuses = new String[]{};
    public JobAdvertisementsHelper jah;
    
    public List <SelectOption> getStatusLabels() {
        List <SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Active','Active'));
        options.add(new SelectOption('On hold','On hold'));
        options.add(new SelectOption('Archived','Archived'));            
        return options;
    }    
    public String[] getCheckedStatuses() {
        return checkedStatuses;
    }    
    public void setCheckedStatuses(String[] checkedStatuses) {
        System.debug(' String[] checkedStatuses ' + checkedStatuses);
        this.checkedStatuses = checkedStatuses;
    }
    // reSelect data if salary value parameter not empty
    public void onSalaryFilterChange(){
        if( salaryParam != null && salaryParam != 0 ) toFirstPage();
    }
    public JobAdvertisementsController(){
        jah = new JobAdvertisementsHelper();
        page_offset = 0;
        pageSize = 10 ;
        jobAdvertisementsDBCount = 0;
        pagesTotal = 1;
        currentPage = 1;
        getJobAdvertisements();
        salaryFilter = 'EQUAL';
    }
    public void next(){
        page_offset ++;
        currentPage++;
        getJobAdvertisements();      
    }
    public void previous(){        
        if( page_offset > 0 ){
            page_offset--;
            currentPage--;
            getJobAdvertisements();
        }   
    }
    public void toLastPage(){ 
        page_offset = pagesTotal - 1 ;          
        currentPage = pagesTotal;
        getJobAdvertisements();
    }
    public void toFirstPage(){
        page_offset = 0 ;          
        currentPage = 1;
        getJobAdvertisements();
    }
    public void calculatePagesTotal(){
        if( jobAdvertisementsDBCount/pageSize*pageSize == jobAdvertisementsDBCount && jobAdvertisementsDBCount > 0){ 
                pagesTotal = jobAdvertisementsDBCount/pageSize;            
        }else{  
            pagesTotal = jobAdvertisementsDBCount/pageSize + 1;
        }
    }
    public void getJobAdvertisements(){ 
        try{
            jah.params = formParamsMap();
            jah.statusList = checkedStatuses;
            this.allJAs = jah.selectAllJobAdvertisements();
            this.jobAdvertisementsDBCount = jah.countJobAdvertisements();
            calculatePagesTotal();
        }catch(Task6Exception e){
            System.debug( 'Task6Exception e : ' + e.getMessage() );
            sendError(System.Label.DB_Exception);
        }
    }
    // form Map with parameters for Query 
    public Map <String, String> formParamsMap(){
        Map <String, String> params = new Map <String, String>();
        params.put('pageSize', pageSize + '');
        params.put('page_offset', page_offset + '');
        if( nameFilter !=null) params.put('name', nameFilter );
        if(salaryFilter !='' && salaryFilter !=null && salaryParam != null &&  salaryParam != 0){
            params.put('salary_filter', salaryFilter );
            params.put('salary_param', salaryParam + '' );
        }
        if( orderSort != null && orderSort != '' && orderSort != null ){
            params.put('orderSort', orderSort );
            if( orderType == 'DESC') params.put('orderType', orderType );
        }
        return params;
    }
    public void sendError(String msg){
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, msg));
    }
}