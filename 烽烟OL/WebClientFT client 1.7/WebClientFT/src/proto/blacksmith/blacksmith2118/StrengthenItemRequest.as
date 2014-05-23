package proto.blacksmith.blacksmith2118 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class StrengthenItemRequest extends Message implements IExternalizable {
		public var id:int;
		public var itemId1:int;
		public var itemId2:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, itemId1);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, itemId2);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var itemId1Count:uint = 0;
			var itemId2Count:uint = 0;
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
					if (itemId1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++itemId1Count;
					itemId1 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (itemId2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++itemId2Count;
					itemId2 = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemId1Count != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemId2Count != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
