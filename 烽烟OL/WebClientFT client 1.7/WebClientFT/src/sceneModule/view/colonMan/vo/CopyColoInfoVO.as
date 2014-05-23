package sceneModule.view.colonMan.vo
{
	/**
	 * 殖民副本信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class CopyColoInfoVO
	{
		public var c_id:int;//副本id
		public var c_name:String;//副本名称
		public var li_liang:int;//基础力量
		public var add_li_liang:int;//力量加成
		public var min_jie:int;//敏捷
		public var add_min_jie:int;//敏捷加成
		public var zhi_li:int;//智力
		public var add_zhi_li:int;//智力加成
		public var nai_li:int;//耐力
		public var add_nai_li:int;//耐力加成
		public var ji_shen:int;//精神
		public var add_ji_shen:int;//精神加成
		public var wu_gong:int;//物攻
		public var add_wu_gong:int;//物攻加成
		public var wu_fang:int;//物防
		public var add_wu_fang:int;//物防加成
		public var mo_gong:int;//魔攻
		public var add_mo_gong:int;//魔攻加成
		public var mo_fang:int;//魔防
		public var add_mo_fang:int;//魔防加成
		public var gong_su:int;//攻速
		public var add_gong_su:int;//攻速加成
		public var ming_zhong:int;//命中
		public var add_ming_zhong:int;//命中加成
		public var bao_ji:int;//暴击
		public var add_bao_ji:int;//暴击加成
		public var shan_bi:int;//闪避
		public var add_shan_bi:int;//闪避加成
		public var liliang_info:ItemManInfoVO = new ItemManInfoVO();//力量药剂信息
		public var minjie_info:ItemManInfoVO = new ItemManInfoVO();//敏捷药剂信息
		public var zhili_info:ItemManInfoVO = new ItemManInfoVO();//智力药剂信息
		public var naili_info:ItemManInfoVO = new ItemManInfoVO();//耐力药剂信息
		public var jingshen_info:ItemManInfoVO = new ItemManInfoVO();//精神药剂信息
		public function CopyColoInfoVO()
		{
		}
	}
}