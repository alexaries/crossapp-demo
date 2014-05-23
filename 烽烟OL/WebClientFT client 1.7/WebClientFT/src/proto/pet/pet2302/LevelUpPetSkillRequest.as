package proto.pet.pet2302 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class LevelUpPetSkillRequest extends Message implements IExternalizable {
		public var id:int;
		public var petId:int;
		public var skillPos:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, petId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, skillPos);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var petIdCount:uint = 0;
			var skillPosCount:uint = 0;
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
					if (petIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petIdCount;
					petId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (skillPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++skillPosCount;
					skillPos = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (petIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (skillPosCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
