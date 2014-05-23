package sceneModule.model.rvo
{
	import flash.geom.Point;

	/**
	 * 传送门VO 
	 * @author mutou
	 * 
	 */	
	public class RSwitchVo
	{
		public function RSwitchVo()
		{
		}
		public var id:int;//switch id
		public var name:String;//switch name
		public var position:Point;//switch position
		public var professionType:int;//switch type 资源类型
		public var functionType:int=1;//功能类型，用来判断传送门的作用，如：进入副本，弹出对话框等
		
		public var isMySelf:Boolean = false;//
	}
}