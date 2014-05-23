package proto.commission.commission1203 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Trend extends Message implements IExternalizable {
		private var recordData_:String;
		public function get hasRecordData():Boolean {
			return null != recordData_;
		}
		public function set recordData(value:String):void {
			recordData_ = value;
		}
		public function get recordData():String {
			return recordData_;
		}
		private var unitPrice_:int;
		private var hasUnitPrice_:Boolean = false;
		public function get hasUnitPrice():Boolean {
			return hasUnitPrice_;
		}
		public function set unitPrice(value:int):void {
			hasUnitPrice_ = true;
			unitPrice_ = value;
		}
		public function get unitPrice():int {
			return unitPrice_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRecordData) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, recordData);
			}
			if (hasUnitPrice) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, unitPrice);
			}
		}
		public function readExternal(input:IDataInput):void {
			var recordDataCount:uint = 0;
			var unitPriceCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (recordDataCount != 0) {
						throw new IOError('Bad data format.');
					}
					++recordDataCount;
					recordData = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (unitPriceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unitPriceCount;
					unitPrice = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
