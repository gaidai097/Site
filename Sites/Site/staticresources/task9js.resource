var EMAIL_REGEX = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,4}))$/;

jQuery( document ).ready( function() {
    setValidationListeners();
    jQuery('.sendCV_btn').attr("disabled", "disabled");    
    // var uploadBtn = document.getElementsByClassName("upload_btn")[0] ;        
       
    var lastScrollTop = 0;
    var card ;    
    var inputFile = document.getElementsByClassName("fileType")[0] ;
    var inputfileMsg = jQuery('.fileType').parent().find('span');  
    inputFile.onchange = function(e){        
        let file = this.files[0];             
        if(file.size > 128*1024){
            inputFile.value = "";
            customAlert('File is too big',' Choose only image less then 128Kb !');
        }else{
            var marker = false;            
            var types = ["image/gif","image/jpeg","image/jpg","image/png","image/bmp"];                
            for(var j = 0; j< types.length; j++){
                if(types[j] == file.type){
                    marker = true;
                    break; 
                };
            };
            if(marker){
                
                inputFile.style.display = "none";  
                console.log('file.size ' + file.size);
                var fileSize = file.size;
                if (file.size > 1024 * 1024) {
                    fileSize = (Math.round(file.size*100 / (1024 * 1024)) /100).toString() + ' MB';
                }else {
                    fileSize = (Math.round(file.size  / 1024)  ).toString() + ' KB';
                };
   				var imageName = file.name;
                if(file.name.length >15){
                    imageName = file.name.substring(0, 15) + "...";
                };
                var tmppath = URL.createObjectURL(file);
                var removeLink = "<a class=\"removeFile\" href=\"#\" ><i class='fa fa-times' style='color:red' title='Remove'></i></a>";
				jQuery('#preview').append("<div id=\"imageName\"><strong>" + imageName + "</strong> -<span> "+ fileSize +"<span>&nbsp; &nbsp; "+ removeLink , "<img alt='Your image' class='preview_img' src='"+tmppath+"'></img></div>");
                //uploadBtn.style.display = "block";
                previewForFiles();
                isValid();
                inputfileMsg.hide(100);
                jQuery(document).on("click", ".removeFile", function (e) {
                    e.preventDefault();       
                    console.log('remove');    
                    jQuery("#preview").empty();
                    inputFile.value = "";
                    inputFile.style.display = "block"; 
                    jQuery('.sendCV_btn').attr("disabled", "disabled");
                    inputfileMsg.show(100);
                });
            }else{
                jQuery('.sendCV_btn').attr("disabled", "disabled");
                inputFile.value = "";
                customAlert('Inappropriate type. Choose only image file!'); 
            }                
        }           
    }
    
    var parentHeight = jQuery('#side_bar_block').innerHeight();
    var fontSize = parseInt(window.getComputedStyle(document.getElementsByTagName('html')[0])['fontSize']);
    var paginationBlock = jQuery('#pagination_block');
   
    jQuery(function () {
        jQuery('[data-toggle="tooltip"]').tooltip()
    });
    jQuery(".up").click(function() {
        jQuery('html, body').animate({
            scrollTop: 0
        }, 800);
    });
    jQuery(document).scroll(function () {
        card = jQuery('.card');
        var st = jQuery(this).scrollTop();
        if (st > 50) {
            jQuery('.up').fadeIn();
        } else {
            jQuery('.up').fadeOut();
        };
        if (st > lastScrollTop) {
            card.addClass('animation-down');
            card.one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function(e) {
                card.removeClass('animation-down');
            }); 
        } else {
            card.addClass('animation-up');
            card.one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function(e) {
                card.removeClass('animation-up');
            });
        }
        lastScrollTop = st;
        console.log('roll');
    });        
    jQuery('.select_salary_filter, .sendToServer ').on('click', function(e) {
        e.stopPropagation();
    }); 
    document.getElementById('showMyModal').onclick = showMyModal; 
    document.getElementById("mymask").onclick = closeModal;
    document.getElementsByClassName("closeMyModal")[0].onclick = closeModal;
    function closeModal(){             
        document.getElementById("mymask").className =
            document.getElementById("mymask").className.replace(/\bactiveM\b/,'');
        document.getElementById("myModal").className =
            document.getElementById("myModal").className.replace(/\bactiveM\b/,'');
    };     
    function showMyModal(){
        if(!jQuery('.selectedJobsPanel').is(':empty')){
            document.getElementsByClassName("mymask")[0].className += " activeM";
            document.getElementById("myModal").className += " activeM";
        }else{
            customAlert( "Please, select any position! ", '');
        }
    };
    jQuery('.custom_alert_close').click(function(event) {    
        jQuery(".custom_alert").stop().stop().stop().fadeOut(200);
    });    
});
function closeModal(){ 
    var mask = document.getElementById("mymask");
    var myModal = document.getElementById("myModal");
    mask.className = mask.className.replace(/\bactiveM\b/,'');
    myModal.className = myModal.className.replace(/\bactiveM\b/,'');
}; 
jQuery(document).keyup(function(e) {
  if (e.keyCode == 27) {
    closeModal();
  }
});
var btnToDisable = true; 
function sendToServer(btn, index){   
    if(btnToDisable === true){
        sendByIndex(index);
        
    }
}
function validateCV(){
    validateName();
}
function validateName(){
    console.log( 'name = ' + jQuery('.cvName').val());
}
function previewForFiles () {    
    jQuery("#imageName" ).mouseover(function() {
         console.log('show'  );
        jQuery('.preview_img').show();
    });
    jQuery("#imageName" ).mouseout(function () {
         console.log('hide' );
        jQuery('.preview_img' ).hide();
    });
};
function enableButton(){
    console.log('enableButton ' +  "LastSync: " + Date.now());
    console.log('btnToDisable' , btnToDisable );
    btnToDisable = true;
}
function setValidationListeners(){
    jQuery('.cvEmail').on('focusin blur input',emailValidate);
    jQuery('.cvAge').on('focusin blur input', ageValidate );
    jQuery('.cvPhone').on('focusin blur input', phoneValidate );
    jQuery('.cvSalary').on('focusin blur input',  salaryValidate );
    jQuery('.cvFirstName').on('focusin blur input', firstNameValidate );
    jQuery('.cvLastName').on('focusin blur input', lastNameValidate );
}
function emailValidate(){
    var input = jQuery('.cvEmail');
    var msg = input.parent().find("span");
    if(EMAIL_REGEX.test(input.val()) ){
        input.removeClass('not-valid');
        msg.hide(100);
    }else{
        input.addClass('not-valid');
        msg.show(100);
    }
    isValid();
}
function ageValidate(){
    var input = jQuery('.cvAge');
    var age = parseInt(input.val());
    var msg = input.parent().find("span");
    if( isNaN(age) ){
        input.val('');
        input.addClass('not-valid'); 
        msg.show(100);
    }else if( age < 18 || age > 99){
        input.val(age);
        input.addClass('not-valid'); 
        msg.show(100);
    }else{
        input.val(age);
        input.removeClass('not-valid'); 
        msg.hide(100);
    };
    isValid();
}
function salaryValidate(){
    var input = jQuery('.cvSalary');
    var msg = input.parent().find("span");
    var salary = parseInt(input.val());
    if( isNaN(salary) ){
        input.val('');
        input.addClass('not-valid');  
        msg.show(100);        
    }else if( salary < 10 || salary > 100000){
        input.val(salary);
        input.addClass('not-valid');
        msg.show(100); 
    }else{
        input.val(salary);
        input.removeClass('not-valid'); 
        msg.hide(100); 
    };
    isValid();
}

function phoneValidate(){
    var input = jQuery('.cvPhone');
    var msg = input.parent().find("span");
    var regexPhone = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/ ;
    if(regexPhone.test(input.val()) ){
        input.removeClass('not-valid');
        msg.hide(100);
    }else{
        input.addClass('not-valid');
        msg.show(100);
    } 
    isValid();
}
function firstNameValidate(){
    var input = jQuery('.cvFirstName');
    var firstUp =  input.val().charAt(0).toUpperCase() + input.val().slice(1);
    input.val(firstUp);
    var msg = input.parent().find("span");
    var NAME_REGEX = /^[A-Z]{1}[a-z]{1,12}$/;
    if(NAME_REGEX.test(input.val()) ){
        input.removeClass('not-valid');
        msg.hide(100);
    }else{
        input.addClass('not-valid');
        msg.show(100);
    } 
    isValid();
}
function lastNameValidate(){
    var input = jQuery('.cvLastName');
    var msg = input.parent().find("span");
    var firstUp =  input.val().charAt(0).toUpperCase() + input.val().slice(1);
    input.val(firstUp);
    var NAME_REGEX = /^[A-Z]{1}[a-z]{1,12}$/;
    if(NAME_REGEX.test(input.val()) ){
        input.removeClass('not-valid');
        msg.hide(100);
    }else{
        input.addClass('not-valid');
        msg.show(100);
    } 
    isValid();
}

function isValid() {
    var btn = jQuery('.sendCV_btn');
    if( jQuery('input.not-valid').length>0 || document.getElementsByClassName("fileType")[0].files.length === 0 || jQuery('.cvAge').val() === '' || jQuery('.cvAge').val() === null
       || jQuery('.cvSalary').val() === '' || jQuery('.cvSalary').val() === null || jQuery('.cvEmail').val() === '' || jQuery('.cvEmail').val() === null
       || jQuery('.cvPhone').val() === '' || jQuery('.cvPhone').val() === null || jQuery('.cvFirstName').val() === '' || jQuery('.cvFirstName').val() === null
       || jQuery('.cvLastName').val() === '' || jQuery('.cvLastName').val() === null
      ){
        btn.attr("disabled", "disabled");
    }else {
        btn.removeAttr("disabled");
    }
};
function customAlert (title, content) {
    jQuery('.custom_alert_title').html(title);
    jQuery('.custom_alert_content').html(content);
    if( jQuery(".custom_alert").is(':visible') ){
        jQuery(".custom_alert").stop().stop().stop().stop()
            .fadeOut(100).fadeIn(400).delay(2000).fadeOut(900);
    }else{
        jQuery(".custom_alert").fadeIn(500).delay(4000).fadeOut(1000);
    };
};
