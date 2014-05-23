package proto.commission.commission1204 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class goldConInfo extends Message implements IExternalizable {
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
		private var goldNum_:int;
		private var hasGoldNum_:Boolean = false;
		public function get hasGoldNum():Boolean {
			return hasGoldNum_;
		}
		public function set goldNum(value:int):void {
			hasGoldNum_ = true;
			goldNum_ = value;
		}
		public function get goldNum():int {
			return goldNum_;
		}
		private var ownerId_:int;
		private var hasOwnerId_:Boolean = false;
		public function get hasOwnerId():Boolean {
			return hasOwnerId_;
		}
		public function set ownerId(value:int):void {
			hasOwnerId_ = true;
			ownerId_ = value;
		}
		public function get ownerId():int {
			return ownerId_;
		}
		private var coinPrice_:int;
		private var hasCoinPrice_:Boolean = false;
		public function get hasCoinPrice():Boolean {
			return hasCoinPrice_;
		}
		public function set coinPrice(value:int):void {
			hasCoinPrice_ = true;
			coinPrice_ = value;
		}
		public function get coinPrice():int {
			return coinPrice_;
		}
		private var operationTime_:String;
		public function get hasOperationTime():Boolean {
			return null != operationTime_;
		}
		public function set operationTime(value:String):void {
			operationTime_ = value;
		}
		public function get operationTime():String {
			return operationTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasConsignmentId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, consignmentId);
			}
			if (hasGoldNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, goldNum);
			}
			if (hasOwnerId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, ownerId);
			}
			if (hasCoinPrice) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, coinPrice);
			}
			if (hasOperationTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, operationTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var consignmentIdCount:uint = 0;
			var goldNumCount:uint = 0;
			var ownerIdCount:uint = 0;
			var coinPriceCount:uint = 0;
			var operationTimeCount:uint = 0;
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
					if (goldNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldNumCount;
					goldNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (ownerIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++ownerIdCount;
					ownerId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (coinPriceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinPriceCount;
					coinPrice = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (operationTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++operationTimeCount;
					operationTime = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
