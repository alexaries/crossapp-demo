package proto.role.role1101 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		public var sparePoint:int;
		public var manualStr:int;
		public var manualVit:int;
		public var manualDex:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, sparePoint);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, manualStr);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, manualVit);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, manualDex);
		}
		public function readExternal(input:IDataInput):void {
			var sparePointCount:uint = 0;
			var manualStrCount:uint = 0;
			var manualVitCount:uint = 0;
			var manualDexCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (sparePointCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sparePointCount;
					sparePoint = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (manualStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualStrCount;
					manualStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (manualVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualVitCount;
					manualVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (manualDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualDexCount;
					manualDex = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (sparePointCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (manualStrCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (manualVitCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (manualDexCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
