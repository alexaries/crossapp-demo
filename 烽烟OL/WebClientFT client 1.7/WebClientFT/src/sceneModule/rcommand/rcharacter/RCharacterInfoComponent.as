package sceneModule.rcommand.rcharacter
{
	import com.pblabs.engine.entity.EntityComponent;
	
	import flash.geom.Point;
	
	public class RCharacterInfoComponent extends EntityComponent
	{
		public function RCharacterInfoComponent()
		{
			super();
		}
		public var isMoving:Boolean=false;//角色是否正在移动
		public var chaType:int;//角色类型，区别于职业类型，1：角色，2：怪物，3：宠物
		public var chaId:int=-1;//角色ID
		public var chaBattleId:int;//角色战斗ID
		public var chaName:String;//角色名称
		public var chaProfessionType:int = -1;//职业
		public var chaProfession:String;//职业
		public var isChaSelf:Boolean = false;//当前收到的角色信息是否是当前玩家本人
		public var chaPos:Point;//角色的坐标
		public var chaCurrentDirection:int;//角色当前的方向
		public var functionType:int=1;//功能类型，NPC中表示区分商店，军团等；传送门中，区分是弹出窗口还是其他操作；角色可以用来区分自己人还是敌人？
		public var buffListLast:Array=[];//角色一次的BUFF数组
		public var buffList:Array=[];//角色本次的BUFF数组
		public var gemType:int=-1;//玩家镶嵌的宝石ID
		public var chaLevel:int;//角色等级
		public var vipLevel:int;//角色VIP等级
		
		public var trueProfessionType:int;//真正的职业类型，1-6，而不是取时间时的类型
		
		public var masterId:int = -1;//主人的ID -- 针对宠物
		//public var chaLayer:int;//角色所在的层
	}
}