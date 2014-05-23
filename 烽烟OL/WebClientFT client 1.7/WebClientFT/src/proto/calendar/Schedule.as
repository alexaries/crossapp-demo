package proto.calendar {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	[Bindable]
	public final class Schedule extends Message implements IExternalizable {
		private var scheduleId_:int;
		private var hasScheduleId_:Boolean = false;
		public function get hasScheduleId():Boolean {
			return hasScheduleId_;
		}
		public function set scheduleId(value:int):void {
			hasScheduleId_ = true;
			scheduleId_ = value;
		}
		public function get scheduleId():int {
			return scheduleId_;
		}
		private var desc_:String;
		public function get hasDesc():Boolean {
			return null != desc_;
		}
		public function set desc(value:String):void {
			desc_ = value;
		}
		public function get desc():String {
			return desc_;
		}
		private var now_:int;
		private var hasNow_:Boolean = false;
		public function get hasNow():Boolean {
			return hasNow_;
		}
		public function set now(value:int):void {
			hasNow_ = true;
			now_ = value;
		}
		public function get now():int {
			return now_;
		}
		private var total_:int;
		private var hasTotal_:Boolean = false;
		public function get hasTotal():Boolean {
			return hasTotal_;
		}
		public function set total(value:int):void {
			hasTotal_ = true;
			total_ = value;
		}
		public function get total():int {
			return total_;
		}
		private var activity_:int;
		private var hasActivity_:Boolean = false;
		public function get hasActivity():Boolean {
			return hasActivity_;
		}
		public function set activity(value:int):void {
			hasActivity_ = true;
			activity_ = value;
		}
		public function get activity():int {
			return activity_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasScheduleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, scheduleId);
			}
			if (hasDesc) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, desc);
			}
			if (hasNow) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, now);
			}
			if (hasTotal) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, total);
			}
			if (hasActivity) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, activity);
			}
		}
		public function readExternal(input:IDataInput):void {
			var scheduleIdCount:uint = 0;
			var descCount:uint = 0;
			var nowCount:uint = 0;
			var totalCount:uint = 0;
			var activityCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (scheduleIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++scheduleIdCount;
					scheduleId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (descCount != 0) {
						throw new IOError('Bad data format.');
					}
					++descCount;
					desc = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (nowCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nowCount;
					now = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (totalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++totalCount;
					total = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (activityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++activityCount;
					activity = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
