package proto.login.login102 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class activeNewPlayerRequest extends Message implements IExternalizable {
		public var userId:int;
		public var nickName:String;
		public var profession:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, userId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, nickName);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, profession);
		}
		public function readExternal(input:IDataInput):void {
			var userIdCount:uint = 0;
			var nickNameCount:uint = 0;
			var professionCount:uint = 0;
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
					if (nickNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nickNameCount;
					nickName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
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
			if (userIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nickNameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (professionCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
