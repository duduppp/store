<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>远元集团</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="远元集团">
<meta name="keywords" content="郑远元,远元集团">
<meta name="description" content="郑远元,远元集团 官网">
<link href="favicon.ico" type="image/x-icon" rel="icon">
<link href="favicon.ico" type="image/x-icon" rel="shortcut icon">
<script type="text/javascript" src="<%=basePath %>static/resource/assert/js/html5.js"></script>
<link href="<%=basePath %>static/resource/assert/css/style.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath %>static/resource/assert/css/subpage.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/resource/assert/css/jquery.vm-carousel.css">
<style type="text/css">
  .vmc-centered .vmc_active .imgtitle { transform: scale(2.83,1.2);}
  .vmc-centered .vmc_active .centerImg {top:-125px;  }
  .shake {
		display: inline-block;
		cursor:pointer;
		-webkit-transform-origin: center center;
		-ms-transform-origin: center center;
		transform-origin: center center;
	}
  .shake:hover{
	  transform: scale(1.3,1.3);
}  

</style>
<script type="text/javascript" src="<%=basePath %>static/resource/assert/js/html5.js"></script>
<script type="text/javascript" src="<%=basePath %>static/resource/assert/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/resource/assert/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/resource/assert/js/common.js"></script>
<script type="text/javascript" src="<%=basePath %>static/resource/assert/js/jquery.SuperSlide.js"></script>
<script src="<%=basePath %>static/resource/assert/js/modernizr.js"></script>
   
 
<script>

	var CATALOG_NAME='${yyNews.CATALOG_NAME}';
	var  SUBDIRECTORY_NAME='${yyNews.SUBDIRECTORY_NAME }';
	//孙子目录
	var  SUNCATALOGUE_NAME='${yyNews.SUNCATALOGUE_NAME }';
	$(document).ready(function (e) {
		
		var str='${NavigatList}';
		var NavigatList = $.parseJSON(str); 
		var url='';
		var nagdivStr="";
	 
		nagdivStr="<span style='color:#f00;font-size:16px;'>"+CATALOG_NAME+"><a style='cursor:pointer;' onclick=\"";
		nagdivStr+="openPage('<%=basePath %>newsData.do?CATALOG_NAME="+
					CATALOG_NAME+"&SUBDIRECTORY_NAME="+SUBDIRECTORY_NAME+"&SUNCATALOGUE_NAME="+SUNCATALOGUE_NAME+"')\" >"+SUBDIRECTORY_NAME+"</a> ";
		
		 if(SUNCATALOGUE_NAME!=''){
			 nagdivStr+=" <a style='cursor:pointer;' onclick=\"openPage('<%=basePath %>newsData.do?CATALOG_NAME="+
				CATALOG_NAME+"&SUBDIRECTORY_NAME="+SUBDIRECTORY_NAME+"&SUNCATALOGUE_NAME="+SUNCATALOGUE_NAME+"')\" > >"+SUNCATALOGUE_NAME+"</a> ";
			}
		 nagdivStr+="</span>";
		$("#nagdivID").append(nagdivStr);
		for(var i in NavigatList){
			
			if(SUNCATALOGUE_NAME==''){
				if(NavigatList[i].NAME==SUBDIRECTORY_NAME){
					 url+='<a style="color:white;background-color: white;background-color: #f00;" ';
				}else{
					 url+='<a ';
				}
				
				if(NavigatList[i].NAME==""){
					 url+=' href="javascript:void(0);">'+NavigatList[i].NAME+'</a>';
				}else{
					  url+='onclick="openPage(\'<%=basePath %>newsData.do?CATALOG_NAME='+CATALOG_NAME+'&SUBDIRECTORY_NAME='+NavigatList[i].NAME+'&SUNCATALOGUE_NAME='+SUNCATALOGUE_NAME+'\')">'+NavigatList[i].NAME+'</a>';
				}
			}else{
				
				if(NavigatList[i].NAME==SUNCATALOGUE_NAME){
					 url+='<a style="color:white;background-color: white;background-color: #f00;" ';
				}else{
					 url+='<a ';
				}
				
				if(NavigatList[i].NAME==""){
					 url+=' href="javascript:void(0);">'+NavigatList[i].NAME+'</a>';
				}else{
					  url+='onclick="openPage(\'<%=basePath %>newsData.do?CATALOG_NAME='+CATALOG_NAME+'&SUBDIRECTORY_NAME='+SUBDIRECTORY_NAME+'&SUNCATALOGUE_NAME='+NavigatList[i].NAME+'\')">'+NavigatList[i].NAME+'</a>';
				}
			}
		} 
		
		$("#rightMenua").append(url); 
		var $li = $('#tab li');
		var $ul = $('#content ul');
		$li.mouseover(function(){
			var $this = $(this);
			var $t = $this.index();
			$li.removeClass();
			$this.addClass('current');
			$ul.css('display','none');
			$ul.eq($t).css('display','block');
		});	
	});
	
	function setHomePage(obj) {
	 
        var aUrls = document.URL.split("/");
        var vDomainName = "http://" + aUrls[2] + "/";
        try {
        	
            obj.style.behavior = "url(#default#homepage)";        
            obj.setHomePage(vDomainName);
        } catch (e) {
            if (window.netscape) {
                try {
                    netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                }catch (e) {
                    alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将[signed.applets.codebase_principal_support]设置为'true'");
                } 
                var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                prefs.setCharPref('browser.startup.homepage', vDomainName);
            }
        }
        if (window.netscape) alert("设置首页成功！");
        return false;
    }
	
    //加入收藏函数
    function addFavorite(obj) {
        var aUrls = document.URL.split("/");
        var vDomainName = "http://" + aUrls[2] + "/";
        var description = obj.title;
        try {//IE
            window.external.AddFavorite(vDomainName, description);
        } catch (e) {//Firefox
        	 try {
        		 window.sidebar.addPanel(description, vDomainName, "");
        	 }catch (e) {
        			if (/Opera/.test(window.navigator.userAgent)) { // Opera
        				obj.rel = "sidebar";
        				obj.href = url;
        				return true;
        			}
        	 }
        }
        return false; //阻止a标签继续执行
    }
 
     function moveMenu(aid,divid,menuxialaid){
    	
    	 if(aid=="aid0"){
    		 $(".navigationlist a").css({
        		 "background":"#ffffff",
        		 "color":"#000000"
        	 });
    		 $(".menuxiala").hide();
    		 $("#showpageid").css({
        		 "background":"#f00",
        		 "color":"#ffffff"
        	 });
    		 
    	 }else{
    		 var offset=$("#"+aid).position();
        	 var divwidth= $("#"+divid).width()+30;
        	 var mwidth=offset.left;
        	 var mtop=offset.top+100;
        	 
    		 $(".navigationlist a").css({
        		 "background":"#ffffff",
        		 "color":"#000000"
        	 });
        	 
        	 $("#"+aid).css({
        		 "background":"#f00",
        		 "color":"#ffffff"
        	 });
        	 
        	 $(".menuxiala").hide();
         
        	 $("#"+menuxialaid).css({
        		 "position":"absolute",
        		 "left":mwidth,
        		  top:mtop
        		 
        	 }).show();
        		$("#"+divid).show();
    	 }
     }
     
     function outMenu(id){
    	 
    	// $(".menuxiala").hide();
     }
 
     function submoveMenu(aid,subid){
    
    	 
    	 $(".navigationlist a").css({
    		 "background":"#ffffff",
    		 "color":"#000000"
    	 });
    	 
    	 $("#"+aid).css({
    		 "background":"#f00",
    		 "color":"#ffffff"
    	 });
    	 $("#"+subid).show();  
     }
     
     function suboutMenu(menuxialaid){
    	 
    	  $("#"+menuxialaid).hide();  
     }
 
     

</script>
</head>

<body >

	<!--顶部 开始-->
	
		<div style="height:31px;background-color: red; color:white;" >
		<div class="mdhead">
		<div class="lhead">
		<span>
			欢迎来远元集团。客服热线：400-029-0303
			<span style="width: 350px;">&nbsp;</span>&nbsp;&nbsp;
		 </span> 
		
	</div>

		 <div class="rhead">
	<!--      <ul><li><a>关注我们</a></li><li><a>进度查询</a></li><li><a>售后工单</a></li></ul> -->
			<a href="javascript:void(0)" onclick="setHomePage(this);" style="margin-right:10px;cursor: pointer;" >设为首页</a>|	&nbsp;&nbsp;
			 
			<a href="javascript:void(0)" onclick="addFavorite(this);" style="margin-right:10px;cursor: pointer;">加入收藏</a>|	&nbsp;&nbsp;
			
			<a href="http://wpa.qq.com/msgrd?v=3&amp;uin=1271876110&amp;site=qq&amp;menu=yes"  style="margin-right:10px;cursor: pointer;" >在线咨询 </a> 
		</div>
	</div>
	</div> 
	<div class="clr">
</div>

	<!--顶部 结束-->
	<!--Logo 开始-->

	<div id="logo_main">
		<div id="logo">
			<!--网站Logo 开始-->
			<div class="WebLogo">
				<a href="javascript:void(0)" target="_self">
					<img src="<%=basePath %>static/resource/images1/LOGO.png" height="58"  title="某某公司" alt="某某公司" style="top:30px;margin-top: 20px;" />
				</a>
			</div>
			<!--网站Logo 结束-->
			<!--导航条 开始-->
			<div id="navigation">
				<ul class="navigationlist">
					<li><a id="showpageid" class="headpage" href="<%=basePath %>"  onmousemove="moveMenu('aid0','xiala1','menuxiala1');" >首页</a></li>
				</ul>
			</div>
		 
			<!--导航条 结束-->
		</div>
	</div>
	 
	<!--JS幻灯片 开始-->
	<div id="banner_main">
		<!--幻灯片 开始-->
		   <a href="javascript:void(0);" ><img src="<%=basePath %>static/resource/images1/aboutyy.jpg" width="100%"  /></a>
		<!--幻灯片 结束-->
	</div> 
	   <div class="banner_guide">
			<div id="nagdivID" style="width:1200px;margin:0 auto;    height:40px; line-height:40px;  ">
						
			</div>
			
			<div style="clear: both;height:1px;"></div>
	 
			<div style="margin: 0 auto; width: 1200px;"> 
			
			<div id="dnn_LeftPane" class="content_left">
				<div class="content_left">
			  		<table class="normal" border="0" cellspacing="0" cellpadding="3"  align="center">
					    <tbody>
						<tr>
							<td align="center" class="news-info" style="position:relative;">
								 
									<div class="bhs-container"> 
									</div>
							</td>
						</tr>
						<tr>
					       <td>
				               <div id="article_content" style="margin-top:15px;">
				            	   <div id="Content" style="width:750px;">
									 ${yyNews.CONTENT }
									</div>
								</div>
					    	</td>
					        </tr>
					      </tbody>
					  </table>
				</div>
			</div>
				<div id="dnn_LeftPane" class="content_right">
		        	<div class="about">
		        		<table   style="width: 210px;height: 127px;"  >
		        		  <tr  style="height: 60px;">
			        		  <td style="text-align: center;font-weight:lighter; vertical-align:bottom; font-size: 24px; letter-spacing: 2px; " >
			        		  ${yyNews.CATALOG_NAME}
			        		  </td>
		        		  </tr>
		        			 <tr><td style="height: 15px;" ></td></tr>
		        		  <tr>
		        		  	<td style="text-align: center;vertical-align:top;color: #ae9462;font-weight:lighter;">${NAME_EN }</td>
		        		  </tr> 	
		        		</table>   
		        		  
		        	</div>
					<div class="basic"  id="list1b">
						<div id="rightMenua">
						</div>
						 <div style="height: 60px;width: 200px;"></div>
						 <table style="width: 200px;height:60px;border: 1px solid #d1d2d3;"  >
						 	<tr>
						 		<td rowspan="2" style="text-align: center;" ><img alt="" src="<%=basePath %>/static/resource/images1/icophone.gif"></td>
						 		<td style="line-height: 20px;display:table-cell;vertical-align:bottom;" >客户热线</td>
						 	</tr>
						 	<tr>
						 		<td style="font-size: 18px;color: #f00;font-weight: bold;"> 400-029-0303</td>
						 	</tr>
						  
						 </table>
						 
					</div>
				</div>
			</div>
			
	 	</div>
	 	</div>
 
	<div style="clear: both;height:30px;"></div>
 
	<!--foot-->
	<div id="floor_14_main">
	 <div class="footer">
	    <div class="in">
		        <div class="nag">
		            <div class="e e_first">
		                <label>全国服务热线:<span style="font-size: 14px;">工作时间：9:00-18:00</span> </label>
		                <br/> <br/>
		                 <span style="font-size:40px;color:red;" >400-029-0303</span>
		                
		            </div>
		            <div  style="float: left;width: 280px;line-height:30px; margin-right: 50px;margin-left: 50px;border-right : 1px solid #e6e6e6;  ">
		               
		              A:西安市和平路108号佳腾大厦13层C座</a><br>
		              T:86-029-8751 2455/8751 9238<br>
		                 F:029-8752 9245
		            </div>
		           
		           <div class="code c_first">
		            	<table border="0" >
		            		<tr style="width: 116px;">
		            			<td  rowspan="3" >
		            			  <img style="float: left;margin-right: 6px;" width="90" height="90" src="<%=basePath %>static/resource/images1/guanfang.png" alt="APP下载">
		            			</td>
		            			<td>
		            			  <img style="float: left;" width="26" height="26" src="<%=basePath %>static/resource/images1/weibo-1.png" alt="APP下载">
		            			</td>
		            		</tr> 
		            			<tr>
		            				<td>远官元方</td>
		            		    </tr>
		            		<tr>
		            		<td>集微团信</td>
		            		</tr>
		            	</table>
		            </div>
		            <div class="code c_first">
		               <table style="text-align:right;">
		            		<tr>
		            			<td   rowspan="3">
		            			  <img style="float: left;margin-right: 6px;" width="90" height="90" src="<%=basePath %>static/resource/images1/dingyue.jpg" alt="APP下载">
		            			</td>
		            			<td>
		            			  <img style="float: left;" width="26" height="26" src="<%=basePath %>static/resource/images1/weixin-1.png" alt="APP下载">
		            			</td>
		            		</tr>
		            		<tr>
		            			<td>订远阅元</td>
		            		</tr>
		            		<tr>
		            		<td>号集   团</td>
		            		</tr>
		            		
		            	
		            	 
		            	</table>
		            </div>
		            <div class="code c_first">
		                  <table style="text-align:right;">
		            		<tr>
		            			<td  rowspan="3">
		            			  <img style="float: left;margin-right: 6px;" width="90" height="90" src="<%=basePath %>static/resource/images1/fuwu.jpg" alt="APP下载">
		            			</td>
		            			<td>
		            			  <img style="float: left;" width="26" height="26" src="<%=basePath %>static/resource/images1/weixin-1.png" alt="APP下载">
		            			</td>
		            		</tr>
		            		<tr>
		            			<td>服远务元</td>
		            		</tr>
		            		<tr>
		            		<td>号集团</td>
		            		</tr>
		            		
		            		</tr>
		            	</table>
		            </div>
		            
		            <div class="clear"></div>
		        </div>
	      </div>
	   </div>
	</div>
	<!--第五行频道 结束-->
	<!-- 友情链接 开始-->
	<!--div id="link_main"></div-->
	<!-- 友情链接 结束-->
	<!-- 底部版权 开始-->
	<div id="copyright_main">
		<div id="copyright">
			<span><a href="http://www.zhengyuanyuan.com" target="_self">远元集团</a>&nbsp;版权所有&nbsp;2014-2019&nbsp;陕ICP备16019859号&nbsp;</span>
		</div>
	</div>
  	 <div id="panel" style="" >
		<ul class="icons">
			<li class="up" title="上一页"></li>
			<li class="qq"></li>
			<li class="tel"></li>
			<li class="wx"></li>
			<li class="down" title="下一页"></li>
		</ul> 
		<ul class="info"> 
			<li class="qq" style="display: none;">
			<p>在线沟通，请点我<a href="http://wpa.qq.com/msgrd?v=3&amp;uin=319147570&amp;site=qq&amp;menu=yes" target="_blank">在线咨询</a></p>
			</li>
			<li class="tel" style="display: list-item;">
			<p>咨询热线：<br>400-029-0303<br>客服qq：<br>1271876110</p>
			</li>
			<li class="wx" style="display: none;"> <div class="img">
				<img src="<%=basePath %>static/resource/images1/guanfang.png" width="120" height="120">
			</div> 
			
			</li>
		</ul>  
	</div>
	 <script src="<%=basePath %>static/resource/assert/js/bootstrap.min.js"></script>
	 <script src="<%=basePath %>static/resource/assert/js/jquery.vm-carousel.js"></script>
	 <script src="<%=basePath %>static/resource/assert/js/scolltop.js"></script>

<script type="text/javascript">
	jQuery(function($){
		
		$.ajax({
			type: "POST",
			url: '<%=basePath %>getshowMenuData.do?tm='+new Date().getTime(),
			dataType:'json',
			success: function(res){
				var data=res["dictionList"];
				var str="";
				var wid=790;
				for(var i=0;i<data.length;i++){
					k=i+1;
					str+="<li><a id=\"aid"+k+"\" class=\"subpage\" onmousemove=\"moveMenu('aid"+k+"','xiala"+k+"','menuxiala"+k+"');\" " +
							" onmouseout=\"outMenu('xiala"+k+"');\" href=\"\"  >"+data[i].name+"</a></li>";
				  var sublist=data[i].subDict;
				  var subTitle=""; 
				  var subDIV="<div class=\"menuxiala\" id=\"menuxiala"+k+"\" style=\"width: "+wid+"px;\" onmouseout=\"suboutMenu('menuxiala"+k+"');\">"+
						"<span id=\"xiala"+k+"\" style=\"padding-left:14px;\" onmousemove=\"submoveMenu('aid"+k+"','menuxiala"+k+"')\" >";
					 
				  for(var j=0;j<sublist.length;j++){
					 
					  subTitle+="<a onclick=\"openPage('<%=basePath %>newsData.do?CATALOG_NAME="+data[i].name+"&amp;SUBDIRECTORY_NAME="+sublist[j].name+"&amp;SUNCATALOGUE_NAME=')\">"+sublist[j].name+"</a>&nbsp;&nbsp; &nbsp;   ";
				  }
				  wid=wid-96;  
				  $("#logo").append(subDIV+subTitle+"</span></div>"); 
				}
		
			 
				$(".navigationlist").append(str);
				
		 
			}
		});
		
	   });
	
</script>
 
</body>
</html>
