package proto.blacksmith.blacksmith2103 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.blacksmith.blacksmith2103.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CastingInfo extends Message implements IExternalizable {
		private var curGrowing_:int;
		private var hasCurGrowing_:Boolean = false;
		public function get hasCurGrowing():Boolean {
			return hasCurGrowing_;
		}
		public function set curGrowing(value:int):void {
			hasCurGrowing_ = true;
			curGrowing_ = value;
		}
		public function get curGrowing():int {
			return curGrowing_;
		}
		private var maxGrowing_:int;
		private var hasMaxGrowing_:Boolean = false;
		public function get hasMaxGrowing():Boolean {
			return hasMaxGrowing_;
		}
		public function set maxGrowing(value:int):void {
			hasMaxGrowing_ = true;
			maxGrowing_ = value;
		}
		public function get maxGrowing():int {
			return maxGrowing_;
		}
		private var curStrengthen_:int;
		private var hasCurStrengthen_:Boolean = false;
		public function get hasCurStrengthen():Boolean {
			return hasCurStrengthen_;
		}
		public function set curStrengthen(value:int):void {
			hasCurStrengthen_ = true;
			curStrengthen_ = value;
		}
		public function get curStrengthen():int {
			return curStrengthen_;
		}
		private var maxStrengthen_:int;
		private var hasMaxStrengthen_:Boolean = false;
		public function get hasMaxStrengthen():Boolean {
			return hasMaxStrengthen_;
		}
		public function set maxStrengthen(value:int):void {
			hasMaxStrengthen_ = true;
			maxStrengthen_ = value;
		}
		public function get maxStrengthen():int {
			return maxStrengthen_;
		}
		private var curSuccessRate_:int;
		private var hasCurSuccessRate_:Boolean = false;
		public function get hasCurSuccessRate():Boolean {
			return hasCurSuccessRate_;
		}
		public function set curSuccessRate(value:int):void {
			hasCurSuccessRate_ = true;
			curSuccessRate_ = value;
		}
		public function get curSuccessRate():int {
			return curSuccessRate_;
		}
		private var maxSuccessRate_:int;
		private var hasMaxSuccessRate_:Boolean = false;
		public function get hasMaxSuccessRate():Boolean {
			return hasMaxSuccessRate_;
		}
		public function set maxSuccessRate(value:int):void {
			hasMaxSuccessRate_ = true;
			maxSuccessRate_ = value;
		}
		public function get maxSuccessRate():int {
			return maxSuccessRate_;
		}
		private var castingItemInfo_:proto.blacksmith.blacksmith2103.ItemsInfo;
		public function get hasCastingItemInfo():Boolean {
			return null != castingItemInfo_;
		}
		public function set castingItemInfo(value:proto.blacksmith.blacksmith2103.ItemsInfo):void {
			castingItemInfo_ = value;
		}
		public function get castingItemInfo():proto.blacksmith.blacksmith2103.ItemsInfo {
			return castingItemInfo_;
		}
		private var consumeItemInfo_:proto.blacksmith.blacksmith2103.ItemsInfo;
		public function get hasConsumeItemInfo():Boolean {
			return null != consumeItemInfo_;
		}
		public function set consumeItemInfo(value:proto.blacksmith.blacksmith2103.ItemsInfo):void {
			consumeItemInfo_ = value;
		}
		public function get consumeItemInfo():proto.blacksmith.blacksmith2103.ItemsInfo {
			return consumeItemInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCurGrowing) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, curGrowing);
			}
			if (hasMaxGrowing) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, maxGrowing);
			}
			if (hasCurStrengthen) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curStrengthen);
			}
			if (hasMaxStrengthen) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, maxStrengthen);
			}
			if (hasCurSuccessRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, curSuccessRate);
			}
			if (hasMaxSuccessRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, maxSuccessRate);
			}
			if (hasCastingItemInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_MESSAGE(output, castingItemInfo);
			}
			if (hasConsumeItemInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_MESSAGE(output, consumeItemInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var curGrowingCount:uint = 0;
			var maxGrowingCount:uint = 0;
			var curStrengthenCount:uint = 0;
			var maxStrengthenCount:uint = 0;
			var curSuccessRateCount:uint = 0;
			var maxSuccessRateCount:uint = 0;
			var castingItemInfoCount:uint = 0;
			var consumeItemInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (curGrowingCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curGrowingCount;
					curGrowing = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (maxGrowingCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxGrowingCount;
					maxGrowing = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curStrengthenCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curStrengthenCount;
					curStrengthen = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (maxStrengthenCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxStrengthenCount;
					maxStrengthen = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (curSuccessRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curSuccessRateCount;
					curSuccessRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (maxSuccessRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxSuccessRateCount;
					maxSuccessRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (castingItemInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++castingItemInfoCount;
					castingItemInfo = new proto.blacksmith.blacksmith2103.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, castingItemInfo);
					break;
				case 8:
					if (consumeItemInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++consumeItemInfoCount;
					consumeItemInfo = new proto.blacksmith.blacksmith2103.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, consumeItemInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
