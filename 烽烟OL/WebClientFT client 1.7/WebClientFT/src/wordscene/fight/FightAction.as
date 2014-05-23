/**
 * FightAction:
 *   id
 *   fatherID
 *   actionType
 *       (移动 arg1 = 移动对象实体ID , arg2 = 目的地X坐标 , arg3 = 目的地Y坐标)
 *       (角色动作 arg1 = 实体ID , arg1 = 动作名, arg3 = 触发时间)
 *       (显示使用技能名 arg1 = 实体ID , arg2 = 技能名)
 *       (单体技能特效 arg1 = 实体ID , arg2 = 特效素材 , arg3 = 位置)
 *       (群攻特效 arg1 =位置 , arg1 = 特效素材)
 *       (添加buf arg1 = 实体ID , arg1 = 特效素材)
 *       (删除buf arg1 = 实体ID , arg1 = 特效素材)
 *       (添加HP arg1 = 实体ID , arg1 = 类型 , arg2 = 增加值 , arg3 = 当前值 , arg4 = 最大值)
 *       (添加MP arg1 = 实体ID , arg1 = 类型 , arg2 = 增加值 , arg3 = 当前值 , arg4 = 最大值)
 *       (减少HP arg1 = 实体ID , arg1 = 类型 , arg2 = 减少值 , arg3 = 当前值 , arg4 = 最大值)
 *       (减少MP arg1 = 实体ID , arg1 = 类型 , arg2 = 减少值 , arg3 = 当前值 , arg4 = 最大值)
 *       (添加角色 arg1 = 添加位置 , arg2 = 实体ID , arg3 = 当前HP , arg4 = 最大HP , arg5 = 当前MP , arg6 = 最大MP)
 *       (删除角色 arg1 = 删除的位置)
 *   arg1
 *   arg2
 *   arg3
 *   arg4
 *   arg4
 */
package wordscene.fight 
{
	/**
	 * 战斗动作数据
	 * @author hao
	 */
	public class FightAction
	{
		//(移动 arg1 = 移动对象实体ID , arg2 = 目的地X坐标 , arg3 = 目的地Y坐标 , arg4 = 移动时间, arg5 = 转向时机,arg6=是否闪避 ,arg7=攻击者pos)
        public static const Action_Type_Move:int = 1;
		
		//(角色动作 arg1 = 实体ID , arg1 = 动作名, arg3 = 触发时间,arg4 = 是否复活 , arg5 = 是否检测返回原位置)
        public static const Action_Type_Char_Action:int = 2;
		
		//(显示使用技能名 arg1 = 实体ID , arg2 = 技能索引 , arg3 = 显示时间)
        public static const Action_Type_Show_Skill_Name:int = 3;
		
		//(单体技能特效 arg1 = 实体ID , arg2 = 特效素材 ,arg3 = 施法者位置 , arg4 = 技能id)
        public static const Action_Type_Skill_Eff_Single:int = 4;
		
		//(群攻特效 arg1 =释放位置 , arg2 = 特效素材 , arg3 = 施法者位置 , arg4 = 技能ID)
        public static const Action_Type_Skill_Eff_Group:int = 5;
		
		//(添加buf arg1 = 实体ID , arg2 = 特效素材,arg3 = 释放buf人的ID , arg4 = 施法时间类型 ,arg5 = 添加的buff对象 , arg6 = buf的id)
		public static const Action_Type_Buff_Eff_Add:int = 6;
		
		//(删除buf arg1 = 实体ID , arg2 = 特效素材 ,arg3 = buf模板ID, arg4 = 是否删除战况的ICO)
        public static const Action_Type_Buff_Eff_Remove:int = 7;
		
		//(添加HP arg1 = 实体ID , arg2 = 类型 , arg3 = 增加值 , arg4 = 当前值 , arg5 = 最大值)
        public static const Action_Type_HP_Add:int = 8;
		
		//(添加MP arg1 = 实体ID , arg2 = 类型 , arg3 = 增加值 , arg4 = 当前值 , arg5 = 最大值)
        public static const Action_Type_MP_Add:int = 9;
		
		//(减少HP arg1 = 实体ID , arg2 = 类型 , arg3 = 减少值 , arg4 = 当前值 , arg5 = 最大值)
        public static const Action_Type_HP_DEC:int = 10;
		
		//(减少MP arg1 = 实体ID , arg2 = 类型 , arg3 = 减少值 , arg4 = 当前值 , arg5 = 最大值 , arg6 = 是否显示数字)
        public static const Action_Type_MP_DEC:int = 11;
		
		//(添加角色 arg1 = 添加位置 , arg2 = 实体ID , arg3 = 当前HP , arg4 = 最大HP , arg5 = 当前MP , arg6 = 最大MP, arg7 = 添加者的位置 ,arg8 = 是否添加数据 , arg9 = 模板ID ,arg10 = 名字 , arg11 = 是否是换宠)
        public static const Action_Type_Char_Add:int = 12;
		
		//(删除角色 arg1 = 删除的位置, arg2 = 是否删除数据)
		public static const Action_Type_Char_Remove:int = 13;
		
		//(增加HP而不显示增加HP的数字 arg1 = 角色位置 , arg2 = 当前值 , arg3 = 最大值)
		public static const Action_Type_Char_HP_Add_No_Number:int = 14;
		
		//(空白动作 arg1 = 主动角色位置 , arg2 = 被动角色的位置 , arg3 = 空白时间 , arg4 = 要提示的错误码 , arg5 = 错误码附带参数)
		public static const Action_Type_Blank:int = 15;
		
		//(实体说话 arg1 = 主动角色位置 , arg2 = 说话内容 , arg3 = 说话的NPC的名字)
		public static const Action_Type_Say_Word:int = 16;
		
		//(实体说话 arg1 = 主动角色位置 , arg2 = 被攻击结果类型[1:Miss - 2:免疫 - 3 : 免疫buf])
		public static const Action_Type_Show_Attacked_Result:int = 17;
		
		//(实体说话 arg1 = 删除的类型[1 : 人物 - 2 : 宠物] , arg2 = 不清楚的skillID)
		public static const Action_Type_Clear_Skill_CD:int = 18;
		
		
		//正常变更
		public static const HP_MP_Change_Type_Nomal:int = 1;
		//正常暴击
		public static const HP_MP_Change_Type_Bomb:int = 2;
		
		
		private static var _globlID:int = 0;
		
		private var _id:int;
		private var _fatherID:int;
		private var _nextActionTriger:int;
		private var _actionType:int;
		private var _actionTypeName:String;
		private var _arg1:*;
		private var _arg2:*;
		private var _arg3:*;
		private var _arg4:*;
		private var _arg5:*;
		private var _arg6:*;
		private var _arg7:*;
		private var _arg8:*;
		private var _arg9:*;
		private var _arg10:*;
		private var _arg11:*;
		
		public function FightAction() 
		{
			_id = _globlID;
			_globlID++;
		}
		
		
		public static function resetGloblID():void {
			_globlID = 0;
		}
		
		private function setTypeName():void {
			switch(_actionType) {
				case  Action_Type_Move:
					_actionTypeName = "Action_Type_Move";
					break;
				case  Action_Type_Char_Action:
					_actionTypeName = "Action_Type_Char_Action";
					break;
				case  Action_Type_Show_Skill_Name:
					_actionTypeName = "Action_Type_Show_Skill_Name";
					break;
				case  Action_Type_Skill_Eff_Single:
					_actionTypeName = "Action_Type_Skill_Eff_Single";
					break;
				case  Action_Type_Skill_Eff_Group:
					_actionTypeName = "Action_Type_Skill_Eff_Group";
					break;
				case  Action_Type_Buff_Eff_Add:
					_actionTypeName = "Action_Type_Buff_Eff_Add";
					break;
				case  Action_Type_Buff_Eff_Remove:
					_actionTypeName = "Action_Type_Buff_Eff_Remove";
					break;
				case  Action_Type_HP_Add:
					_actionTypeName = "Action_Type_HP_Add";
					break;
				case  Action_Type_MP_Add:
					_actionTypeName = "Action_Type_MP_Add";
					break;
				case  Action_Type_HP_DEC:
					_actionTypeName = "Action_Type_HP_DEC";
					break;
				case  Action_Type_MP_DEC:
					_actionTypeName = "Action_Type_MP_DEC";
					break;
				case  Action_Type_Char_Add:
					_actionTypeName = "Action_Type_Char_Add";
					break;
				case  Action_Type_Char_Remove:
					_actionTypeName = "Action_Type_Char_Remove";
					break;
				case  Action_Type_Char_HP_Add_No_Number:
					_actionTypeName = "Action_Type_Char_HP_Add_No_Number";
					break;
				case  Action_Type_Blank:
					_actionTypeName = "Action_Type_Blank";
					break;
				case  Action_Type_Say_Word:
					_actionTypeName = "Action_Type_Say_Word";
					break; 
				case Action_Type_Show_Attacked_Result:
					_actionTypeName = "Action_Type_Show_Attacked_Result";
					break;
				case Action_Type_Clear_Skill_CD:
					_actionTypeName = "Action_Type_Clear_Skill_CD";
					break;
			}
		}
		
		public function get id():int { return _id; }
		
		public function get fatherID():int { return _fatherID; }
		
		public function set fatherID(value:int):void 
		{
			_fatherID = value;
		}
		
		public function get nextActionTriger():int { return _nextActionTriger; }
		
		public function set nextActionTriger(value:int):void 
		{
			_nextActionTriger = value;
		}
		
		public function get actionType():int { return _actionType; }
		
		public function set actionType(value:int):void 
		{
			_actionType = value;
			setTypeName();
		}
		
		public function get arg1():* { return _arg1; }
		
		public function set arg1(value:*):void 
		{
			_arg1 = value;
		}
		
		public function get arg2():* { return _arg2; }
		
		public function set arg2(value:*):void 
		{
			_arg2 = value;
		}
		
		public function get arg3():* { return _arg3; }
		
		public function set arg3(value:*):void 
		{
			_arg3 = value;
		}
		
		public function get arg5():* { return _arg5; }
		
		public function set arg5(value:*):void 
		{
			_arg5 = value;
		}
		
		public function get arg4():* { return _arg4; }
		
		public function set arg4(value:*):void 
		{
			_arg4 = value;
		}
		
		public function get actionTypeName():String { return _actionTypeName; }
		
		public function get arg6():* { return _arg6; }
		
		public function set arg6(value:*):void 
		{
			_arg6 = value;
		}
		
		public function get arg7():* { return _arg7; }
		
		public function set arg7(value:*):void 
		{
			_arg7 = value;
		}
		
		public function get arg8():* { return _arg8; }
		
		public function set arg8(value:*):void 
		{
			_arg8 = value;
		}
		
		public function get arg9():* { return _arg9; }
		
		public function set arg9(value:*):void 
		{
			_arg9 = value;
		}
		
		public function get arg10():* { return _arg10; }
		
		public function set arg10(value:*):void 
		{
			_arg10 = value;
		}
		
		public function get arg11():* { return _arg11; }
		
		public function set arg11(value:*):void 
		{
			_arg11 = value;
		}
		
	}

}