package proto.task.task1404 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ProcessInfo extends Message implements IExternalizable {
		private var questGoalId_:int;
		private var hasQuestGoalId_:Boolean = false;
		public function get hasQuestGoalId():Boolean {
			return hasQuestGoalId_;
		}
		public function set questGoalId(value:int):void {
			hasQuestGoalId_ = true;
			questGoalId_ = value;
		}
		public function get questGoalId():int {
			return questGoalId_;
		}
		private var requireNum_:int;
		private var hasRequireNum_:Boolean = false;
		public function get hasRequireNum():Boolean {
			return hasRequireNum_;
		}
		public function set requireNum(value:int):void {
			hasRequireNum_ = true;
			requireNum_ = value;
		}
		public function get requireNum():int {
			return requireNum_;
		}
		private var achieveNum_:int;
		private var hasAchieveNum_:Boolean = false;
		public function get hasAchieveNum():Boolean {
			return hasAchieveNum_;
		}
		public function set achieveNum(value:int):void {
			hasAchieveNum_ = true;
			achieveNum_ = value;
		}
		public function get achieveNum():int {
			return achieveNum_;
		}
		private var trackDesc_:String;
		public function get hasTrackDesc():Boolean {
			return null != trackDesc_;
		}
		public function set trackDesc(value:String):void {
			trackDesc_ = value;
		}
		public function get trackDesc():String {
			return trackDesc_;
		}
		private var trackID_:int;
		private var hasTrackID_:Boolean = false;
		public function get hasTrackID():Boolean {
			return hasTrackID_;
		}
		public function set trackID(value:int):void {
			hasTrackID_ = true;
			trackID_ = value;
		}
		public function get trackID():int {
			return trackID_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasQuestGoalId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, questGoalId);
			}
			if (hasRequireNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, requireNum);
			}
			if (hasAchieveNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, achieveNum);
			}
			if (hasTrackDesc) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, trackDesc);
			}
			if (hasTrackID) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, trackID);
			}
		}
		public function readExternal(input:IDataInput):void {
			var questGoalIdCount:uint = 0;
			var requireNumCount:uint = 0;
			var achieveNumCount:uint = 0;
			var trackDescCount:uint = 0;
			var trackIDCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (questGoalIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++questGoalIdCount;
					questGoalId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (requireNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++requireNumCount;
					requireNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (achieveNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++achieveNumCount;
					achieveNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (trackDescCount != 0) {
						throw new IOError('Bad data format.');
					}
					++trackDescCount;
					trackDesc = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (trackIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++trackIDCount;
					trackID = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
