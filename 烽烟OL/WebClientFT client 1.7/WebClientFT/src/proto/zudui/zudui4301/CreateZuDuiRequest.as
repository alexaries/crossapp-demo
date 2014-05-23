package proto.zudui.zudui4301 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CreateZuDuiRequest extends Message implements IExternalizable {
		public var id:int;
		public var pos:int;
		public var gkType:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, pos);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, gkType);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var posCount:uint = 0;
			var gkTypeCount:uint = 0;
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
					if (posCount != 0) {
						throw new IOError('Bad data format.');
					}
					++posCount;
					pos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (gkTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++gkTypeCount;
					gkType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (posCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (gkTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
