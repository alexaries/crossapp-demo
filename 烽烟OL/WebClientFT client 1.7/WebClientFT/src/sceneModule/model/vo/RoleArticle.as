package sceneModule.model.vo
{
	import mx.collections.ArrayCollection;
	/**
	 * 角色获得的物品奖励
	 * 
	 * 
	 */	
	[Bindable]
	public class RoleArticle
	{
		public function RoleArticle()
		{	
		}
		public var id:int;	//物品的实例id
		public var templateId:int;//物品的模板id
		public var idInPackage:int;//物品在包裹中的id
		public var selfExtraAttribute:ArrayCollection=new ArrayCollection();//物品的自身属性
		public var dropExtraAttribute:ArrayCollection=new ArrayCollection();//物品的掉落属性
		public var quality:int;//物品的品质等级
		public var starLevel:int;//物品的星级
		public var stack:int;//物品的层叠数
		public var type:int;
		public var icon:int;
	}
}