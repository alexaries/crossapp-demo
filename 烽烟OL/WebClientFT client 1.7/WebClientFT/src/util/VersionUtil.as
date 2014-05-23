package util
{
	import flash.display.Sprite;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.ByteArray;

	/**
	 * 网上找到的版本管理内容。
	 */
	public class VersionUtil
	{
		public static function setRightMenu(xml:Class, o:Sprite, baseString:String):void
		{
			var ba:ByteArray=new xml as ByteArray;
			var vxml:XML=new XML(ba.readUTFBytes(ba.length));

			baseString=baseString.replace("@build", vxml.build.@count);
			baseString=baseString.replace("@release", vxml.release.@count);

			o.contextMenu=o.contextMenu || new ContextMenu();
			o.contextMenu.hideBuiltInItems();
			o.contextMenu.customItems.push(new ContextMenuItem(baseString, false, false));
		}
		public static function setRightMenuByDev(p:Sprite,verStr:String):void{
			p.contextMenu=p.contextMenu || new ContextMenu();
			p.contextMenu.hideBuiltInItems();
			p.contextMenu.customItems.push(new ContextMenuItem(verStr, false, false));
		}
	}
}