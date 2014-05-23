package sceneModule.model.rvo
{
	import flash.geom.Point;

	/**
	 * NPC数据结构 
	 * @author mutou
	 * 
	 */	
	public class RNpcVo
	{
		public function RNpcVo()
		{
		}
		public var id:int;//NPC id
		public var name:String;//NPC name
		public var position:Point;//NPC position
		public var professionType:int;//NPC type
		public var functionType:int=1;//功能类型，用来区分商店，军团，铁匠铺等
		
		public var isMySelf:Boolean = false;//
		
	}
}