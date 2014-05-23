package proto.chat.chat1013 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SendChatMessageRequest extends Message implements IExternalizable {
		public var id:int;
		public var chatId:int;
		public var chatMessage:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, chatId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, chatMessage);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var chatIdCount:uint = 0;
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
					if (chatIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatIdCount;
					chatId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
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
			if (chatIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (chatMessageCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
