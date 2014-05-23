package proto.scene.immediateRefreshShopItems {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.immediateRefreshShopItems.Page;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ShopInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.scene.immediateRefreshShopItems.Page")]
		public var pagedShopItems:Array = [];
		private var refreshTime_:int;
		private var hasRefreshTime_:Boolean = false;
		public function get hasRefreshTime():Boolean {
			return hasRefreshTime_;
		}
		public function set refreshTime(value:int):void {
			hasRefreshTime_ = true;
			refreshTime_ = value;
		}
		public function get refreshTime():int {
			return refreshTime_;
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
		public function writeExternal(output:IDataOutput):void {
			for (var pagedShopItemsIndex:uint = 0; pagedShopItemsIndex < pagedShopItems.length; ++pagedShopItemsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, pagedShopItems[pagedShopItemsIndex]);
			}
			if (hasRefreshTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, refreshTime);
			}
			if (hasCoupon) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, coupon);
			}
			if (hasGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, gold);
			}
		}
		public function readExternal(input:IDataInput):void {
			var refreshTimeCount:uint = 0;
			var couponCount:uint = 0;
			var goldCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					pagedShopItems.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.immediateRefreshShopItems.Page));
					break;
				case 2:
					if (refreshTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++refreshTimeCount;
					refreshTime = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (couponCount != 0) {
						throw new IOError('Bad data format.');
					}
					++couponCount;
					coupon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (goldCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldCount;
					gold = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
