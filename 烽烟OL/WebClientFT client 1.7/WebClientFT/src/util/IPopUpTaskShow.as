package util
{
	public interface IPopUpTaskShow
	{
		function show(content:String,titleStr:String=null,ImageUrl:String=null,submitStr:String=null,cancelStr:String=null,submitHandler:Function=null,cancelHandler:Function=null,randomClickHandler:Function=null,submitBtnVisible:Boolean=false,cancelBtnVisible:Boolean = false,swfVisible:Boolean=true):void;
	}
}