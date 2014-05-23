package proto.chat.chat1010 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ChatObjectInfo extends Message implements IExternalizable {
		private var chatObjectId_:int;
		private var hasChatObjectId_:Boolean = false;
		public function get hasChatObjectId():Boolean {
			return hasChatObjectId_;
		}
		public function set chatObjectId(value:int):void {
			hasChatObjectId_ = true;
			chatObjectId_ = value;
		}
		public function get chatObjectId():int {
			return chatObjectId_;
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
		private var level_:String;
		public function get hasLevel():Boolean {
			return null != level_;
		}
		public function set level(value:String):void {
			level_ = value;
		}
		public function get level():String {
			return level_;
		}
		private var perfession_:String;
		public function get hasPerfession():Boolean {
			return null != perfession_;
		}
		public function set perfession(value:String):void {
			perfession_ = value;
		}
		public function get perfession():String {
			return perfession_;
		}
		private var chatObjectPos_:String;
		public function get hasChatObjectPos():Boolean {
			return null != chatObjectPos_;
		}
		public function set chatObjectPos(value:String):void {
			chatObjectPos_ = value;
		}
		public function get chatObjectPos():String {
			return chatObjectPos_;
		}
		private var readFlag_:Boolean;
		private var hasReadFlag_:Boolean = false;
		public function get hasReadFlag():Boolean {
			return hasReadFlag_;
		}
		public function set readFlag(value:Boolean):void {
			hasReadFlag_ = true;
			readFlag_ = value;
		}
		public function get readFlag():Boolean {
			return readFlag_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasChatObjectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, chatObjectId);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, level);
			}
			if (hasPerfession) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, perfession);
			}
			if (hasChatObjectPos) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, chatObjectPos);
			}
			if (hasReadFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_BOOL(output, readFlag);
			}
		}
		public function readExternal(input:IDataInput):void {
			var chatObjectIdCount:uint = 0;
			var nameCount:uint = 0;
			var levelCount:uint = 0;
			var perfessionCount:uint = 0;
			var chatObjectPosCount:uint = 0;
			var readFlagCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (chatObjectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatObjectIdCount;
					chatObjectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (perfessionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++perfessionCount;
					perfession = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (chatObjectPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatObjectPosCount;
					chatObjectPos = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (readFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++readFlagCount;
					readFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
