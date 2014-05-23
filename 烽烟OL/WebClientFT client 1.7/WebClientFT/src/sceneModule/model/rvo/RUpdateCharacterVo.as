package sceneModule.model.rvo
{
	import flash.geom.Point;

	public class RUpdateCharacterVo
	{
		
		public function RUpdateCharacterVo()
		{
		}
		public var chaType:int;//角色类型，区别于职业类型，1：角色，2：怪物，3：宠物
		public var id:int;
		public var name:String;//玩家名称
		public var unionName:String="";//玩家军团名称
		public var professionType:int;//玩家的职业类型,1-战士，2-法师，3-游侠，4-牧师
		public var profession:String="";//职业字符串，这个可以用来确定是新资源（新角色，时装，坐骑等）还是旧资源，确定资源所在目录,p
		public var isMySelf:Boolean;//是否是自己
		public var position:Point;//玩家坐标
		public var layer:int=19;//玩家所在的层
		public var isVip:Boolean = false;//玩家是否是VIP
		public var gemType:int=-1;//玩家镶嵌的宝石ID
		public var chaLevel:int;//角色等级
		public var vipLevel:int;//角色VIP等级
		
		public var trueProfessionType:int;//真正的职业类型，1-6，而不是取时间时的类型
		
		public var masterId:int = -1;//主人的ID -- 只针对宠物
		
		public var chaDirection:int;//1--玩家朝向右，朝向右。2--玩家朝向左
		
		public var isSelfPet:Boolean;
		
		public var curHp:int;
		public var maxHp:int;
		
		public var campid:int;
		
	}
}