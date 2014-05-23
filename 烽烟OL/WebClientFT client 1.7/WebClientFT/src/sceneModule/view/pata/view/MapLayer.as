package sceneModule.view.pata.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import model.SystemDataModel;
	
	import resource.AssetCenter;

	public class MapLayer extends Sprite
	{
		private var _bg_bitmap:Bitmap;
		
		private var pointArr:Array = [new Point(93,230),new Point(-101,131),new Point(93,35),new Point(-101,-60)];
		public function MapLayer()
		{
			_bg_bitmap = new Bitmap();
			this.addChild(_bg_bitmap);
		}
		
		public function set bg_bitmap(value:BitmapData):void{
			_bg_bitmap.bitmapData = value;
		}
		
		/**
		 * 添加楼层到地图层上 
		 * @param startLev 开始楼层
		 * @param maxLev 最大楼层
		 * 
		 */		
		public function onAddBlockToMapLayer(startLev:int,maxLev:int):void{
			if(maxLev - startLev <2){
				//楼层从
				onAddBlock(startLev - (2 - (maxLev-startLev)));
			}else{
				onAddBlock(startLev);
			}
		}
		private function onAddBlock(s:int):void{
			for(var i:int=0;i<4;i++){
				var blockLayer:BlockLayer = new BlockLayer();
				blockLayer.blockLev = s + i;
				if(SystemDataModel.panPaInfoVo.curLev>(s + i)){
					//已通过
					blockLayer.bg_bitmap = AssetCenter.getInstance().get_img_form_pacakge("ui_pata","open_img");
				}else{
					//未通过
					blockLayer.bg_bitmap = AssetCenter.getInstance().get_img_form_pacakge("ui_pata","clock_img");
				}
				blockLayer.x = pointArr[i].x;
				blockLayer.y = pointArr[i].y;
				this.addChild(blockLayer);
			}
		}
			
	}
}