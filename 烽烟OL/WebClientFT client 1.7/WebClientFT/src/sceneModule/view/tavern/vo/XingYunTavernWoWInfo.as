package sceneModule.view.tavern.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 魔兽酒馆VO幸运值购买
	 *
	 */
	[Bindable]
	public class XingYunTavernWoWInfo
	{
		public var wSkill:String; //技能
		public var wTexing:String; //特性
		public var wLiliang:int; //力量
		public var wZhili:int; //智力
		public var wNaili:int; //耐力
		public var wMinjie:int; //敏捷
		public var wWugong:int; //物攻
		public var wMogong:int; //魔攻
		public var wGongsu:int; //攻速
		public var wBaoji:int; //暴击
		public var wWufang:int; //物防
		public var wMofang:int; //魔防
		public var wMingzhong:int; //命中
		public var wShanbi:int; //闪避
		public var wKaobao:int; //抗暴
		public var wName:String; //宠物名称
		public var wGuyongzhi:int;//是否标记已拥有  1标记  -1不标记
		public var wGuYongXingYunZhi:int; //雇佣价格(幸运值)
		public var id:int; //宠物模版ids
		public var color:int//宠物颜色 1=普通（绿）2=优秀（蓝）3=精良（紫） 4=史诗（金）5=传说（橙）6=逆天（红）
		public var icon:int;//宠物头像名称
		public var type:int;//宠物类型
		public var level:int;//等级
		public function XingYunTavernWoWInfo()
		{
		}
	}
}
