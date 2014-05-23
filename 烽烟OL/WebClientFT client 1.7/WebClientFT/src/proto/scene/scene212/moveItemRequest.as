package proto.scene.scene212 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class moveItemRequest extends Message implements IExternalizable {
		public var id:int;
		public var packageType:int;
		public var fromPosition:int;
		public var toPosition:int;
		public var curpage:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, packageType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, fromPosition);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, toPosition);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, curpage);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var packageTypeCount:uint = 0;
			var fromPositionCount:uint = 0;
			var toPositionCount:uint = 0;
			var curpageCount:uint = 0;
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
					if (fromPositionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fromPositionCount;
					fromPosition = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (toPositionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++toPositionCount;
					toPosition = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
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
			if (fromPositionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (toPositionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (curpageCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
