package proto.pack.pack223 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PackageExpansionRequest extends Message implements IExternalizable {
		public var characterId:int;
		public var packageType:int;
		public var curpage:int;
		public var position:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, characterId);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, packageType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, curpage);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, position);
		}
		public function readExternal(input:IDataInput):void {
			var characterIdCount:uint = 0;
			var packageTypeCount:uint = 0;
			var curpageCount:uint = 0;
			var positionCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (characterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++characterIdCount;
					characterId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (packageTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++packageTypeCount;
					packageType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
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
			if (characterIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (packageTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (curpageCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (positionCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
