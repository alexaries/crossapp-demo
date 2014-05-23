package sceneModule.view.popupWin
{
	public interface IPopUpShow
	{
		function show(content:String,titleStr:String=null,ImageUrl:String=null,submitStr:String=null,cancelStr:String=null,submitHandler:Function=null,cancelHandler:Function=null,subargs:Array = null,cancelargs:Array = null):void;
	}
}