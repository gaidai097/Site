@isTest
public class JobAdvertisementsControllerTest {
    @isTest
    public static void JobAdvertisementsHelperInvalidTest(){
        
        Test.startTest();
		JobAdvertisementsController jac = new JobAdvertisementsController();
        jac.orderSort = 'WrongField';   
        jac.orderType = 'DESC';
        jac.toFirstPage();
        System.assertEquals(System.Label.DB_Exception,  ApexPages.getMessages()[0].getSummary() );

        Test.stopTest();
    }    
	@isTest
    public static void JobAdvertisementsHelperValidTest(){
        Integer count = 101;
        List <Job_Advertisement__c> createdList = TestDataFactory.createDifferentJobAdvertisements(count);
        Test.startTest();
        JobAdvertisementsController jac = new JobAdvertisementsController();
        // check parameters of starting list
        System.assertEquals( 10, jac.allJAs.size() );
        System.assertEquals( 11, jac.pagesTotal );
        System.assertEquals( 1, jac.currentPage );
        System.assertEquals( 101, jac.jobAdvertisementsDBCount );
        // check parameters after adding status Filter
        jac.setCheckedStatuses(new List<String>{'Active'});       
        jac.toFirstPage();
        
        System.assertEquals( 10, jac.allJAs.size() );
        System.assertEquals( 5, jac.pagesTotal );
        System.assertEquals( 1, jac.currentPage );
        System.assertEquals( 41, jac.jobAdvertisementsDBCount );
        // check second page
        jac.next();
        System.assertEquals( 10, jac.allJAs.size() );
        System.assertEquals( 2, jac.currentPage );
        System.assertEquals( 1, jac.page_offset );
        //check last page
        jac.toLastPage();
        System.assertEquals( 1, jac.allJAs.size() );
        System.assertEquals( 5, jac.currentPage );
        System.assertEquals( 4, jac.page_offset );
        
        // check parameters after changing status Filter
        jac.setCheckedStatuses( new List<String>{'On hold','Archived'} );
        jac.toFirstPage();        
        jac.toLastPage();
        System.assertEquals( 10, jac.allJAs.size() );
        System.assertEquals( 6, jac.currentPage );
        System.assertEquals( 5, jac.page_offset );
        System.assertEquals( 60, jac.jobAdvertisementsDBCount );
        System.assertEquals( 6, jac.pagesTotal );
        System.assertEquals( 2, jac.getCheckedStatuses().size() );
        
        // check parameters after moving to previous page
    	jac.previous();
        System.assertEquals( 10, jac.allJAs.size() );
        System.assertEquals( 5, jac.currentPage );
        System.assertEquals( 4, jac.page_offset );
        
        //filter records by name DESC and add filter by salary
        jac.orderSort = 'name' ;
        jac.orderType = 'DESC' ;
        jac.salaryParam = 90;
        jac.salaryFilter = 'MOREOREQUAL';
        jac.nameFilter = '2';
        jac.onSalaryFilterChange();
        jac.toFirstPage();
        
        System.assertEquals( 6, jac.allJAs.size() );
        System.assertEquals( 1, jac.currentPage );
        System.assertEquals( 0, jac.page_offset );
        System.assertEquals( 6, jac.jobAdvertisementsDBCount );
        System.assertEquals( 1, jac.pagesTotal );
        System.assertEquals( 2, jac.getCheckedStatuses().size() );
        System.assertEquals( 3, jac.getStatusLabels().size() );
        //check different salary ranges
        jac.nameFilter = null;
        
        jac.salaryParam = 90;
        jac.salaryFilter = 'MORE';
        jac.toFirstPage();
        System.assertEquals( 30, jac.jobAdvertisementsDBCount );
        
        jac.setCheckedStatuses( null );
        jac.salaryFilter = 'EQUAL';
        jac.salaryParam = 50;
        jac.toFirstPage();
        System.assertEquals( 31, jac.jobAdvertisementsDBCount );
        
        jac.setCheckedStatuses( null );
        jac.salaryFilter = 'NOTEQUAL';
        jac.salaryParam = 50;
        jac.toFirstPage();
        System.assertEquals( 70, jac.jobAdvertisementsDBCount );
        Test.stopTest();
    }
}