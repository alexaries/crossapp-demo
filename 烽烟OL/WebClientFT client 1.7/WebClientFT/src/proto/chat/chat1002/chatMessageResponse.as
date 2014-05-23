package proto.chat.chat1002 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.chat.chat1002.itemLinkData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class chatMessageResponse extends Message implements IExternalizable {
		public var topic:int;
		public var id:int;
		public var profession:int;
		public var fromName:String;
		public var content:String;
		[ArrayElementType("proto.chat.chat1002.itemLinkData")]
		public var linkData:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, topic);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, profession);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, fromName);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
			WriteUtils.write_TYPE_STRING(output, content);
			for (var linkDataIndex:uint = 0; linkDataIndex < linkData.length; ++linkDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, linkData[linkDataIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var topicCount:uint = 0;
			var idCount:uint = 0;
			var professionCount:uint = 0;
			var fromNameCount:uint = 0;
			var contentCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (topicCount != 0) {
						throw new IOError('Bad data format.');
					}
					++topicCount;
					topic = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (fromNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fromNameCount;
					fromName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (contentCount != 0) {
						throw new IOError('Bad data format.');
					}
					++contentCount;
					content = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					linkData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.chat.chat1002.itemLinkData));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (topicCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (professionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (fromNameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (contentCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
