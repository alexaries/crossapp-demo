package proto.pratice.immediateFinishPratice {
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
		private var totalExp_:int;
		private var hasTotalExp_:Boolean = false;
		public function get hasTotalExp():Boolean {
			return hasTotalExp_;
		}
		public function set totalExp(value:int):void {
			hasTotalExp_ = true;
			totalExp_ = value;
		}
		public function get totalExp():int {
			return totalExp_;
		}
		private var countHit_:int;
		private var hasCountHit_:Boolean = false;
		public function get hasCountHit():Boolean {
			return hasCountHit_;
		}
		public function set countHit(value:int):void {
			hasCountHit_ = true;
			countHit_ = value;
		}
		public function get countHit():int {
			return countHit_;
		}
		private var gold_:int;
		private var hasGold_:Boolean = false;
		public function get hasGold():Boolean {
			return hasGold_;
		}
		public function set gold(value:int):void {
			hasGold_ = true;
			gold_ = value;
		}
		public function get gold():int {
			return gold_;
		}
		private var coupon_:int;
		private var hasCoupon_:Boolean = false;
		public function get hasCoupon():Boolean {
			return hasCoupon_;
		}
		public function set coupon(value:int):void {
			hasCoupon_ = true;
			coupon_ = value;
		}
		public function get coupon():int {
			return coupon_;
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
			if (hasTotalExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, totalExp);
			}
			if (hasCountHit) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, countHit);
			}
			if (hasGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, gold);
			}
			if (hasCoupon) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, coupon);
			}
			if (hasStatus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, status);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, level);
			}
		}
		public function readExternal(input:IDataInput):void {
			var monsterNameCount:uint = 0;
			var totalExpCount:uint = 0;
			var countHitCount:uint = 0;
			var goldCount:uint = 0;
			var couponCount:uint = 0;
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
					if (totalExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++totalExpCount;
					totalExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (countHitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++countHitCount;
					countHit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (goldCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldCount;
					gold = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (couponCount != 0) {
						throw new IOError('Bad data format.');
					}
					++couponCount;
					coupon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (statusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++statusCount;
					status = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
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
