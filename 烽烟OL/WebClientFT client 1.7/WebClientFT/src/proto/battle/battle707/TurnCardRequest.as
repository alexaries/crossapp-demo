package proto.battle.battle707 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TurnCardRequest extends Message implements IExternalizable {
		public var characterId:int;
		public var cardId:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, characterId);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, cardId);
		}
		public function readExternal(input:IDataInput):void {
			var characterIdCount:uint = 0;
			var cardIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (characterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++characterIdCount;
					characterId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (cardIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++cardIdCount;
					cardId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (characterIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (cardIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
