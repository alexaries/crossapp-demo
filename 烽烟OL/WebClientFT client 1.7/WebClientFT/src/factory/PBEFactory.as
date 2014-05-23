package factory
{
	import com.pblabs.animation.Animator;
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.animation.AnimatorType;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.entity.allocateEntity;
	import com.pblabs.rendering2D.*;
	import com.pblabs.rendering2D.BasicSpatialManager2D;
	import com.pblabs.rendering2D.spritesheet.CellCountDivider;
	import com.pblabs.rendering2D.spritesheet.SpriteSheetComponent;
	import com.pblabs.rendering2D.ui.IUITarget;
	import com.pblabs.rendering2D.ui.SceneView;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 * 创建PBE相关组件 
	 * @author Linus
	 * 
	 */	
	public class PBEFactory
	{	
		/**
		 * construction 
		 * 
		 */		
		public function PBEFactory()
		{
		}
		
		/**
		 * 创建场景 
		 * @return 
		 * 
		 */		
		static public function createSceneView(width:Number, height:Number):IUITarget
		{
			var view:SceneView = new SceneView;
			view.name = "SceneDB";
			view.width = width;
			view.height = height;
			return view;
			
		}
	}
}