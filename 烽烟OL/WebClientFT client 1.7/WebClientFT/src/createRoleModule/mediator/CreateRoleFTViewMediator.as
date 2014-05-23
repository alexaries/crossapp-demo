package createRoleModule.mediator
{
	import createRoleModule.view.CreateRoleFTView;
	import createRoleModule.view.RoleBaseSprite;
	import createRoleModule.view.RoleInfoComponent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	
	import util.CommonTools;

	public class CreateRoleFTViewMediator extends Mediator
	{
		[Inject]
		public var comp:CreateRoleFTView;
		
		private var roleInfo:Array=[{x:658,y:142,type:1},{x:343,y:81,type:2},{x:-55,y:178,type:3},{x:506,y:127,type:4},{x:204,y:181,type:5},{x:111,y:75,type:6}];
		public function CreateRoleFTViewMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			AssetCenter.getInstance().load_package("ui_nrole", showInfo, null, true);
		}
		
		private function showInfo():void{
			CommonTools.make_bitmap(comp.bg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_nrole","create_bg");
			for(var i:int=0;i<6;i++){
				var roleBaseSprite:RoleBaseSprite = new RoleBaseSprite();
				comp.roleLayer.addChild(roleBaseSprite);
				var nStr:String='roleRes'+(i+1).toString();
				roleBaseSprite.mc_sou = AssetCenter.getInstance().get_mc_form_pacakge('ui_nrole', nStr);
				var npStr:String = 'roleResPos'+(i+1).toString();
				roleBaseSprite.bitmap_sou = AssetCenter.getInstance().get_img_form_pacakge("ui_nrole",npStr);
				roleBaseSprite.x = roleInfo[i].x;
				roleBaseSprite.y = roleInfo[i].y;
				roleBaseSprite.fun_type = roleInfo[i].type;
				roleBaseSprite.addEventListener(MouseEvent.CLICK,onMouseClick);
			}
		}
		
		private function onMouseClick(evt:MouseEvent):void{
			var sprite:RoleBaseSprite = evt.currentTarget as RoleBaseSprite;
			var roleInfoComp:RoleInfoComponent = new RoleInfoComponent();
			var nStr:String='roleRes'+sprite.fun_type.toString();
			roleInfoComp.addMovieClipToSprite(AssetCenter.getInstance().get_mc_form_pacakge('ui_nrole', nStr));
			var npStr:String = 'roleInfoRes'+sprite.fun_type.toString();
			comp.roleLayer.addChild(roleInfoComp);
			roleInfoComp.workType = sprite.fun_type;
			CommonTools.make_bitmap(roleInfoComp.bg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_nrole",'roleInfo_bg');
			CommonTools.make_bitmap(roleInfoComp.infoBg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_nrole",npStr);
			var roleImgStr:String = 'roleEffRes'+sprite.fun_type.toString();;
			CommonTools.make_bitmap(roleInfoComp.roleImg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_nrole",roleImgStr);
			roleInfoComp.cancel.addEventListener(MouseEvent.CLICK,function onRemoveLayer():void{
				roleInfoComp.cancel.removeEventListener(MouseEvent.CLICK,onRemoveLayer);
				roleInfoComp.roleLayer.removeChildAt(0);
				roleInfoComp.bg.source = null;
				roleInfoComp.infoBg.source = null;
				comp.roleLayer.removeChild(roleInfoComp);
			});
		}
		
		}
}