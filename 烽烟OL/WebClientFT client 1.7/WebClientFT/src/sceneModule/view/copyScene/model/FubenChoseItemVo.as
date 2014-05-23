package sceneModule.view.copyScene.model 
{
	import proto.copyScene.copyScene1506.FMonsterInfo;
	/**
	 * ...
	 * @author hao
	 */
	[Bindable]
	public class FubenChoseItemVo 
	{
		public static const TOP_LEFT:int = 1;
		public static const TOP_RIGHT:int = 2;
		public static const BOTTOM_LEFT:int = 3;
		public static const BOTTOM_RIGHT:int = 4;
		
		
		private var _id:int;
		private var _nomal_bg_path:String;
		private var _down_bg_path:String;
		private var _selected_bg_path:String;
		private var _disable_bg_path:String;
		private var _pos_x:int;
		private var _pos_y:int;
		private var _point:int;
		private var _des:String;
		private var _is_enable:Boolean;
		
		private var _id0:int;
		private var _id1:int;
		private var _id2:int;
		
		private var _state0:int;//1通过-1没通过
		private var _state1:int;
		private var _state2:int;
		
		private var _union_id:int;
		private var _union_name:String;
		private var _leader_id:int;
		private var _leader_name:String;
		private var _monst_infos:Array;
		private var _fu_camp:int;//0中立1光明2黑暗
		
		private var fuben_state:int;
		
		private var _unin_state:int;
		
		public function set _fuben_state(state:int):void{
			fuben_state = state;
		}
		
		public function get _fuben_state():int{
			return fuben_state;
		}
		public function FubenChoseItemVo() 
		{
			
		}
		
		public function get fu_camp():int 
		{
			return _fu_camp;
		}
		
		public function set fu_camp(value:int):void 
		{
			_fu_camp = value;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get nomal_bg_path():String 
		{
			return _nomal_bg_path;
		}
		
		public function set nomal_bg_path(value:String):void 
		{
			_nomal_bg_path = value;
		}
		
		public function get down_bg_path():String 
		{
			return _down_bg_path;
		}
		
		public function set down_bg_path(value:String):void 
		{
			_down_bg_path = value;
		}
		
		public function get selected_bg_path():String 
		{
			return _selected_bg_path;
		}
		
		public function set selected_bg_path(value:String):void 
		{
			_selected_bg_path = value;
		}
		
		public function get disable_bg_path():String 
		{
			return _disable_bg_path;
		}
		
		public function set disable_bg_path(value:String):void 
		{
			_disable_bg_path = value;
		}
		
		public function get pos_x():int 
		{
			return _pos_x;
		}
		
		public function set pos_x(value:int):void 
		{
			_pos_x = value;
		}
		
		public function get pos_y():int 
		{
			return _pos_y;
		}
		
		public function set pos_y(value:int):void 
		{
			_pos_y = value;
		}
		
		public function get point():int 
		{
			return _point;
		}
		
		public function set point(value:int):void 
		{
			_point = value;
		}
		
		public function get des():String 
		{
			return _des;
		}
		
		public function set des(value:String):void 
		{
			_des = value;
		}
		
		public function get is_enable():Boolean 
		{
			return _is_enable;
		}
		
		public function set is_enable(value:Boolean):void 
		{
			_is_enable = value;
		}
		
		public function get id1():int 
		{
			return _id1;
		}
		
		public function set id1(value:int):void 
		{
			_id1 = value;
		}
		
		public function get id2():int 
		{
			return _id2;
		}
		
		public function set id2(value:int):void 
		{
			_id2 = value;
		}
		
		public function get id0():int 
		{
			return _id0;
		}
		
		public function set id0(value:int):void 
		{
			_id0 = value;
		}
		
		public function get union_id():int 
		{
			return _union_id;
		}
		
		public function set union_id(value:int):void 
		{
			_union_id = value;
		}
		
		public function get union_name():String 
		{
			return _union_name;
		}
		
		public function set union_name(value:String):void 
		{
			_union_name = value;
		}
		
		public function get leader_id():int 
		{
			return _leader_id;
		}
		
		public function set leader_id(value:int):void 
		{
			_leader_id = value;
		}
		
		public function get leader_name():String 
		{
			return _leader_name;
		}
		
		public function set leader_name(value:String):void 
		{
			_leader_name = value;
		}
		
		public function get unin_state():int 
		{
			return _unin_state;
		}
		
		public function set unin_state(value:int):void 
		{
			_unin_state = value;
		}
		
		public function get monst_infos():Array 
		{
			return _monst_infos;
		}
		
		public function set monst_infos(value:Array):void 
		{
			_monst_infos = value;
		}
		
		public function set state0(s0:int):void{
			_state0 = s0;
		}
		
		public function get state0():int{
			return _state0;
		}
		public function set state1(s1:int):void{
			_state1 = s1;
		}
		
		public function get state1():int{
			return _state1;
		}
		public function set state2(s2:int):void{
			_state2 = s2;
		}
		
		public function get state2():int{
			return _state2;
		}
		
	}

}