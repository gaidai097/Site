    .closeMyModal {
        position: absolute;
        top: 0;
        right: 0;
        width: 35px;
        height: 30px;
        background: #000;
        color: #fff;
        cursor: pointer;
        border: 0;
        transition: all ease-in-out 200ms;
    }
    .closeMyModal:hover {
        transform: scale(1.1);
    }
    .mymask {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(52, 73, 94, 0.5);
        z-index: 50;
        visibility: hidden;
        opacity: 0;
        transition: 0.7s;
    }
    .myModal {
        padding:0.5rem;
        position: fixed;
        top: 10%;
        left: 15%;
        width: 70%;
    	
        min-height: 60%;
        background: #f2fdff;
        z-index: 100;
        visibility: hidden;
        opacity: 0;
        transition: 0.5s ease-out;
        transform: translateY(45px);
    }
    .myModal input[type="text"]{
        border-radius: 0;
    }
    .modal_title{
        margin: 1rem; 
        text-align: center;
    }
    .modal_title{
        margin: 1rem; 
        text-align: center;
    }
    .modal_title h3{
        margin: auto;
    }
    img.preview_img{
        margin-top: 1rem;
        margin-left: 1rem;
        max-height: 7rem;
        max-width: 6rem;
        border: 4px solid #D3D3D3;
        border-radius: 3px;
        display: none;
        position : absolute;
        z-index: 1100;
    }
    input.not-valid, input.not-valid:focus, textarea.not-valid,textarea.not-valid:focus{
        box-shadow: inset 0px 0px 3px 3px rgba(255, 0, 0, 0.5) !important;        
    }
    .activeM {
        visibility: visible;
        opacity: 1;
    }
    .activeM + .myModal {
        visibility: visible;
        opacity: 1;
        transform: translateY(0);
    }
    .center {
        text-align: center;
        margin: 0.3rem auto;
    }
    .validation_message{
    	height: 2rem;
    	color: red;
    	font-size: 0.7rem;
    	font-family: "Arial Verdana", Arial, sans-serif;
    }
    .main_container{
        margin-top : 2rem ;
        margin-bottom : 8rem ;
    }
    .fullsize_input{
        width : 100%;
        height: 100%;           
        border-radius: 0;           
    }
    .zero_padding{
        padding: 0 ;
    }
    .filter_bar{
        border-radius: 0.25rem;        
        border: 1px solid grey;
    }
    input:focus, textarea:focus{
        box-shadow: inset 0px 0px 1px 3px #a3e8ff !important;
    }
    .selected_count  p{
        background-color: #ffc107;
        border-radius: 1.5rem;
        min-width: 2rem;
    }
    .selected_nav >div{  
        text-align:center;
        font-weight: bold;
    }
    .selected_nav >div{
        padding: 0 0.3rem;
        vertical-align:center;
    }
    .standard_cursor{
        cursor:default ;
    }
    .half_padding{
        padding: 0.5rem 0.5rem; 
    }    
    .card:hover{
        -moz-box-shadow: 0 0 12px 5px #99fcd6;
        -webkit-box-shadow: 0 0 12px 5px #99fcd6;
        box-shadow: 0 0 12px 5px #99fcd6;
    }
    .white_font{
        color: white; 
        font-weight: bold;
        transition: transform .2s;        
    }
    .white_font:hover{
        transform: scale(1.1);        
    }
    .card{
        margin: 0.5rem 0;
        transform-style: preserve-3d;
    }
    .card-body{
        background: #e1ffff;
        background: -moz-linear-gradient(-45deg, #e1ffff 0%, #e1ffff 7%, #e1ffff 12%, #e6f8fd 26%, #c8eefb 44%, #bee4f8 71%, #d2e6f4 82%, #d2e6f4 82%);
        background: -webkit-linear-gradient(-45deg, #e1ffff 0%,#e1ffff 7%,#e1ffff 12%,#e6f8fd 26%,#c8eefb 44%,#bee4f8 71%,#d2e6f4 82%,#d2e6f4 82%);
        background: linear-gradient(135deg, #e1ffff 0%,#e1ffff 7%,#e1ffff 12%,#e6f8fd 26%,#c8eefb 44%,#bee4f8 71%,#d2e6f4 82%,#d2e6f4 82%);
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#e1ffff', endColorstr='#d2e6f4',GradientType=1 );
    }
    .card-header p{
        text-align: left;
    }
    .header_button:hover, .header_button{
        text-decoration: none !important;
        color: black;
        font-family: Geneva, Arial, Helvetica, sans-serif;        
    }
    .corner-header {
        vertical-align: middle;
        text-align: center;
        display: table-cell;
    }
    .corner-header div {
        margin-top: 1rem;
        font-size: 2.5rem;
        color: grey;        
    }   
    .header_button i {
        transition-duration: 0.25s;
    }
    .collapsed  i{
        transform: rotate(-180deg);
        transition-duration: 0.25s;
        transition-timing-function: ease;
    }
    .salary_number{
        border: 2px solid grey;
    }
    .alert-dark{
        background-color: white;
    }
    .alert-dark:hover{
        background-color: #f2ffff;
    }
    .alert-dark p{
        margin-bottom: 0.3rem;
        overflow:hidden;
    }
    .clear_filters{
        border-top-right-radius: 3px;
        border-top-left-radius: 3px;
    }
    /* Reset Select */
    .select_pages {
        -webkit-appearance: none;
        -moz-appearance: none;
        -ms-appearance: none;
        appearance: none;
        outline: 0;
        box-shadow: none;
        border: 0 !important;
        background: #33a1b2;
        background-image: none;
    }
    /* Custom Select */
    .select {
        position: relative;
        display: block;
        width: 4rem;
        height: 2rem;
        background: #33a1b2;
        overflow: hidden;
        border-radius: .25em;
    }
    .select_pages {
        height: 100%;
        width: 100%;
        margin: 0;
        padding: 0 0 0 .5em;
        color: white;
        cursor: pointer;
    }
    .select_pages::-ms-expand {
        display: none;
    }        
    /* Arrow */
    .select::after {
        content: '\25BC';
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        padding: 0 0.5rem;
        background: #138496;
        pointer-events: none;
    }
    /* Transition */
    .select:hover::after {
        color: #138496;
    }
    .select::after {
        -webkit-transition: .25s all ease;
        -o-transition: .25s all ease;
        transition: .25s all ease;
    }
    .nav_buttons form{
        padding: 0.25rem;
        display: inline-block;
    }
    #pagination_block{
        height: 10rem;
    	bottom: 3rem;
    	position: fixed;
    }
    .fileType {
        display: block;
        position: relative;
        width: 11rem;
        cursor: pointer;
        border: 0;
        height: 2rem;
        border-radius: 5px;
        outline: 0;
        box-shadow: 0px 17px 10px -10px rgba(0,0,0,0.4);
        transition: all ease-in-out 300ms;
    }
    .fileType:hover{
        
        transform: translate(0px, -2px) scale(1.05);
        box-shadow: 0 15px 6px -6px grey;
    }
    .fileType:hover:after {
        background: blue;           
    }
    .fileType:after {
        transition: 200ms all ease;
        border-bottom: 3px solid rgba(0,0,0,.2);
        background: #95B9D9;             
        text-shadow: 0 2px 0 rgba(0,0,0,.2);
        color: #fff;
        font-size: 20px;
        text-align: center;
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: block;
        content: 'Select';
        line-height: 2rem;
    }
    .scrollMore{
        text-align: center;
        height: 2rem;
        margin: 1rem;
        width: 100%;      
        margin-top:20px;
        color: #8dfce2;
        display: none;
        cursor:pointer;
    }
    .scrollMore:hover{
        margin-top:20px;
        color: #8dfce2;
        display: none;
        cursor:pointer;
    }
    .scrollMore i:hover{
        color: yellow;
    }
    .animation-down {
        transform-origin: 50% 20%;
        animation: down .7s linear;
    } 
    .animation-up {
        transform-origin: 50% 40%;
        animation: up .7s linear;
    }    
    @keyframes down {
        0% {
            transform: rotateX(0);
        }
   		
        100% {
            transform: rotateX(0);
            transform: rotateY(0);
        }
    }
    @keyframes up {
         0% {
            transform: rotateX(0);
        }
        
        100% {
            transform: rotateX(0);
            transform: rotateY(0);
        }
    }
    #selected_block{
        min-height: 20rem;
        max-height: 30rem;
        overflow-y: auto;
    }
    #side_bar_block{
        min-height: 45rem;
    }
    .custom_alert{
        width:30%;
        margin-left: 5px;
        float: right;
        position: fixed !important;
        right: 1rem;
        bottom: 1rem;
        min-height:50px;
        background: rgb(254,252,234); /* Old browsers */
        background: -moz-linear-gradient(-45deg, rgba(254,200,200,1) 0%, rgba(255,214,119,1) 28%, rgba(252,100,20,1) 49%, rgba(254,190,150,1) 78%, rgba(241,222,53,1) 100%); /* FF3.6-15 */
        background: -webkit-gradient(linear, left top, right bottom, color-stop(0%,rgba(254,252,234,1)), color-stop(28%,rgba(255,214,119,1)), color-stop(49%,rgba(252,229,20,1)), color-stop(78%,rgba(254,252,234,1)), color-stop(100%,rgba(241,222,53,1))); /* Chrome4-9,Safari4-5 */
        background: -webkit-linear-gradient(-45deg, rgba(254,252,234,1) 0%,rgba(255,214,119,1) 28%,rgba(252,150,20,1) 49%,rgba(254,252,234,1) 78%,rgba(241,222,53,1) 100%); /* Chrome10-25,Safari5.1-6 */
        background: -o-linear-gradient(-45deg, rgba(254,252,234,1) 0%,rgba(255,150,119,1) 28%,rgba(252,100,20,1) 49%,rgba(254,252,234,1) 78%,rgba(241,222,53,1) 100%); /* Opera 11.10-11.50 */
        background: -ms-linear-gradient(-45deg, rgba(254,252,234,1) 0%,rgba(255,180,100,1) 28%,rgba(252,229,20,1) 49%,rgba(254,252,234,1) 78%,rgba(241,222,53,1) 100%); /* IE10 preview */
        background: linear-gradient(135deg, rgba(254,252,234,1) 0%,rgba(255,214,119,1) 28%,rgba(252,70,20,1) 49%,rgba(254,252,234,1) 78%,rgba(241,222,53,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fefcea', endColorstr='#f1de35',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */;
        padding: 0;
        z-index: 1200;
        border-radius: 8px;
        border-style: solid;
        border-width: 1px;
        border-color: #D3CFB0;
        opacity: 0.9;
        display: none;
    }
    .custom_alert_body{
        font-family: Calibri, Candara, Segoe, 'Segoe UI', Optima, Arial, sans-serif;
        color: #373522;
        line-height: 1.2em;
        width: 92%;
        margin:10px;
    }
    .custom_alert_title{
        font-weight: 800;
        font-size: 1.3em;
    }
    .custom_alert_close{
        right: 5px;
        top: 3px;
        color: #504C2C ;
        position: absolute;
        cursor: pointer;
        transition: all .3s ease-in-out;
    }
    .custom_alert_close:hover{
        transform: scale(1.4);
    }
