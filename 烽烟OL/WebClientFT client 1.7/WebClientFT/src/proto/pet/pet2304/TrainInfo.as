package proto.pet.pet2304 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TrainInfo extends Message implements IExternalizable {
		private var baseLiLiang_:int;
		private var hasBaseLiLiang_:Boolean = false;
		public function get hasBaseLiLiang():Boolean {
			return hasBaseLiLiang_;
		}
		public function set baseLiLiang(value:int):void {
			hasBaseLiLiang_ = true;
			baseLiLiang_ = value;
		}
		public function get baseLiLiang():int {
			return baseLiLiang_;
		}
		private var changeLiLiang_:int;
		private var hasChangeLiLiang_:Boolean = false;
		public function get hasChangeLiLiang():Boolean {
			return hasChangeLiLiang_;
		}
		public function set changeLiLiang(value:int):void {
			hasChangeLiLiang_ = true;
			changeLiLiang_ = value;
		}
		public function get changeLiLiang():int {
			return changeLiLiang_;
		}
		private var baseZhiLi_:int;
		private var hasBaseZhiLi_:Boolean = false;
		public function get hasBaseZhiLi():Boolean {
			return hasBaseZhiLi_;
		}
		public function set baseZhiLi(value:int):void {
			hasBaseZhiLi_ = true;
			baseZhiLi_ = value;
		}
		public function get baseZhiLi():int {
			return baseZhiLi_;
		}
		private var changeZhiLi_:int;
		private var hasChangeZhiLi_:Boolean = false;
		public function get hasChangeZhiLi():Boolean {
			return hasChangeZhiLi_;
		}
		public function set changeZhiLi(value:int):void {
			hasChangeZhiLi_ = true;
			changeZhiLi_ = value;
		}
		public function get changeZhiLi():int {
			return changeZhiLi_;
		}
		private var baseNaiLi_:int;
		private var hasBaseNaiLi_:Boolean = false;
		public function get hasBaseNaiLi():Boolean {
			return hasBaseNaiLi_;
		}
		public function set baseNaiLi(value:int):void {
			hasBaseNaiLi_ = true;
			baseNaiLi_ = value;
		}
		public function get baseNaiLi():int {
			return baseNaiLi_;
		}
		private var changeNaiLi_:int;
		private var hasChangeNaiLi_:Boolean = false;
		public function get hasChangeNaiLi():Boolean {
			return hasChangeNaiLi_;
		}
		public function set changeNaiLi(value:int):void {
			hasChangeNaiLi_ = true;
			changeNaiLi_ = value;
		}
		public function get changeNaiLi():int {
			return changeNaiLi_;
		}
		private var baseMinJie_:int;
		private var hasBaseMinJie_:Boolean = false;
		public function get hasBaseMinJie():Boolean {
			return hasBaseMinJie_;
		}
		public function set baseMinJie(value:int):void {
			hasBaseMinJie_ = true;
			baseMinJie_ = value;
		}
		public function get baseMinJie():int {
			return baseMinJie_;
		}
		private var changeMinJie_:int;
		private var hasChangeMinJie_:Boolean = false;
		public function get hasChangeMinJie():Boolean {
			return hasChangeMinJie_;
		}
		public function set changeMinJie(value:int):void {
			hasChangeMinJie_ = true;
			changeMinJie_ = value;
		}
		public function get changeMinJie():int {
			return changeMinJie_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBaseLiLiang) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, baseLiLiang);
			}
			if (hasChangeLiLiang) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, changeLiLiang);
			}
			if (hasBaseZhiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, baseZhiLi);
			}
			if (hasChangeZhiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, changeZhiLi);
			}
			if (hasBaseNaiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, baseNaiLi);
			}
			if (hasChangeNaiLi) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, changeNaiLi);
			}
			if (hasBaseMinJie) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, baseMinJie);
			}
			if (hasChangeMinJie) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, changeMinJie);
			}
		}
		public function readExternal(input:IDataInput):void {
			var baseLiLiangCount:uint = 0;
			var changeLiLiangCount:uint = 0;
			var baseZhiLiCount:uint = 0;
			var changeZhiLiCount:uint = 0;
			var baseNaiLiCount:uint = 0;
			var changeNaiLiCount:uint = 0;
			var baseMinJieCount:uint = 0;
			var changeMinJieCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (baseLiLiangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseLiLiangCount;
					baseLiLiang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (changeLiLiangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++changeLiLiangCount;
					changeLiLiang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (baseZhiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseZhiLiCount;
					baseZhiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (changeZhiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++changeZhiLiCount;
					changeZhiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (baseNaiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseNaiLiCount;
					baseNaiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (changeNaiLiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++changeNaiLiCount;
					changeNaiLi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (baseMinJieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseMinJieCount;
					baseMinJie = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (changeMinJieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++changeMinJieCount;
					changeMinJie = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
