<aura:application extends="force:slds" implements="force:appHostable,flexipage:availableForAllPageTypes,flexipage:availableForRecordHome,force:hasRecordId,forceCommunity:availableForAllPageTypes">
    
    <div class="slds-grid slds-p-top_large">       
        <div class="slds-col slds-size_2-of-12">
            
        </div> 
        <div class="slds-col slds-size_6-of-12 slds-box">
            <c:FilterBar/>
            <div class="row">
                 <c:JobAdvertisementList />
            </div>
            
        </div>
        <div class="slds-col slds-size_2-of-12">
            <div class="row">
                <c:PaginationBlock />
            </div>
        </div>
        <div class="slds-col slds-size_2-of-12">
            
        </div>
    </div>
</aura:application>