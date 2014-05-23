package proto.pratice.lobbyOperate {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var status_:String;
		public function get hasStatus():Boolean {
			return null != status_;
		}
		public function set status(value:String):void {
			status_ = value;
		}
		public function get status():String {
			return status_;
		}
		private var bonusCount_:int;
		private var hasBonusCount_:Boolean = false;
		public function get hasBonusCount():Boolean {
			return hasBonusCount_;
		}
		public function set bonusCount(value:int):void {
			hasBonusCount_ = true;
			bonusCount_ = value;
		}
		public function get bonusCount():int {
			return bonusCount_;
		}
		private var startTime_:Int64;
		public function get hasStartTime():Boolean {
			return null != startTime_;
		}
		public function set startTime(value:Int64):void {
			startTime_ = value;
		}
		public function get startTime():Int64 {
			return startTime_;
		}
		private var finishTime_:Int64;
		public function get hasFinishTime():Boolean {
			return null != finishTime_;
		}
		public function set finishTime(value:Int64):void {
			finishTime_ = value;
		}
		public function get finishTime():Int64 {
			return finishTime_;
		}
		private var duration_:int;
		private var hasDuration_:Boolean = false;
		public function get hasDuration():Boolean {
			return hasDuration_;
		}
		public function set duration(value:int):void {
			hasDuration_ = true;
			duration_ = value;
		}
		public function get duration():int {
			return duration_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasStatus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, status);
			}
			if (hasBonusCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, bonusCount);
			}
			if (hasStartTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT64(output, startTime);
			}
			if (hasFinishTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT64(output, finishTime);
			}
			if (hasDuration) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, duration);
			}
		}
		public function readExternal(input:IDataInput):void {
			var statusCount:uint = 0;
			var bonusCountCount:uint = 0;
			var startTimeCount:uint = 0;
			var finishTimeCount:uint = 0;
			var durationCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (statusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++statusCount;
					status = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (bonusCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bonusCountCount;
					bonusCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (startTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++startTimeCount;
					startTime = ReadUtils.read_TYPE_INT64(input);
					break;
				case 4:
					if (finishTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++finishTimeCount;
					finishTime = ReadUtils.read_TYPE_INT64(input);
					break;
				case 5:
					if (durationCount != 0) {
						throw new IOError('Bad data format.');
					}
					++durationCount;
					duration = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
