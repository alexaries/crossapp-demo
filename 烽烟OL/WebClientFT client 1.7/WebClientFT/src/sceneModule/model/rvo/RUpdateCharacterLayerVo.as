package sceneModule.model.rvo
{
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	
	import sceneModule.rcommon.RMovieClipRenderer;
	
	public class RUpdateCharacterLayerVo
	{
		public function RUpdateCharacterLayerVo()
		{
		}
		public var posY:int;//要比较的Y坐标
		public var render:SpriteSheetRenderer;//要设置层的显示对象
		public var renderMc:RMovieClipRenderer;//要设置层的显示对象 -- 战斗
	}
}