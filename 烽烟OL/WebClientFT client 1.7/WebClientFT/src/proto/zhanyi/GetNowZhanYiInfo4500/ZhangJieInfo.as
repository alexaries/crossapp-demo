package proto.zhanyi.GetNowZhanYiInfo4500 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiMonster;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ZhangJieInfo extends Message implements IExternalizable {
		private var zhangjieid_:int;
		private var hasZhangjieid_:Boolean = false;
		public function get hasZhangjieid():Boolean {
			return hasZhangjieid_;
		}
		public function set zhangjieid(value:int):void {
			hasZhangjieid_ = true;
			zhangjieid_ = value;
		}
		public function get zhangjieid():int {
			return zhangjieid_;
		}
		private var state_:int;
		private var hasState_:Boolean = false;
		public function get hasState():Boolean {
			return hasState_;
		}
		public function set state(value:int):void {
			hasState_ = true;
			state_ = value;
		}
		public function get state():int {
			return state_;
		}
		private var name_:String;
		public function get hasName():Boolean {
			return null != name_;
		}
		public function set name(value:String):void {
			name_ = value;
		}
		public function get name():String {
			return name_;
		}
		private var desc_:String;
		public function get hasDesc():Boolean {
			return null != desc_;
		}
		public function set desc(value:String):void {
			desc_ = value;
		}
		public function get desc():String {
			return desc_;
		}
		private var monster_:proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiMonster;
		public function get hasMonster():Boolean {
			return null != monster_;
		}
		public function set monster(value:proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiMonster):void {
			monster_ = value;
		}
		public function get monster():proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiMonster {
			return monster_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasZhangjieid) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, zhangjieid);
			}
			if (hasState) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, state);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasDesc) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, desc);
			}
			if (hasMonster) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, monster);
			}
		}
		public function readExternal(input:IDataInput):void {
			var zhangjieidCount:uint = 0;
			var stateCount:uint = 0;
			var nameCount:uint = 0;
			var descCount:uint = 0;
			var monsterCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (zhangjieidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zhangjieidCount;
					zhangjieid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (stateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stateCount;
					state = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (descCount != 0) {
						throw new IOError('Bad data format.');
					}
					++descCount;
					desc = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (monsterCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterCount;
					monster = new proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiMonster;
					ReadUtils.read_TYPE_MESSAGE(input, monster);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
