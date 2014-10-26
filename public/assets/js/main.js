//图片轮播
$(function(){
	show(".num > li",".scroll",".slider");//首页大图轮播
})


function show(nu,sc,slider){
	var len = $(nu).length;
	var index = 1;
	var imgHeight = $(sc).height();
	

	var MyTime = setInterval(change, 3000);

	$(sc).hover(
		function(){
			if(MyTime){clearInterval(MyTime);}
		},
		function(){MyTime = setInterval(change, 3000);}
	);
	
	function change(){
		$(slider).stop(true,false).animate({top : -imgHeight*index},800);
	   	$(nu).eq(index).addClass("on").siblings().removeClass("on");
		
	   	index++;
	   	if(index==len){index=0;}
	}
	
	
	$(nu).mouseover(function(){
	   	index = $(nu).index(this);
	   
	  	$(slider).stop(true,false).animate({top : -imgHeight*index},800);
	   	$(nu).eq(index).addClass("on").siblings().removeClass("on");
	});

}
// 公告选项卡
$(function(){
	$(".notice_body ul").not(":first").hide();
	$(".notice_head li").unbind("click").bind("click", function(){
		var index = $(".notice_head li").index( $(this) );
		$(".notice_body ul").eq(index).siblings(".notice_body ul").hide().end().fadeIn(300);
   });
});

//schedule竞赛日程 表格奇数偶数变色
$(function(){
	$(".schedule > table > tbody > tr:even").addClass("orange_font");
	$(".competition_con > table > tbody > tr:odd").css("background","#f0f0f0");
})

//搜索input
//人物信息、编写文章默认值
function focusBlur(e){
	$(e).focus(function(){
		var thisVal = $(this).val();
		if(thisVal == this.defaultValue){
			$(this).val('');
		}	
	})	
	$(e).blur(function(){
		var thisVal = $(this).val();
		if(thisVal == ''){
			$(this).val(this.defaultValue);
		}	
	})	
}

$(function(){
	focusBlur('.search input');//search input默认值
})

//排行榜5  6 横向滑动条
$(function(){
	
	var len5 = $(".cc_table_right table thead th").length;
	$(".cc_table_right table").css("width",len5*100);
	
	var len6 = $(".ccs_table table").length;
	$(".ccs_table").css("width",len6*300);
})



