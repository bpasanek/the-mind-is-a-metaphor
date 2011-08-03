$(function(){
    //perPageSelect
    $('#perPageSelect').change(function(){
        $('#resultsForm').submit();
    })

	var searchbox = $("#q");
	var searchboxDefault = "Search...";
	
	/** swap classes in the search box */
	searchbox.focus(function(e){
		$(this).addClass("active");	
		if($(this).attr("value") == searchboxDefault){
			$(this).attr("value", "");
		}
	});
	
	searchbox.blur(function(e){
		$(this).removeClass("active");
		if($(this).attr("value") == ""){
			$(this).attr("value", searchboxDefault);
		}
	});
	
	$("#q").blur();
	
    /*$('.result *').tooltip({
		track: true,
		delay: 0,
		showURL: false,
		opacity: 1,
		extraClass: "pretty", 
		showBody: " - "
	});*/
	
	var orginal_text = $('.result a.load_details').html();
	$('.result a.load_details').click(function(){
	    var a = $(this);
	    var c = $('div.details_container', a.parent());
	    if(a.hasClass('expanded')){
	        a.removeClass('expanded');
	        a.addClass('contracted');
	    }else if ( a.hasClass('contracted') ){
    	    a.removeClass('contracted');
    	    a.addClass('expanded');
    	}else{
    	    a.addClass('expanded');
    	}
	    $.get(a.attr('href'), function(data){
	        if( ! a.hasClass('loaded') ){
    	        a.addClass('loaded')
    	        c.hide().html(data);
    	    }
	        c.toggle('fast');
	        a.hasClass('expanded') ? a.html('hide preview') : a.html(orginal_text);
	    })
	    return false;
	})
	
})