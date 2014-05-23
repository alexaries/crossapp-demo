package proto.pratice.getPratice {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class praticeRequest extends Message implements IExternalizable {
		public var id:int;
		public var monsterId:int;
		public var singleExpBonus:int;
		public var monsterCount:int;
		public var monsterLevel:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, monsterId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, singleExpBonus);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, monsterCount);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, monsterLevel);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var monsterIdCount:uint = 0;
			var singleExpBonusCount:uint = 0;
			var monsterCountCount:uint = 0;
			var monsterLevelCount:uint = 0;
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
					if (monsterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterIdCount;
					monsterId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (singleExpBonusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++singleExpBonusCount;
					singleExpBonus = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (monsterCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterCountCount;
					monsterCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (monsterLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterLevelCount;
					monsterLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (monsterIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (singleExpBonusCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (monsterCountCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (monsterLevelCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
