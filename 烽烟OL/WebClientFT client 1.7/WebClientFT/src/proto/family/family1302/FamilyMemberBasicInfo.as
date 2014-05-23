package proto.family.family1302 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FamilyMemberBasicInfo extends Message implements IExternalizable {
		private var memberId_:int;
		private var hasMemberId_:Boolean = false;
		public function get hasMemberId():Boolean {
			return hasMemberId_;
		}
		public function set memberId(value:int):void {
			hasMemberId_ = true;
			memberId_ = value;
		}
		public function get memberId():int {
			return memberId_;
		}
		private var memberName_:String;
		public function get hasMemberName():Boolean {
			return null != memberName_;
		}
		public function set memberName(value:String):void {
			memberName_ = value;
		}
		public function get memberName():String {
			return memberName_;
		}
		private var memberJobs_:int;
		private var hasMemberJobs_:Boolean = false;
		public function get hasMemberJobs():Boolean {
			return hasMemberJobs_;
		}
		public function set memberJobs(value:int):void {
			hasMemberJobs_ = true;
			memberJobs_ = value;
		}
		public function get memberJobs():int {
			return memberJobs_;
		}
		private var memberLevel_:int;
		private var hasMemberLevel_:Boolean = false;
		public function get hasMemberLevel():Boolean {
			return hasMemberLevel_;
		}
		public function set memberLevel(value:int):void {
			hasMemberLevel_ = true;
			memberLevel_ = value;
		}
		public function get memberLevel():int {
			return memberLevel_;
		}
		private var memberContribution_:int;
		private var hasMemberContribution_:Boolean = false;
		public function get hasMemberContribution():Boolean {
			return hasMemberContribution_;
		}
		public function set memberContribution(value:int):void {
			hasMemberContribution_ = true;
			memberContribution_ = value;
		}
		public function get memberContribution():int {
			return memberContribution_;
		}
		private var lastOnLineTime_:String;
		public function get hasLastOnLineTime():Boolean {
			return null != lastOnLineTime_;
		}
		public function set lastOnLineTime(value:String):void {
			lastOnLineTime_ = value;
		}
		public function get lastOnLineTime():String {
			return lastOnLineTime_;
		}
		private var isOnLine_:int;
		private var hasIsOnLine_:Boolean = false;
		public function get hasIsOnLine():Boolean {
			return hasIsOnLine_;
		}
		public function set isOnLine(value:int):void {
			hasIsOnLine_ = true;
			isOnLine_ = value;
		}
		public function get isOnLine():int {
			return isOnLine_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMemberId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, memberId);
			}
			if (hasMemberName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, memberName);
			}
			if (hasMemberJobs) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, memberJobs);
			}
			if (hasMemberLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, memberLevel);
			}
			if (hasMemberContribution) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, memberContribution);
			}
			if (hasLastOnLineTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, lastOnLineTime);
			}
			if (hasIsOnLine) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, isOnLine);
			}
		}
		public function readExternal(input:IDataInput):void {
			var memberIdCount:uint = 0;
			var memberNameCount:uint = 0;
			var memberJobsCount:uint = 0;
			var memberLevelCount:uint = 0;
			var memberContributionCount:uint = 0;
			var lastOnLineTimeCount:uint = 0;
			var isOnLineCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (memberIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberIdCount;
					memberId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (memberNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberNameCount;
					memberName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (memberJobsCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberJobsCount;
					memberJobs = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (memberLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberLevelCount;
					memberLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (memberContributionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++memberContributionCount;
					memberContribution = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (lastOnLineTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lastOnLineTimeCount;
					lastOnLineTime = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (isOnLineCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isOnLineCount;
					isOnLine = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
