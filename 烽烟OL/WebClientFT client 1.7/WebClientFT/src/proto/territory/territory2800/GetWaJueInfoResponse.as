package proto.territory.territory2800 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetWaJueInfoResponse extends Message implements IExternalizable {
		private var message_:String;
		public function get hasMessage():Boolean {
			return null != message_;
		}
		public function set message(value:String):void {
			message_ = value;
		}
		public function get message():String {
			return message_;
		}
		private var result_:Boolean;
		private var hasResult_:Boolean = false;
		public function get hasResult():Boolean {
			return hasResult_;
		}
		public function set result(value:Boolean):void {
			hasResult_ = true;
			result_ = value;
		}
		public function get result():Boolean {
			return result_;
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
		private var runningTask_:Boolean;
		private var hasRunningTask_:Boolean = false;
		public function get hasRunningTask():Boolean {
			return hasRunningTask_;
		}
		public function set runningTask(value:Boolean):void {
			hasRunningTask_ = true;
			runningTask_ = value;
		}
		public function get runningTask():Boolean {
			return runningTask_;
		}
		private var sptimes_:int;
		private var hasSptimes_:Boolean = false;
		public function get hasSptimes():Boolean {
			return hasSptimes_;
		}
		public function set sptimes(value:int):void {
			hasSptimes_ = true;
			sptimes_ = value;
		}
		public function get sptimes():int {
			return sptimes_;
		}
		private var coinbound_:int;
		private var hasCoinbound_:Boolean = false;
		public function get hasCoinbound():Boolean {
			return hasCoinbound_;
		}
		public function set coinbound(value:int):void {
			hasCoinbound_ = true;
			coinbound_ = value;
		}
		public function get coinbound():int {
			return coinbound_;
		}
		private var goldreq_:int;
		private var hasGoldreq_:Boolean = false;
		public function get hasGoldreq():Boolean {
			return hasGoldreq_;
		}
		public function set goldreq(value:int):void {
			hasGoldreq_ = true;
			goldreq_ = value;
		}
		public function get goldreq():int {
			return goldreq_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasRemainTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, remainTime);
			}
			if (hasRunningTask) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_BOOL(output, runningTask);
			}
			if (hasSptimes) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, sptimes);
			}
			if (hasCoinbound) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, coinbound);
			}
			if (hasGoldreq) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, goldreq);
			}
		}
		public function readExternal(input:IDataInput):void {
			var messageCount:uint = 0;
			var resultCount:uint = 0;
			var remainTimeCount:uint = 0;
			var runningTaskCount:uint = 0;
			var sptimesCount:uint = 0;
			var coinboundCount:uint = 0;
			var goldreqCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (remainTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainTimeCount;
					remainTime = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (runningTaskCount != 0) {
						throw new IOError('Bad data format.');
					}
					++runningTaskCount;
					runningTask = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 5:
					if (sptimesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sptimesCount;
					sptimes = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (coinboundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinboundCount;
					coinbound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (goldreqCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldreqCount;
					goldreq = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
