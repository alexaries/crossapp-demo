package sceneModule.view.tavern.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 魔兽酒馆
	 *
	 */
	[Bindable]
	public class Schedule
	{
		public var type:int; //宠物类型
		public var icon:int; //宠物id
		public var Skill:String; //技能
		public var Texing:String; //特性
		public var Liliang:int; //力量
		public var Naili:int; //耐力
		public var Zhili:int; //智力
		public var Mingjie:int; //敏捷
		public var Dengji:int; //等级
		public var Hp:int; //生命
		public var Name:String; //名字
		
		public function Schedule()
		{
		}
	}
}
