@isTest
public class Task9ControllerTest {
	@isTest
    public static void Task9ControllerUIValidTest(){
        Integer count = 101;
        List <Job_Advertisement__c> createdJobs = TestDataFactory.createDifferentJobAdvertisements( count );
        Test.startTest();
        Task9Controller tct = new Task9Controller();
        // only 71 row are not archived
        System.assertEquals( 71, tct.ssc.getResultSize() );
        //filter records by name
        tct.setNameFilter('Low');
		tct.refreshSSC();
        System.assertEquals( 31, tct.ssc.getResultSize() );
        
        List <Task9Controller.VacancyWrapper> currentPageJobs =  tct.getJobs();
        System.assertEquals( 10, currentPageJobs.size() );
        // select two records and remove one
        tct.rowIndex = 4;
        tct.doChecked();
        System.assertEquals( 1, tct.getSelectedJobs().size() );
        
        tct.rowIndex = 6;
        tct.doChecked();
        tct.rowIndex = 4;
        tct.doChecked();
        System.assertEquals( '01' , tct.getSelectedSize() );
        tct.setSize(20);
        System.assertEquals( 20 , tct.getSize() );
        
        // remove one selected record
        tct.rowIndex = 0;
        tct.removeChecked();
        System.assertEquals( '0' , tct.getSelectedSize() );
        
        // clear all filers
        tct.refresh();
        System.assertEquals( null , tct.getNameFilter() );
        //filter records by salary range
        tct.salaryFilter = 'MOREOREQUAL';
        tct.salaryParam = 100;
        tct.onSalaryFilterChange();
        for(integer i = 0; i < tct.getSize(); i++){
            tct.rowIndex = i;
            tct.doChecked();
        }
        System.assertEquals( '20' , tct.getSelectedSize() );
        
        //filter records by salary range and name
        tct.setNameFilter('High');
        tct.dateFilter = 'AFTER';
        tct.setPublishedDate(Date.today().addDays(-75));
        System.debug('tct.ssc.getResultSize() ' + tct.ssc.getResultSize());
        System.assertEquals( 15, tct.ssc.getResultSize() );
        System.assertEquals( Date.today().addDays(-75), tct.getPublishedDate() );
        System.assertEquals( 20, tct.getCheckedIDsSize() );
        Test.stopTest();
    }
    @isTest
    public static void cvSavingValidTest(){
        
        Integer count = 101;
        List <Job_Advertisement__c> createdJobs = TestDataFactory.createDifferentJobAdvertisements( count );
        Test.startTest();
        Task9Controller tct = new Task9Controller();
        tct.cvFirstName = 'FirstNameTest';
        tct.cvLastName = 'LastNameTest';
        tct.fileName = 'TestFileName';
        CV__c cv = new CV__c();
        cv.Email__c = 'test@gmail.com';
        cv.Age__c = 25;
        cv.Phone__c = '454545454243';
        cv.Salary__c = 250;
        cv.Additional_info__c = 'Test Info';
        cv.Status__c = 'true';
        tct.selectedJobs = new List <Job_Advertisement__c>{ createdJobs[0], createdJobs[1], createdJobs[2] };
        tct.image = Blob.valueOf('TestData for Image');
        tct.cv = cv ;
        tct.saveCV();
        // save again with the same List of selected Jobs
        tct.cv.Salary__c = 2500 ;
        tct.saveCV();
        Test.stopTest();
    }
    @isTest
    public static void cvSavingInvalidTest(){
        
        Integer count = 5;
        List <Job_Advertisement__c> createdJobs = TestDataFactory.createDifferentJobAdvertisements( count );
        Test.startTest();
        Task9Controller tct = new Task9Controller();
        tct.cvFirstName = 'FirstNameTest';
        tct.cvLastName = 'LastNameTest';
        tct.fileName = 'TestFileName';
        CV__c cv = new CV__c();
        cv.Email__c = 'test@gmail.com';
        cv.Age__c = 25;
        cv.Phone__c = '454545454243';
        cv.Salary__c = 250;
        cv.Additional_info__c = 'Test Info';
        cv.Status__c = 'true';
        tct.selectedJobs = new List <Job_Advertisement__c>{ createdJobs[0], createdJobs[1], createdJobs[2] };

        tct.image = null;
        tct.cv = cv ;
        tct.saveCV();
     
        tct.cv.Email__c = null;
        tct.image = Blob.valueOf('TestData for Image');
        tct.saveCV();
        
        Test.stopTest();
    }
}