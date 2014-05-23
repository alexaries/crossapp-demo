package sceneModule.model.vo.itemsVo
{
	import mx.collections.ArrayCollection;

	/**
	 * 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class ExtraAttributeVo
	{
		public var name:String;
		public var script:String;
		public var level:int;
		public var effects:String;
		public var type:int;
		public var id :int;
		public var attributeEffects:ArrayCollection = new ArrayCollection();//AttributeEffectVo
		public function ExtraAttributeVo()
		{
		}
	}
}