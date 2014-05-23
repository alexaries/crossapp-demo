package proto.chat.chat1004 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.chat.chat1004.ChatObjectData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SearchChatObjectFromFriendsResponse extends Message implements IExternalizable {
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
		[ArrayElementType("proto.chat.chat1004.ChatObjectData")]
		public var chatObjectData:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			for (var chatObjectDataIndex:uint = 0; chatObjectDataIndex < chatObjectData.length; ++chatObjectDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, chatObjectData[chatObjectDataIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
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
					chatObjectData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.chat.chat1004.ChatObjectData));
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
