function setWebTitle() {
	var obj = agents();
	//设置浏览器标题
	document.title=obj.webTitle;
}
function getInfo(){
	var str = location.search;
	return str;
}
function reUrl(){
	//window.location.href="http://game.sh2.bigzhu.com/s1";
}

function reLogin(){
	//window.location.href="http://sh2.bigzhu.com/";
}

function getCookie(c_name)
{
	if (document.cookie.length>0)
	{ 
		c_start=document.cookie.indexOf(c_name + "=")
		if (c_start!=-1)
		{ 
			c_start=c_start + c_name.length+1 
			c_end=document.cookie.indexOf(";",c_start)
			if (c_end==-1) c_end=document.cookie.length
			return unescape(document.cookie.substring(c_start,c_end))
		} 
	}
	return ""
}
var expdays = 365;
function setCookie(c_name,value,expiredays)
{
	if(expiredays == 0){
		expiredays = expdays;
	}
	var exdate=new Date()
	exdate.setDate(exdate.getDate()+expiredays)
	document.cookie=c_name+ "=" +escape(value)+
		((expiredays==null) ? "" : "; expires="+exdate.toGMTString())
}

//swf的舞台对象配置，用于布局配置
var swfStageObj = new Object;
swfStageObj.lowerLimitWidth = 1000;
swfStageObj.lowerLimitHeight = 400;
//swfStageObj.topLimitWidth = 1250;
swfStageObj.topLimitHeight = 650;

function swfStage() {
	return swfStageObj;
}

//全屏
function resize()
{
	var swfId = "WebClient"+verObj.appVer;
	var fl=document.getElementById(swfId);
	if (fl == null)
	{
		fl=document.getElementById(swfId);//可修改
	}
	//获取窗口宽度
 	if (window.innerWidth)
 	{
   		 winWidth = window.innerWidth;
    }
    else if ((document.body) && (document.body.clientWidth))
    {
    	winWidth = document.body.clientWidth;
    }
    //获取窗口高度
    if (window.innerHeight)
    {
    	winHeight = window.innerHeight;
    }
    else if ((document.body) && (document.body.clientHeight))
    {
    	winHeight = document.body.clientHeight;
    }
    //通过深入Document内部对body进行检测，获取窗口大小
    if (document.documentElement  && document.documentElement.clientHeight && document.documentElement.clientWidth)
    {
    	winHeight = document.documentElement.clientHeight;
    	winWidth = document.documentElement.clientWidth;
    }
    //结果输出至两个文本框
	if (winWidth < swfStage().lowerLimitWidth)
	{
		winWidth = swfStage().lowerLimitWidth;
	}
	//else if (winWidth > swfStage().topLimitWidth)
	//{
		//winWidth = swfStage().topLimitWidth;
	//}
	if (winHeight < swfStage().lowerLimitHeight)
	{
		winHeight = swfStage().lowerLimitHeight;
	}
	else if (winHeight > swfStage().topLimitHeight)
	{
		winHeight = swfStage().topLimitHeight;
	}
	
	fl.width = winWidth;
	fl.height = winHeight;
} 
