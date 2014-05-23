package proto.family.family1301 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FamilyInfo extends Message implements IExternalizable {
		private var familyId_:int;
		private var hasFamilyId_:Boolean = false;
		public function get hasFamilyId():Boolean {
			return hasFamilyId_;
		}
		public function set familyId(value:int):void {
			hasFamilyId_ = true;
			familyId_ = value;
		}
		public function get familyId():int {
			return familyId_;
		}
		private var familyName_:String;
		public function get hasFamilyName():Boolean {
			return null != familyName_;
		}
		public function set familyName(value:String):void {
			familyName_ = value;
		}
		public function get familyName():String {
			return familyName_;
		}
		private var familyLevel_:int;
		private var hasFamilyLevel_:Boolean = false;
		public function get hasFamilyLevel():Boolean {
			return hasFamilyLevel_;
		}
		public function set familyLevel(value:int):void {
			hasFamilyLevel_ = true;
			familyLevel_ = value;
		}
		public function get familyLevel():int {
			return familyLevel_;
		}
		private var familyLeader_:String;
		public function get hasFamilyLeader():Boolean {
			return null != familyLeader_;
		}
		public function set familyLeader(value:String):void {
			familyLeader_ = value;
		}
		public function get familyLeader():String {
			return familyLeader_;
		}
		private var curFamilyNum_:int;
		private var hasCurFamilyNum_:Boolean = false;
		public function get hasCurFamilyNum():Boolean {
			return hasCurFamilyNum_;
		}
		public function set curFamilyNum(value:int):void {
			hasCurFamilyNum_ = true;
			curFamilyNum_ = value;
		}
		public function get curFamilyNum():int {
			return curFamilyNum_;
		}
		private var maxFamilyNum_:int;
		private var hasMaxFamilyNum_:Boolean = false;
		public function get hasMaxFamilyNum():Boolean {
			return hasMaxFamilyNum_;
		}
		public function set maxFamilyNum(value:int):void {
			hasMaxFamilyNum_ = true;
			maxFamilyNum_ = value;
		}
		public function get maxFamilyNum():int {
			return maxFamilyNum_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasFamilyId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, familyId);
			}
			if (hasFamilyName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, familyName);
			}
			if (hasFamilyLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, familyLevel);
			}
			if (hasFamilyLeader) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, familyLeader);
			}
			if (hasCurFamilyNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, curFamilyNum);
			}
			if (hasMaxFamilyNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, maxFamilyNum);
			}
		}
		public function readExternal(input:IDataInput):void {
			var familyIdCount:uint = 0;
			var familyNameCount:uint = 0;
			var familyLevelCount:uint = 0;
			var familyLeaderCount:uint = 0;
			var curFamilyNumCount:uint = 0;
			var maxFamilyNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (familyIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyIdCount;
					familyId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (familyNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyNameCount;
					familyName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (familyLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyLevelCount;
					familyLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (familyLeaderCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyLeaderCount;
					familyLeader = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (curFamilyNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curFamilyNumCount;
					curFamilyNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (maxFamilyNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxFamilyNumCount;
					maxFamilyNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
