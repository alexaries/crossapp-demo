package proto.login.login101 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class loginToServerRequest extends Message implements IExternalizable {
		public var user:String;
		public var password:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, user);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, password);
		}
		public function readExternal(input:IDataInput):void {
			var userCount:uint = 0;
			var passwordCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (userCount != 0) {
						throw new IOError('Bad data format.');
					}
					++userCount;
					user = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
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
			if (userCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (passwordCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
