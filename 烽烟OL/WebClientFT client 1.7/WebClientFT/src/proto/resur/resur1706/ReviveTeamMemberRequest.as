package proto.resur.resur1706 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ReviveTeamMemberRequest extends Message implements IExternalizable {
		public var id:int;
		public var victimerId:int;
		public var paytype:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, victimerId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, paytype);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var victimerIdCount:uint = 0;
			var paytypeCount:uint = 0;
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
					if (victimerIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++victimerIdCount;
					victimerId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (paytypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++paytypeCount;
					paytype = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (victimerIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (paytypeCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
