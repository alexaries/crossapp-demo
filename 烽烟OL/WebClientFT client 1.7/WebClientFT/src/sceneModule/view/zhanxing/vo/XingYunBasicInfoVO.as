package sceneModule.view.zhanxing.vo
{
	[Bindable]
	public class XingYunBasicInfoVO
	{
		public var xyId:int;//星运id
		public var type:int;//找图标所需
		public var icon:int;//找图标所需
		public var xyName:String;//星运名称
		public var xyDes:String;//星运描述
		public var price:int;//价格
		
		public var xytemId:int;//星运的模板ID
		public var quality:int;//星运的品质
		public var level:int;//星运的当前等级
		public var exp:int;//星运的当前经验
		public var maxexp:int;//星运的最大经验
		
		public var position:int;//位置
		public function XingYunBasicInfoVO()
		{
		}
	}
}