package proto.reward.reward2405 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ItemManInfo extends Message implements IExternalizable {
		private var status_:int;
		private var hasStatus_:Boolean = false;
		public function get hasStatus():Boolean {
			return hasStatus_;
		}
		public function set status(value:int):void {
			hasStatus_ = true;
			status_ = value;
		}
		public function get status():int {
			return status_;
		}
		private var remainTime_:int;
		private var hasRemainTime_:Boolean = false;
		public function get hasRemainTime():Boolean {
			return hasRemainTime_;
		}
		public function set remainTime(value:int):void {
			hasRemainTime_ = true;
			remainTime_ = value;
		}
		public function get remainTime():int {
			return remainTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasStatus) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, status);
			}
			if (hasRemainTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, remainTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var statusCount:uint = 0;
			var remainTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (statusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++statusCount;
					status = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (remainTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainTimeCount;
					remainTime = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
