package sceneModule.view.Alert.view
{
	import com.greensock.TweenLite;
	
	import managers.UILayerManager;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import util.DelayExcuter;

	public class CrotaCommonAlert
	{
		public function CrotaCommonAlert()
		{
		}
		
		public static var msgArr:Array = [];//存放消息队列
		public static var popUpLayer:UIComponent=UILayerManager.getInstance().alert_layer;
		public static var isMoveFlag:Boolean = false;
		public static function createCrotaBasicAlert(msg:String):void{
			msgArr.push(msg);
			if(!isMoveFlag){
				onStartShow();
			}
//			if(curNum == 0){
//				popUpLayer.addChild(basicAlert);
//				basicAlert.y = 400
//				basicAlert.x = (FlexGlobals.topLevelApplication.width-598)/2;
//				TweenLite.to(basicAlert, 2, {y:125, onComplete:clear_mask, onCompleteParams:[basicAlert]} );
//			}else{
//				new DelayExcuter(300,function(){
//					basicAlert.y = 400
//					basicAlert.x = (FlexGlobals.topLevelApplication.width-598)/2;
//					TweenLite.to(basicAlert, 2, {y:125, onComplete:clear_mask, onCompleteParams:[basicAlert]} );
//					popUpLayer.addChild(basicAlert);
//				},[]);
//			}
		}
		
		public static function onStartShow():void{
			if(msgArr.length>0){
				if(!isMoveFlag)isMoveFlag=true;
				var basicAlert:CrotaBasicAlert = new CrotaBasicAlert();
				basicAlert.l_msg.text = msgArr[0];
				msgArr.shift();
				popUpLayer.addChild(basicAlert);
				basicAlert.y = 400
				basicAlert.x = (FlexGlobals.topLevelApplication.width-598)/2;
				TweenLite.to(basicAlert, 2, {y:125, onComplete:clear_mask, onCompleteParams:[basicAlert]} );
				new DelayExcuter(300,onStartShow,[]);
			}else{
				isMoveFlag = false;
			}
		}
		
		public static  function onStop(tf_sp:CrotaBasicAlert):void {
			new DelayExcuter(1000,onHideFunction,[tf_sp])
		}
		
		public static function onHideFunction(tp_sp:CrotaBasicAlert):void{
			TweenLite.to(tp_sp, 1, {y:125, alpha:0, onComplete:clear_mask, onCompleteParams:[tp_sp]} );
		}
		
		public static  function clear_mask(tf_sp:CrotaBasicAlert):void {
			var layer:UIComponent = UILayerManager.getInstance().alert_layer;
			//layer.removeChild(mask_sp);
			if(layer.contains(tf_sp)){
				layer.removeChild(tf_sp);
			}
			
		}
	}
}