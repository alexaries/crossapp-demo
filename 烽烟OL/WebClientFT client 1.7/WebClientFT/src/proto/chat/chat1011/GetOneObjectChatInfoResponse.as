package proto.chat.chat1011 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetOneObjectChatInfoResponse extends Message implements IExternalizable {
		public var result:Boolean;
		private var message_:String;
		public function get hasMessage():Boolean {
			return null != message_;
		}
		public function set message(value:String):void {
			message_ = value;
		}
		public function get message():String {
			return message_;
		}
		private var chatMessage_:String;
		public function get hasChatMessage():Boolean {
			return null != chatMessage_;
		}
		public function set chatMessage(value:String):void {
			chatMessage_ = value;
		}
		public function get chatMessage():String {
			return chatMessage_;
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
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasChatMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, chatMessage);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, level);
			}
			if (hasPerfession) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, perfession);
			}
			if (hasChatObjectPos) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, chatObjectPos);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var chatMessageCount:uint = 0;
			var nameCount:uint = 0;
			var levelCount:uint = 0;
			var perfessionCount:uint = 0;
			var chatObjectPosCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (chatMessageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatMessageCount;
					chatMessage = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (perfessionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++perfessionCount;
					perfession = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (chatObjectPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatObjectPosCount;
					chatObjectPos = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (resultCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
