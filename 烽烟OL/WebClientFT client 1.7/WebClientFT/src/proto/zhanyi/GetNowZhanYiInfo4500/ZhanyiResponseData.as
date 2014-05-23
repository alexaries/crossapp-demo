package proto.zhanyi.GetNowZhanYiInfo4500 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhangJieInfo;
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiMonster;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ZhanyiResponseData extends Message implements IExternalizable {
		private var index_:int;
		private var hasIndex_:Boolean = false;
		public function get hasIndex():Boolean {
			return hasIndex_;
		}
		public function set index(value:int):void {
			hasIndex_ = true;
			index_ = value;
		}
		public function get index():int {
			return index_;
		}
		private var maxpage_:int;
		private var hasMaxpage_:Boolean = false;
		public function get hasMaxpage():Boolean {
			return hasMaxpage_;
		}
		public function set maxpage(value:int):void {
			hasMaxpage_ = true;
			maxpage_ = value;
		}
		public function get maxpage():int {
			return maxpage_;
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
		[ArrayElementType("proto.zhanyi.GetNowZhanYiInfo4500.ZhangJieInfo")]
		public var zhangjielist:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, index);
			}
			if (hasMaxpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, maxpage);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasDesc) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, desc);
			}
			if (hasState) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, state);
			}
			if (hasMonster) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, monster);
			}
			for (var zhangjielistIndex:uint = 0; zhangjielistIndex < zhangjielist.length; ++zhangjielistIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_MESSAGE(output, zhangjielist[zhangjielistIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var indexCount:uint = 0;
			var maxpageCount:uint = 0;
			var nameCount:uint = 0;
			var descCount:uint = 0;
			var stateCount:uint = 0;
			var monsterCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (indexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++indexCount;
					index = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (maxpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxpageCount;
					maxpage = ReadUtils.read_TYPE_INT32(input);
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
					if (stateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stateCount;
					state = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (monsterCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterCount;
					monster = new proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiMonster;
					ReadUtils.read_TYPE_MESSAGE(input, monster);
					break;
				case 7:
					zhangjielist.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.zhanyi.GetNowZhanYiInfo4500.ZhangJieInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
