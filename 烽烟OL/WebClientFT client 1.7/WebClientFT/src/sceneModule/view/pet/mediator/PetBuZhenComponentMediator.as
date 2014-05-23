package sceneModule.view.pet.mediator
{
	import flash.geom.Point;
	
	import model.SystemDataModel;
	
	import mx.events.CollectionEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.pet.view.PetBuZhenComponent;
	import sceneModule.view.pet.view.PetMatrixItemRender;
	import sceneModule.view.pet.vo.PetMatrixTitleInfoVO;

	public class PetBuZhenComponentMediator extends Mediator
	{
		[Inject]
		public var comp:PetBuZhenComponent;
		public function PetBuZhenComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			SystemDataModel.petMatrixList.matrixTitleList.addEventListener(CollectionEvent.COLLECTION_CHANGE,onMatrixListDataChange);
			onSettingMatrix();
		}
		
		private function onMatrixListDataChange(evt:CollectionEvent):void{
			onSettingMatrix();
		}
		
		
		/**
		 * 设置阵法信息
		 */
		private var tileArrCache:Array = new Array();
		private function onSettingMatrix():void{
			//把宠物列表中宠物信息中的是否在阵法的标志位置为false
			//把阵法中的宠物先移除掉
			var c_l:int = tileArrCache.length;
			for(var c_i:int=0;c_i<c_l;c_i++){
				comp.removeElement(tileArrCache[c_i]);
			}
			//添加当前阵法的宠物
			tileArrCache = new Array();
			var l:int = SystemDataModel.petMatrixList.matrixTitleList.length;
			for(var i:int=0;i<l;i++){
				var tileInfoVo:PetMatrixTitleInfoVO = SystemDataModel.petMatrixList.matrixTitleList[i] as PetMatrixTitleInfoVO;
				var petMatrixItemRender:PetMatrixItemRender = new PetMatrixItemRender();
				petMatrixItemRender.dataInfo = tileInfoVo;
				//如果存在宠物则把宠物列表中该宠物的flag设置为true
//				if(tileInfoVo.hasPet){
//				}
				var index:int = tileInfoVo.titlePos;
				var xindex:int = index % 3;
				var yindex:int = index / 3;
				//var pos:Point = comp.posArr[tileInfoVo.titlePos] as Point;
				var pos:Point = new Point(129 + xindex * 102, 48 + yindex * 101);
				petMatrixItemRender.x = pos.x;
				petMatrixItemRender.y = pos.y;
				comp.addElement(petMatrixItemRender);
				tileArrCache.push(petMatrixItemRender);
			}
		}
	}
}