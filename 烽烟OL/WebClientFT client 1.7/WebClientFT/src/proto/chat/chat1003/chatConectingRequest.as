package proto.chat.chat1003 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.chat.chat1003.itemLinkData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class chatConectingRequest extends Message implements IExternalizable {
		public var id:int;
		public var topic:int;
		public var content:String;
		[ArrayElementType("proto.chat.chat1003.itemLinkData")]
		public var linkData:Array = [];
		private var chatOjbect_:String;
		public function get hasChatOjbect():Boolean {
			return null != chatOjbect_;
		}
		public function set chatOjbect(value:String):void {
			chatOjbect_ = value;
		}
		public function get chatOjbect():String {
			return chatOjbect_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, topic);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, content);
			for (var linkDataIndex:uint = 0; linkDataIndex < linkData.length; ++linkDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, linkData[linkDataIndex]);
			}
			if (hasChatOjbect) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, chatOjbect);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var topicCount:uint = 0;
			var contentCount:uint = 0;
			var chatOjbectCount:uint = 0;
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
					if (topicCount != 0) {
						throw new IOError('Bad data format.');
					}
					++topicCount;
					topic = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (contentCount != 0) {
						throw new IOError('Bad data format.');
					}
					++contentCount;
					content = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					linkData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.chat.chat1003.itemLinkData));
					break;
				case 5:
					if (chatOjbectCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chatOjbectCount;
					chatOjbect = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (topicCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (contentCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
