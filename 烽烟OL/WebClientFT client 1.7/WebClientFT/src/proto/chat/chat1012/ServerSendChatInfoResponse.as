package proto.chat.chat1012 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ServerSendChatInfoResponse extends Message implements IExternalizable {
		public var id:int;
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
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasChatMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, chatMessage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var chatMessageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (chatMessageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatMessageCount;
					chatMessage = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
