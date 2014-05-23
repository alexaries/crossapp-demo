package sceneModule.model.vo.groupVo
{
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;

	/**
	 * 阵法信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class MatrixInfoVo
	{
		public var matrixName:String;//阵法名称
		public var matrixId:int;//阵法id
		public var matrixEnable:Boolean;//阵法是否启用
		public var matrixEffectDes:String;//阵法效果描述
		public var matrixMember:ArrayCollection = new ArrayCollection();//阵法样式数据集合 MatrixEveryOneInfoVo
		public function MatrixInfoVo()
		{
			
		}
	}
}