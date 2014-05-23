package proto.commission.commission1210 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ConsAnnonRequest extends Message implements IExternalizable {
		public var id:int;
		public var consType:int;
		public var consId:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, consType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, consId);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var consTypeCount:uint = 0;
			var consIdCount:uint = 0;
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
					if (consTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++consTypeCount;
					consType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (consIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++consIdCount;
					consId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (consTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (consIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
