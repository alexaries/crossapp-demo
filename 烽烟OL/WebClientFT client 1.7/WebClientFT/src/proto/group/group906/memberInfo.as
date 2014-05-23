package proto.group.group906 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class memberInfo extends Message implements IExternalizable {
		public var id:int;
		public var nickname:String;
		public var level:int;
		public var profession:int;
		public var maxHp:int;
		public var hp:int;
		public var maxMp:int;
		public var mp:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, nickname);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, level);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, profession);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, maxHp);
			WriteUtils.writeTag(output, WireType.VARINT, 6);
			WriteUtils.write_TYPE_INT32(output, hp);
			WriteUtils.writeTag(output, WireType.VARINT, 7);
			WriteUtils.write_TYPE_INT32(output, maxMp);
			WriteUtils.writeTag(output, WireType.VARINT, 8);
			WriteUtils.write_TYPE_INT32(output, mp);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nicknameCount:uint = 0;
			var levelCount:uint = 0;
			var professionCount:uint = 0;
			var maxHpCount:uint = 0;
			var hpCount:uint = 0;
			var maxMpCount:uint = 0;
			var mpCount:uint = 0;
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
					if (nicknameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nicknameCount;
					nickname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (maxHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxHpCount;
					maxHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (hpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hpCount;
					hp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (maxMpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxMpCount;
					maxMp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (mpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mpCount;
					mp = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nicknameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (levelCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (professionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (maxHpCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (hpCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (maxMpCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (mpCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
