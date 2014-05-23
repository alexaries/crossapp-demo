package proto.pack.pack215 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class splitItemsInPackRequest extends Message implements IExternalizable {
		public var id:int;
		public var packageType:int;
		public var fromposition:int;
		public var toposition:int;
		public var splitnum:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, packageType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, fromposition);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, toposition);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, splitnum);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var packageTypeCount:uint = 0;
			var frompositionCount:uint = 0;
			var topositionCount:uint = 0;
			var splitnumCount:uint = 0;
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
					if (packageTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++packageTypeCount;
					packageType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (frompositionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++frompositionCount;
					fromposition = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (topositionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++topositionCount;
					toposition = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (splitnumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++splitnumCount;
					splitnum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (packageTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (frompositionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (topositionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (splitnumCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
