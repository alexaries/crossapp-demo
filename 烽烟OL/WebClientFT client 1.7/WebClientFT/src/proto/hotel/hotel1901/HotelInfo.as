package proto.hotel.hotel1901 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class HotelInfo extends Message implements IExternalizable {
		private var canUseTimes_:int;
		private var hasCanUseTimes_:Boolean = false;
		public function get hasCanUseTimes():Boolean {
			return hasCanUseTimes_;
		}
		public function set canUseTimes(value:int):void {
			hasCanUseTimes_ = true;
			canUseTimes_ = value;
		}
		public function get canUseTimes():int {
			return canUseTimes_;
		}
		private var coinNum_:int;
		private var hasCoinNum_:Boolean = false;
		public function get hasCoinNum():Boolean {
			return hasCoinNum_;
		}
		public function set coinNum(value:int):void {
			hasCoinNum_ = true;
			coinNum_ = value;
		}
		public function get coinNum():int {
			return coinNum_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCanUseTimes) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, canUseTimes);
			}
			if (hasCoinNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, coinNum);
			}
		}
		public function readExternal(input:IDataInput):void {
			var canUseTimesCount:uint = 0;
			var coinNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (canUseTimesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++canUseTimesCount;
					canUseTimes = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (coinNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinNumCount;
					coinNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
