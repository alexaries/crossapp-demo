package proto.pratice.terminateLobbyOperation {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var bonus_:int;
		private var hasBonus_:Boolean = false;
		public function get hasBonus():Boolean {
			return hasBonus_;
		}
		public function set bonus(value:int):void {
			hasBonus_ = true;
			bonus_ = value;
		}
		public function get bonus():int {
			return bonus_;
		}
		private var level_:int;
		private var hasLevel_:Boolean = false;
		public function get hasLevel():Boolean {
			return hasLevel_;
		}
		public function set level(value:int):void {
			hasLevel_ = true;
			level_ = value;
		}
		public function get level():int {
			return level_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBonus) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, bonus);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, level);
			}
		}
		public function readExternal(input:IDataInput):void {
			var bonusCount:uint = 0;
			var levelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (bonusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bonusCount;
					bonus = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
