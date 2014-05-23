package sceneModule.model.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 物品对象VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class ItemInfoVo
	{
		public var idInPackage:int;	
		public var position:Array;	
		public var stack:int;	//物品可叠数量
		public var isEquiped:Boolean;	//是否装备
		public var itemLevel:int;	
		public var itemId:int;	
		public var bindType:int;	//绑定类型
		public var isBound:Boolean;	
		public var isBoundDesc:String;//是否绑定
		public var sellPrice:int;	
		public var extraAttributeList:ArrayCollection;	
		public var name:String;
		public var from:String;
		public var itemTemplateInfo:Object;//物品的详细信息
		public var professionRequireName:String;	

		public function ItemInfoVo()
		{
		}
	}
}