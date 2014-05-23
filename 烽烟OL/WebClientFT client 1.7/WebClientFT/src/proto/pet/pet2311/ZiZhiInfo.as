package proto.pet.pet2311 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ZiZhiInfo extends Message implements IExternalizable {
		private var curZiLi_:int;
		private var hasCurZiLi_:Boolean = false;
		public function get hasCurZiLi():Boolean {
			return hasCurZiLi_;
		}
		public function set curZiLi(value:int):void {
			hasCurZiLi_ = true;
			curZiLi_ = value;
		}
		public function get curZiLi():int {
			return curZiLi_;
		}
		private var maxZiLi_:int;
		private var hasMaxZiLi_:Boolean = false;
		public function get hasMaxZiLi():Boolean {
			return hasMaxZiLi_;
		}
		public function set maxZiLi(value:int):void {
			hasMaxZiLi_ = true;
			maxZiLi_ = value;
		}
		public function get maxZiLi():int {
			return maxZiLi_;
		}
		private var curZiZhi_:int;
		private var hasCurZiZhi_:Boolean = false;
		public function get hasCurZiZhi():Boolean {
			return hasCurZiZhi_;
		}
		public function set curZiZhi(value:int):void {
			hasCurZiZhi_ = true;
			curZiZhi_ = value;
		}
		public function get curZiZhi():int {
			return curZiZhi_;
		}
		private var maxZiZhi_:int;
		private var hasMaxZiZhi_:Boolean = false;
		public function get hasMaxZiZhi():Boolean {
			return hasMaxZiZhi_;
		}
		public function set maxZiZhi(value:int):void {
			hasMaxZiZhi_ = true;
			maxZiZhi_ = value;
		}
		public function get maxZiZhi():int {
			return maxZiZhi_;
		}
		private var curZiNai_:int;
		private var hasCurZiNai_:Boolean = false;
		public function get hasCurZiNai():Boolean {
			return hasCurZiNai_;
		}
		public function set curZiNai(value:int):void {
			hasCurZiNai_ = true;
			curZiNai_ = value;
		}
		public function get curZiNai():int {
			return curZiNai_;
		}
		private var maxZiNai_:int;
		private var hasMaxZiNai_:Boolean = false;
		public function get hasMaxZiNai():Boolean {
			return hasMaxZiNai_;
		}
		public function set maxZiNai(value:int):void {
			hasMaxZiNai_ = true;
			maxZiNai_ = value;
		}
		public function get maxZiNai():int {
			return maxZiNai_;
		}
		private var curZiMin_:int;
		private var hasCurZiMin_:Boolean = false;
		public function get hasCurZiMin():Boolean {
			return hasCurZiMin_;
		}
		public function set curZiMin(value:int):void {
			hasCurZiMin_ = true;
			curZiMin_ = value;
		}
		public function get curZiMin():int {
			return curZiMin_;
		}
		private var maxZiMin_:int;
		private var hasMaxZiMin_:Boolean = false;
		public function get hasMaxZiMin():Boolean {
			return hasMaxZiMin_;
		}
		public function set maxZiMin(value:int):void {
			hasMaxZiMin_ = true;
			maxZiMin_ = value;
		}
		public function get maxZiMin():int {
			return maxZiMin_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCurZiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, curZiLi);
			}
			if (hasMaxZiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, maxZiLi);
			}
			if (hasCurZiZhi) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curZiZhi);
			}
			if (hasMaxZiZhi) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, maxZiZhi);
			}
			if (hasCurZiNai) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, curZiNai);
			}
			if (hasMaxZiNai) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, maxZiNai);
			}
			if (hasCurZiMin) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, curZiMin);
			}
			if (hasMaxZiMin) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, maxZiMin);
			}
		}
		public function readExternal(input:IDataInput):void {
			var curZiLiCount:uint = 0;
			var maxZiLiCount:uint = 0;
			var curZiZhiCount:uint = 0;
			var maxZiZhiCount:uint = 0;
			var curZiNaiCount:uint = 0;
			var maxZiNaiCount:uint = 0;
			var curZiMinCount:uint = 0;
			var maxZiMinCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (curZiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curZiLiCount;
					curZiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (maxZiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxZiLiCount;
					maxZiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curZiZhiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curZiZhiCount;
					curZiZhi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (maxZiZhiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxZiZhiCount;
					maxZiZhi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (curZiNaiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curZiNaiCount;
					curZiNai = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (maxZiNaiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxZiNaiCount;
					maxZiNai = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (curZiMinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curZiMinCount;
					curZiMin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (maxZiMinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxZiMinCount;
					maxZiMin = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
