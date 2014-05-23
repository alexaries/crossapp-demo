package proto.commission.commission1201 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ConsignmentCoinInfo extends Message implements IExternalizable {
		private var consignmentId_:int;
		private var hasConsignmentId_:Boolean = false;
		public function get hasConsignmentId():Boolean {
			return hasConsignmentId_;
		}
		public function set consignmentId(value:int):void {
			hasConsignmentId_ = true;
			consignmentId_ = value;
		}
		public function get consignmentId():int {
			return consignmentId_;
		}
		private var remainTime_:String;
		public function get hasRemainTime():Boolean {
			return null != remainTime_;
		}
		public function set remainTime(value:String):void {
			remainTime_ = value;
		}
		public function get remainTime():String {
			return remainTime_;
		}
		private var ownerName_:String;
		public function get hasOwnerName():Boolean {
			return null != ownerName_;
		}
		public function set ownerName(value:String):void {
			ownerName_ = value;
		}
		public function get ownerName():String {
			return ownerName_;
		}
		private var moneyType_:int;
		private var hasMoneyType_:Boolean = false;
		public function get hasMoneyType():Boolean {
			return hasMoneyType_;
		}
		public function set moneyType(value:int):void {
			hasMoneyType_ = true;
			moneyType_ = value;
		}
		public function get moneyType():int {
			return moneyType_;
		}
		private var moneyNum_:int;
		private var hasMoneyNum_:Boolean = false;
		public function get hasMoneyNum():Boolean {
			return hasMoneyNum_;
		}
		public function set moneyNum(value:int):void {
			hasMoneyNum_ = true;
			moneyNum_ = value;
		}
		public function get moneyNum():int {
			return moneyNum_;
		}
		private var sellMoneyNum_:int;
		private var hasSellMoneyNum_:Boolean = false;
		public function get hasSellMoneyNum():Boolean {
			return hasSellMoneyNum_;
		}
		public function set sellMoneyNum(value:int):void {
			hasSellMoneyNum_ = true;
			sellMoneyNum_ = value;
		}
		public function get sellMoneyNum():int {
			return sellMoneyNum_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasConsignmentId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, consignmentId);
			}
			if (hasRemainTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, remainTime);
			}
			if (hasOwnerName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, ownerName);
			}
			if (hasMoneyType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, moneyType);
			}
			if (hasMoneyNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, moneyNum);
			}
			if (hasSellMoneyNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, sellMoneyNum);
			}
		}
		public function readExternal(input:IDataInput):void {
			var consignmentIdCount:uint = 0;
			var remainTimeCount:uint = 0;
			var ownerNameCount:uint = 0;
			var moneyTypeCount:uint = 0;
			var moneyNumCount:uint = 0;
			var sellMoneyNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (consignmentIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++consignmentIdCount;
					consignmentId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (remainTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainTimeCount;
					remainTime = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (ownerNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++ownerNameCount;
					ownerName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (moneyTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++moneyTypeCount;
					moneyType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (moneyNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++moneyNumCount;
					moneyNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (sellMoneyNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sellMoneyNumCount;
					sellMoneyNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
