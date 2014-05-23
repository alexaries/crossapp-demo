package proto.pratice.restOperate {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var hp_:int;
		private var hasHp_:Boolean = false;
		public function get hasHp():Boolean {
			return hasHp_;
		}
		public function set hp(value:int):void {
			hasHp_ = true;
			hp_ = value;
		}
		public function get hp():int {
			return hp_;
		}
		private var mp_:int;
		private var hasMp_:Boolean = false;
		public function get hasMp():Boolean {
			return hasMp_;
		}
		public function set mp(value:int):void {
			hasMp_ = true;
			mp_ = value;
		}
		public function get mp():int {
			return mp_;
		}
		private var energy_:int;
		private var hasEnergy_:Boolean = false;
		public function get hasEnergy():Boolean {
			return hasEnergy_;
		}
		public function set energy(value:int):void {
			hasEnergy_ = true;
			energy_ = value;
		}
		public function get energy():int {
			return energy_;
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
		private var coin_:int;
		private var hasCoin_:Boolean = false;
		public function get hasCoin():Boolean {
			return hasCoin_;
		}
		public function set coin(value:int):void {
			hasCoin_ = true;
			coin_ = value;
		}
		public function get coin():int {
			return coin_;
		}
		private var type_:String;
		public function get hasType():Boolean {
			return null != type_;
		}
		public function set type(value:String):void {
			type_ = value;
		}
		public function get type():String {
			return type_;
		}
		private var count_:int;
		private var hasCount_:Boolean = false;
		public function get hasCount():Boolean {
			return hasCount_;
		}
		public function set count(value:int):void {
			hasCount_ = true;
			count_ = value;
		}
		public function get count():int {
			return count_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, hp);
			}
			if (hasMp) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, mp);
			}
			if (hasEnergy) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, energy);
			}
			if (hasGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, gold);
			}
			if (hasCoupon) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, coupon);
			}
			if (hasCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, coin);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, type);
			}
			if (hasCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, count);
			}
		}
		public function readExternal(input:IDataInput):void {
			var hpCount:uint = 0;
			var mpCount:uint = 0;
			var energyCount:uint = 0;
			var goldCount:uint = 0;
			var couponCount:uint = 0;
			var coinCount:uint = 0;
			var typeCount:uint = 0;
			var countCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (hpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hpCount;
					hp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (mpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mpCount;
					mp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (energyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++energyCount;
					energy = ReadUtils.read_TYPE_INT32(input);
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
					if (coinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinCount;
					coin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (countCount != 0) {
						throw new IOError('Bad data format.');
					}
					++countCount;
					count = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
