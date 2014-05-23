package wordscene.fight {
	import util.Logging;
	import wordscene.WordSceneSprite;

	/**
	 * 一组战斗工作的集合
	 * @author hao
	 */
	public class FightActionGroup
	{
		private var _actions:Array;
		public function FightActionGroup() 
		{
			_actions = [];
		}
		
		public function addAction(action:FightAction):void {
			_actions.push(action);
			Logging.log("添加战斗动作", Logging.o2s(action));
		}

		public function clear():void {
			_actions = [];
			Logging.log("清理战斗动作");
		}
		
		public function playNext(id:int):void {
			Logging.log("检测父id", id, "的子动作");
			var excuteActions:Array = [];
			var newActions:Array = [];
			var len:int = _actions.length;
			for (var i:int = 0; i < len; i++) 
			{
				var curaction:FightAction = _actions[i] as FightAction;
				if (id == curaction.fatherID) {
					//是子动作,添加到执行数组
					excuteActions.push(curaction);
				}
				else {
					//不是子动作,添加到新的动作数组
					newActions.push(curaction);
				}
			}
			_actions = newActions;
			var excuteActionLen:int = excuteActions.length;
			for (var j:int = 0; j < excuteActionLen; j++) 
			{
				var curExcuteAction:FightAction = excuteActions[j] as FightAction;
				WordSceneSprite.getInstance().fightSceneSp.excuteAction(curExcuteAction);
			}
			Logging.log("剩余回合为", _actions);
			if (0 == excuteActionLen && 0 == _actions.length) {
				//检测回到角色回到原始位置
				WordSceneSprite.getInstance().fightSceneSp.checkCharMoveBack();
			}
		}
	}

}