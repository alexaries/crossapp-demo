package sceneModule.model.vo.corpsVO
{
	import mx.collections.ArrayCollection;

	/**
	 * 军徽信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class CorpsEmblemInfoVO
	{
		public var corpsFounder:String;//军团创始人
		public var corpsId:int;//军团id
		public var corpsImg:int;//军团图标
		public var createData:String;//创建日期
		public var corpsLevel:int;//军团等级
		public var emblemLevel:int;//军徽等级
		public var corpsChief:String;//军团长
		public var veteranList:ArrayCollection = new ArrayCollection();//元老
		public var staffInfoList:ArrayCollection = new ArrayCollection();//参谋
		public var orderInfoList:ArrayCollection = new ArrayCollection();//议事
		public var technologyList:ArrayCollection = new ArrayCollection();//军团科技
		public function CorpsEmblemInfoVO()
		{
		}
	}
}