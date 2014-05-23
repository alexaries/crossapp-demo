package proto.groupHall.groupHall1805 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MonsterInfo extends Message implements IExternalizable {
		private var monsterId_:int;
		private var hasMonsterId_:Boolean = false;
		public function get hasMonsterId():Boolean {
			return hasMonsterId_;
		}
		public function set monsterId(value:int):void {
			hasMonsterId_ = true;
			monsterId_ = value;
		}
		public function get monsterId():int {
			return monsterId_;
		}
		private var monsterLevel_:int;
		private var hasMonsterLevel_:Boolean = false;
		public function get hasMonsterLevel():Boolean {
			return hasMonsterLevel_;
		}
		public function set monsterLevel(value:int):void {
			hasMonsterLevel_ = true;
			monsterLevel_ = value;
		}
		public function get monsterLevel():int {
			return monsterLevel_;
		}
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
		private var monstertype_:int;
		private var hasMonstertype_:Boolean = false;
		public function get hasMonstertype():Boolean {
			return hasMonstertype_;
		}
		public function set monstertype(value:int):void {
			hasMonstertype_ = true;
			monstertype_ = value;
		}
		public function get monstertype():int {
			return monstertype_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMonsterId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, monsterId);
			}
			if (hasMonsterLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, monsterLevel);
			}
			if (hasMonsterName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, monsterName);
			}
			if (hasMonstertype) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, monstertype);
			}
		}
		public function readExternal(input:IDataInput):void {
			var monsterIdCount:uint = 0;
			var monsterLevelCount:uint = 0;
			var monsterNameCount:uint = 0;
			var monstertypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (monsterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterIdCount;
					monsterId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (monsterLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterLevelCount;
					monsterLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (monsterNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterNameCount;
					monsterName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (monstertypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monstertypeCount;
					monstertype = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
