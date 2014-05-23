package proto.pratice.terminatePractice {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var monsterName_:String;
		public function get hasMonsterName():Boolean {
			return null != monsterName_;
		}
		public function set monsterName(value:String):void {
			monsterName_ = value;
		}
		public function get monsterName():String {
			return monsterName_;
		}
		private var currentExp_:int;
		private var hasCurrentExp_:Boolean = false;
		public function get hasCurrentExp():Boolean {
			return hasCurrentExp_;
		}
		public function set currentExp(value:int):void {
			hasCurrentExp_ = true;
			currentExp_ = value;
		}
		public function get currentExp():int {
			return currentExp_;
		}
		private var currentCountHit_:int;
		private var hasCurrentCountHit_:Boolean = false;
		public function get hasCurrentCountHit():Boolean {
			return hasCurrentCountHit_;
		}
		public function set currentCountHit(value:int):void {
			hasCurrentCountHit_ = true;
			currentCountHit_ = value;
		}
		public function get currentCountHit():int {
			return currentCountHit_;
		}
		private var status_:String;
		public function get hasStatus():Boolean {
			return null != status_;
		}
		public function set status(value:String):void {
			status_ = value;
		}
		public function get status():String {
			return status_;
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
			if (hasMonsterName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, monsterName);
			}
			if (hasCurrentExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, currentExp);
			}
			if (hasCurrentCountHit) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, currentCountHit);
			}
			if (hasStatus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, status);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, level);
			}
		}
		public function readExternal(input:IDataInput):void {
			var monsterNameCount:uint = 0;
			var currentExpCount:uint = 0;
			var currentCountHitCount:uint = 0;
			var statusCount:uint = 0;
			var levelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (monsterNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterNameCount;
					monsterName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (currentExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentExpCount;
					currentExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (currentCountHitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentCountHitCount;
					currentCountHit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (statusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++statusCount;
					status = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
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
