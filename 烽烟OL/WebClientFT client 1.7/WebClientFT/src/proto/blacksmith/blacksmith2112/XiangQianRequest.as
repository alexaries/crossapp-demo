package proto.blacksmith.blacksmith2112 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class XiangQianRequest extends Message implements IExternalizable {
		public var id:int;
		public var equipId:int;
		public var sId:int;
		public var type:int;
		public var position:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, equipId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, sId);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, type);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, position);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var equipIdCount:uint = 0;
			var sIdCount:uint = 0;
			var typeCount:uint = 0;
			var positionCount:uint = 0;
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
					if (equipIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++equipIdCount;
					equipId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (sIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sIdCount;
					sId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (positionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++positionCount;
					position = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (equipIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (typeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (positionCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
