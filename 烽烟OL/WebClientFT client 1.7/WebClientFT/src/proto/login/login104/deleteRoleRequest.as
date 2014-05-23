package proto.login.login104 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class deleteRoleRequest extends Message implements IExternalizable {
		public var userId:int;
		public var id:int;
		public var password:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, userId);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, password);
		}
		public function readExternal(input:IDataInput):void {
			var userIdCount:uint = 0;
			var idCount:uint = 0;
			var passwordCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (userIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++userIdCount;
					userId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (passwordCount != 0) {
						throw new IOError('Bad data format.');
					}
					++passwordCount;
					password = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (userIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (passwordCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
