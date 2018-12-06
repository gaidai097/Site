public class PageListWrapper {
    public List<JobAdvertisementsWrapper> jobAdvertisements {get;set;}
    public Integer count;
    public PageListWrapper(Integer count ,List<JobAdvertisementsWrapper> jobAdvertisements){
        this.count = count;
        this.jobAdvertisements = jobAdvertisements;
    }
}