package proto.blacksmith.blacksmith2114 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class HeChenInfo extends Message implements IExternalizable {
		private var itemId_:int;
		private var hasItemId_:Boolean = false;
		public function get hasItemId():Boolean {
			return hasItemId_;
		}
		public function set itemId(value:int):void {
			hasItemId_ = true;
			itemId_ = value;
		}
		public function get itemId():int {
			return itemId_;
		}
		private var itemname_:String;
		public function get hasItemname():Boolean {
			return null != itemname_;
		}
		public function set itemname(value:String):void {
			itemname_ = value;
		}
		public function get itemname():String {
			return itemname_;
		}
		private var level_:int;
		private var hasLevel_:Boolean = false;
		public function get hasLevel():Boolean {
			return hasLevel_;
		}
		public function set level(value:int):void {
			hasLevel_ = true;
			level_ = value;
		}
		public function get level():int {
			return level_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, itemId);
			}
			if (hasItemname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, itemname);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, level);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemIdCount:uint = 0;
			var itemnameCount:uint = 0;
			var levelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemIdCount;
					itemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemnameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemnameCount;
					itemname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
