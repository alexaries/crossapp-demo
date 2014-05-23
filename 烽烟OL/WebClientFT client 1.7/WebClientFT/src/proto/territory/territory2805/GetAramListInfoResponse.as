package proto.territory.territory2805 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.territory.territory2805.PetAramInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetAramListInfoResponse extends Message implements IExternalizable {
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
		private var roleRunningFlag_:Boolean;
		private var hasRoleRunningFlag_:Boolean = false;
		public function get hasRoleRunningFlag():Boolean {
			return hasRoleRunningFlag_;
		}
		public function set roleRunningFlag(value:Boolean):void {
			hasRoleRunningFlag_ = true;
			roleRunningFlag_ = value;
		}
		public function get roleRunningFlag():Boolean {
			return roleRunningFlag_;
		}
		private var roleRunTime_:int;
		private var hasRoleRunTime_:Boolean = false;
		public function get hasRoleRunTime():Boolean {
			return hasRoleRunTime_;
		}
		public function set roleRunTime(value:int):void {
			hasRoleRunTime_ = true;
			roleRunTime_ = value;
		}
		public function get roleRunTime():int {
			return roleRunTime_;
		}
		[ArrayElementType("proto.territory.territory2805.PetAramInfo")]
		public var petAramInfo:Array = [];
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
		private var expbound_:int;
		private var hasExpbound_:Boolean = false;
		public function get hasExpbound():Boolean {
			return hasExpbound_;
		}
		public function set expbound(value:int):void {
			hasExpbound_ = true;
			expbound_ = value;
		}
		public function get expbound():int {
			return expbound_;
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
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasRoleRunningFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_BOOL(output, roleRunningFlag);
			}
			if (hasRoleRunTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, roleRunTime);
			}
			for (var petAramInfoIndex:uint = 0; petAramInfoIndex < petAramInfo.length; ++petAramInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, petAramInfo[petAramInfoIndex]);
			}
			if (hasSptimes) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, sptimes);
			}
			if (hasExpbound) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, expbound);
			}
			if (hasGoldreq) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, goldreq);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var roleRunningFlagCount:uint = 0;
			var roleRunTimeCount:uint = 0;
			var sptimesCount:uint = 0;
			var expboundCount:uint = 0;
			var goldreqCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (roleRunningFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleRunningFlagCount;
					roleRunningFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 4:
					if (roleRunTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleRunTimeCount;
					roleRunTime = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					petAramInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.territory.territory2805.PetAramInfo));
					break;
				case 6:
					if (sptimesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sptimesCount;
					sptimes = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (expboundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++expboundCount;
					expbound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
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
