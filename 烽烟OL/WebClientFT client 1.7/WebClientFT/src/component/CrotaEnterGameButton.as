package component
{
	/**
	 * 进入游戏按钮
	 * @author Yaolx
	 * 
	 */
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.utils.flash_proxy;
	
	import mx.core.mx_internal;
	
	import spark.components.Button;
	
	import style.Skin_CrotaEnterGameButton;

	public class CrotaEnterGameButton extends Button
	{
		public function CrotaEnterGameButton()
		{
			super();
			initButtonStyle();
		}
		private function initButtonStyle():void{
			setStyle("skinClass",Skin_CrotaEnterGameButton);
			setStyle("fontSize",14);
			setStyle("fontWeight","bold");
			setStyle("color","#ffffff");
			setStyle("fontFamily","幼圆");
//			var newFilter:flash.filters.DropShadowFilter = new flash.filters.DropShadowFilter();
//			newFilter.blurX = 0;
//			newFilter.blurY = 0;
//			newFilter.distance = 1;
//			newFilter.angle = 45;
//			newFilter.alpha = 0.5;
//			newFilter.color = 0xffffff;
//			this.filters = [ newFilter ];
		}
		
	}
}