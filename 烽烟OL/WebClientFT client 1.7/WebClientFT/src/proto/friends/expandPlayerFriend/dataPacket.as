package proto.friends.expandPlayerFriend {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var friendCount_:int;
		private var hasFriendCount_:Boolean = false;
		public function get hasFriendCount():Boolean {
			return hasFriendCount_;
		}
		public function set friendCount(value:int):void {
			hasFriendCount_ = true;
			friendCount_ = value;
		}
		public function get friendCount():int {
			return friendCount_;
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
		public function writeExternal(output:IDataOutput):void {
			if (hasFriendCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, friendCount);
			}
			if (hasGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, gold);
			}
			if (hasCoupon) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, coupon);
			}
		}
		public function readExternal(input:IDataInput):void {
			var friendCountCount:uint = 0;
			var goldCount:uint = 0;
			var couponCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (friendCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++friendCountCount;
					friendCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (goldCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldCount;
					gold = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (couponCount != 0) {
						throw new IOError('Bad data format.');
					}
					++couponCount;
					coupon = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
