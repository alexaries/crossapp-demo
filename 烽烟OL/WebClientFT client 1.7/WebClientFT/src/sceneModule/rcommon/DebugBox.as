package sceneModule.rcommon
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.IEntityComponent;
	
	import model.SystemDataModel;
	
	import sceneModule.rcommand.debug.MyBox2DDebugComponent;
	
	public class DebugBox extends EntityComponent
	{
		public function DebugBox()
		{
			super();
		}
		public function c():void
		{
			if(PBE.nameManager.lookup("MyBox2DDebug") == null)
			{
				
				var entity:IEntity = PBE.allocateEntity();
				entity.initialize("MyBox2DDebug");
				
				var myBox2DDebugComponent:MyBox2DDebugComponent = new MyBox2DDebugComponent();
				myBox2DDebugComponent.spatialManager = SceneHelper.getInstance().mySpatialManager
				myBox2DDebugComponent.scene = SceneHelper.getInstance().myScene;
				myBox2DDebugComponent.layerIndex = 999;
				
				entity.addComponent(myBox2DDebugComponent, "Debug");
				entity.owningGroup = PBE.rootGroup;
			}
		}
		public function d():void
		{
			
			var ent:IEntity = PBE.nameManager.lookup("MyBox2DDebug");
			if(ent)
			{
				ent.destroy();
				
			}
		}
		public function e():void{
			Logger.print(null,String(SystemDataModel.roleInfo.exp)+"/"+String(SystemDataModel.roleInfo.maxExp));
		}
	}
}