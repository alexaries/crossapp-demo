package sceneModule.rcommon
{
	import com.pblabs.engine.entity.EntityComponent;
	
	import flash.geom.Point;
	
	public class RSwitchInfoComponent extends EntityComponent
	{
		public function RSwitchInfoComponent()
		{
			super();
		}
		public var id:int;// id
		public var professionType:int;//资源类型，用来做资源显示，与角色的professionType类似
		public var functionType:int;//功能类型，用来判断传送门的作用，如：进入副本，弹出对话框等
	}
}