package proto.chat.chat1005 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class UseItemHornRequest extends Message implements IExternalizable {
		public var id:int;
		public var itemId:int;
		public var itemTemplateId:int;
		public var hornContent:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, itemId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, itemTemplateId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, hornContent);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var itemIdCount:uint = 0;
			var itemTemplateIdCount:uint = 0;
			var hornContentCount:uint = 0;
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
					if (itemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemIdCount;
					itemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (itemTemplateIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemTemplateIdCount;
					itemTemplateId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (hornContentCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hornContentCount;
					hornContent = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemTemplateIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (hornContentCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
