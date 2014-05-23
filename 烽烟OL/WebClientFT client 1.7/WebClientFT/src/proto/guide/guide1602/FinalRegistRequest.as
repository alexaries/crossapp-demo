package proto.guide.guide1602 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FinalRegistRequest extends Message implements IExternalizable {
		public var username:String;
		public var password:String;
		public var nickname:String;
		public var profession:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, username);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, password);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, nickname);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, profession);
		}
		public function readExternal(input:IDataInput):void {
			var usernameCount:uint = 0;
			var passwordCount:uint = 0;
			var nicknameCount:uint = 0;
			var professionCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (usernameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++usernameCount;
					username = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (passwordCount != 0) {
						throw new IOError('Bad data format.');
					}
					++passwordCount;
					password = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (nicknameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nicknameCount;
					nickname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (usernameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (passwordCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nicknameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (professionCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
