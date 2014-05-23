function startKeepFrameRate()
{
	setInterval(callSWF, 50);
}
function callSWF()
{
	var swf=document.getElementById("WebClient");
	if(swf)
		swf.keepFrameRate();
}