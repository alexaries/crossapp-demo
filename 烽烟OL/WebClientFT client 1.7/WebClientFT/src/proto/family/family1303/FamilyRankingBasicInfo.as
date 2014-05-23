package proto.family.family1303 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FamilyRankingBasicInfo extends Message implements IExternalizable {
		private var familyRank_:int;
		private var hasFamilyRank_:Boolean = false;
		public function get hasFamilyRank():Boolean {
			return hasFamilyRank_;
		}
		public function set familyRank(value:int):void {
			hasFamilyRank_ = true;
			familyRank_ = value;
		}
		public function get familyRank():int {
			return familyRank_;
		}
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
		private var familyScale_:int;
		private var hasFamilyScale_:Boolean = false;
		public function get hasFamilyScale():Boolean {
			return hasFamilyScale_;
		}
		public function set familyScale(value:int):void {
			hasFamilyScale_ = true;
			familyScale_ = value;
		}
		public function get familyScale():int {
			return familyScale_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasFamilyRank) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, familyRank);
			}
			if (hasFamilyId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, familyId);
			}
			if (hasFamilyName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, familyName);
			}
			if (hasFamilyLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, familyLevel);
			}
			if (hasFamilyScale) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, familyScale);
			}
		}
		public function readExternal(input:IDataInput):void {
			var familyRankCount:uint = 0;
			var familyIdCount:uint = 0;
			var familyNameCount:uint = 0;
			var familyLevelCount:uint = 0;
			var familyScaleCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (familyRankCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyRankCount;
					familyRank = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (familyIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyIdCount;
					familyId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (familyNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyNameCount;
					familyName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (familyLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyLevelCount;
					familyLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (familyScaleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyScaleCount;
					familyScale = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
