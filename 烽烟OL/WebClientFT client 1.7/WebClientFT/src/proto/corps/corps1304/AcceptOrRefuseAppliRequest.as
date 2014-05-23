package proto.corps.corps1304 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class AcceptOrRefuseAppliRequest extends Message implements IExternalizable {
		public var id:int;
		public var operType:int;
		public var appliId:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, operType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, appliId);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var operTypeCount:uint = 0;
			var appliIdCount:uint = 0;
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
					if (operTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++operTypeCount;
					operType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (appliIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++appliIdCount;
					appliId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (operTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (appliIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
