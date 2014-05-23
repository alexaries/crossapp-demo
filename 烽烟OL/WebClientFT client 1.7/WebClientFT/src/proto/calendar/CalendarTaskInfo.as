package proto.calendar {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.calendar.Bound;
	import proto.calendar.Schedule;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CalendarTaskInfo extends Message implements IExternalizable {
		private var totalLivenessNum_:int;
		private var hasTotalLivenessNum_:Boolean = false;
		public function get hasTotalLivenessNum():Boolean {
			return hasTotalLivenessNum_;
		}
		public function set totalLivenessNum(value:int):void {
			hasTotalLivenessNum_ = true;
			totalLivenessNum_ = value;
		}
		public function get totalLivenessNum():int {
			return totalLivenessNum_;
		}
		[ArrayElementType("proto.calendar.Schedule")]
		public var unfinished:Array = [];
		[ArrayElementType("proto.calendar.Schedule")]
		public var finished:Array = [];
		[ArrayElementType("proto.calendar.Bound")]
		public var scheduleBound:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasTotalLivenessNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, totalLivenessNum);
			}
			for (var unfinishedIndex:uint = 0; unfinishedIndex < unfinished.length; ++unfinishedIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, unfinished[unfinishedIndex]);
			}
			for (var finishedIndex:uint = 0; finishedIndex < finished.length; ++finishedIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, finished[finishedIndex]);
			}
			for (var scheduleBoundIndex:uint = 0; scheduleBoundIndex < scheduleBound.length; ++scheduleBoundIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, scheduleBound[scheduleBoundIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var totalLivenessNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (totalLivenessNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++totalLivenessNumCount;
					totalLivenessNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					unfinished.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.calendar.Schedule));
					break;
				case 3:
					finished.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.calendar.Schedule));
					break;
				case 4:
					scheduleBound.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.calendar.Bound));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
