package proto.guide.guide1601 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class beginnersRegistRequest extends Message implements IExternalizable {
		public var beginnerId:int;
		public var nickname:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, beginnerId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, nickname);
		}
		public function readExternal(input:IDataInput):void {
			var beginnerIdCount:uint = 0;
			var nicknameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (beginnerIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++beginnerIdCount;
					beginnerId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (nicknameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nicknameCount;
					nickname = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (beginnerIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nicknameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
