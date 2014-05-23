package sceneModule.model.rvo
{
	import flash.geom.Point;

	/**
	 * 战斗数据VO，战斗中，完整的一步所需要的数据
	 * @author mutou
	 * 
	 */	
	public class RBattleRoundVo
	{
		public var chaName:String;//角色名字
		public var chaLevel:int;//角色等级
		public var chaId:int; // 角色ID 如果是 -1表示系统，本回合为buff回合，enemyChaArr中的角色会掉HP
		public var chaBattleId:int; // 角色战斗ID
		public var chaProfessionType:int;//角色形象ID 职业类型,1-战士，2-法师，3-游侠，4-牧师
		public var actionId:int; // 角色动作ID
		public var counterHitActionId:int; // 攻击方受反击时的动作
		public var isDeathOfCounterHit:int;//攻击方是否被反击致死 0:否，1：是
		public var txtEffectId:int; // 文字效果ID,暴击，闪避等
		public var powerEffectId:int;// power 满后的特效
		
		public var chaEffectId:int; //角色特效ID
		public var chaEnemyEffectId:int;//被打角色特效ID
		public var chaThrowEffectId:int; //角色投射特效ID
		public var chaAoeEffectId:int;//群体攻击投射特效：此定义为全屏特效
		
		public var chaBuffArr:Array; // buff数组 存储buff id，用来做特效显示
		public var chaBuffShowList:Array;//buff显示列表，包括多个RbattleBuffVo
		public var chaPowerUp:int; // +20 power增加
		public var chaPowerDown:int; // -20 power减少
		public var chaCurrentPower:int; // 当前power
		public var chaTotalPower:int; // 总power
		public var chaChangeHp:int; // ±20 正负HP，可能有加血技能
		public var chaCurrentHp:int; // 当前HP
		public var chaTotalHp:int; // 总HP
		public var chaExpendHp:int; // 烧血技能消耗HP
		private var _chaStartPos:Point; // 起始坐标
		private var _chaTargetPos:Point; // 目标坐标
		public var chaThrowEffectStartPos:Point;//投射特效起始坐标
		public var chaAttackType:int;//攻击方式 1:进程，2：远程
		public var isCriticalBlow:Boolean = false;//是否暴击
		public var chaDirection:int;//1--玩家朝向右，朝向右。2--玩家朝向左
		
		public var enemyChaArr:Array; // 敌方数据数组,数组中每一个元素对象是一个RBattleEnemyVo
		
		public function RBattleRoundVo()
		{
		}
		public function set chaStartPos(value:Point):void{
			_chaStartPos = value;
			chaThrowEffectStartPos = _chaStartPos;
		}
		public function get chaStartPos():Point{
			return _chaStartPos;
		}
		public function set chaTargetPos(value:Point):void{
			_chaTargetPos = value;
		}
		public function get chaTargetPos():Point{
			return _chaTargetPos;
		}
	}
}