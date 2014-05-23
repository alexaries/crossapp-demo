package sceneModule.model.rvo
{
	import flash.geom.Point;

	/**
	 * 战斗中，单步的敌方VO 
	 * @author mutou
	 * 
	 */	
	public class RBattleEnemyVo
	{
		public var enemyName:String;//敌人名称
		public var enemyLevel:int;//敌人等级
		public var enemyChaId:int // ID
		public var enemyBattleId:int // 战斗ID
		public var enemyProfessionType:int;//敌方形象ID 职业类型,1-战士，2-法师，3-游侠，4-牧师
		public var enemyActionId:int // 动作ID
		public var enemyCounterHitActionId:int;//反击时的动作ID
		public var enemyTxtEffectId:int // 文字效果ID，暴击，闪避，冰冻等
		public var enemyPowerEffectId:int;// power 满后的特效
		
		public var chaEffectId:int; //角色特效ID -- 被攻击方反击时自身特效
		public var chaEnemyEffectId:int;//被打角色特效ID -- 被攻击方反击时，对方的承受特效
		public var chaThrowEffectId:int; //角色投射特效ID -- 被攻击方反击时，投射特效
		public var chaEnemyAoeEffectId:int;//群体攻击投射特效：此定义为全屏特效 -- 被攻击方反击时，全屏特效
		
		public var enemyBuffArr:Array; // buff数组 存储buff id，用来做特效显示
		public var enemyBuffShowList:Array;//buff显示列表，包括多个RbattleBuffVo
		public var enemyPowerUp:int // +20 power增加
		public var enemyPowerDown:int; // -20 power减少
		public var enemyCurrentPower:int // 当前
		public var enemyTotalPower:int;// 总power
		public var enemyChangeHp:int // ±20
		public var enemyCurrentHp:int // 当前
		public var enemyTotalHp:int // 总HP
		public var enemyCounterHit:int // 是否反击：0-否，1-是
		private var _enemyStartPos:Point; // 起始坐标 -- 也可做为反击时投射特效起始坐标
		private var _enemyTargetPos:Point; // 目标坐标 -- 也可做为反击时投射特效的目标坐标
		public var chaThrowEffectTargetPos:Point;//投射特效终点坐标
		public var enemyDirection:int;//1--玩家朝向右，朝向右。2--玩家朝向左
		
		public function RBattleEnemyVo()
		{
		}
		public function set enemyStartPos(value:Point):void{
			_enemyStartPos = value;
			chaThrowEffectTargetPos = _enemyStartPos;
		}
		public function get enemyStartPos():Point{
			return _enemyStartPos;
		}
		public function set enemyTargetPos(value:Point):void{
			_enemyTargetPos = value;
		}
		public function get enemyTargetPos():Point{
			return _enemyTargetPos;
		}
	}
}