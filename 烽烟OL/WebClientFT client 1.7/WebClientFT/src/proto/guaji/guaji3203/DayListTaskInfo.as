package proto.guaji.guaji3203 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.guaji.guaji3203.RewardInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class DayListTaskInfo extends Message implements IExternalizable {
		private var taskId_:int;
		private var hasTaskId_:Boolean = false;
		public function get hasTaskId():Boolean {
			return hasTaskId_;
		}
		public function set taskId(value:int):void {
			hasTaskId_ = true;
			taskId_ = value;
		}
		public function get taskId():int {
			return taskId_;
		}
		private var isCompleteFlag_:Boolean;
		private var hasIsCompleteFlag_:Boolean = false;
		public function get hasIsCompleteFlag():Boolean {
			return hasIsCompleteFlag_;
		}
		public function set isCompleteFlag(value:Boolean):void {
			hasIsCompleteFlag_ = true;
			isCompleteFlag_ = value;
		}
		public function get isCompleteFlag():Boolean {
			return isCompleteFlag_;
		}
		private var icon_:String;
		public function get hasIcon():Boolean {
			return null != icon_;
		}
		public function set icon(value:String):void {
			icon_ = value;
		}
		public function get icon():String {
			return icon_;
		}
		private var taskDes_:String;
		public function get hasTaskDes():Boolean {
			return null != taskDes_;
		}
		public function set taskDes(value:String):void {
			taskDes_ = value;
		}
		public function get taskDes():String {
			return taskDes_;
		}
		private var isObtainFlag_:Boolean;
		private var hasIsObtainFlag_:Boolean = false;
		public function get hasIsObtainFlag():Boolean {
			return hasIsObtainFlag_;
		}
		public function set isObtainFlag(value:Boolean):void {
			hasIsObtainFlag_ = true;
			isObtainFlag_ = value;
		}
		public function get isObtainFlag():Boolean {
			return isObtainFlag_;
		}
		[ArrayElementType("proto.guaji.guaji3203.RewardInfo")]
		public var rewardInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasTaskId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, taskId);
			}
			if (hasIsCompleteFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, isCompleteFlag);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, icon);
			}
			if (hasTaskDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, taskDes);
			}
			if (hasIsObtainFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_BOOL(output, isObtainFlag);
			}
			for (var rewardInfoIndex:uint = 0; rewardInfoIndex < rewardInfo.length; ++rewardInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, rewardInfo[rewardInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var taskIdCount:uint = 0;
			var isCompleteFlagCount:uint = 0;
			var iconCount:uint = 0;
			var taskDesCount:uint = 0;
			var isObtainFlagCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (taskIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskIdCount;
					taskId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (isCompleteFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isCompleteFlagCount;
					isCompleteFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (taskDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskDesCount;
					taskDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (isObtainFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isObtainFlagCount;
					isObtainFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 6:
					rewardInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.guaji.guaji3203.RewardInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
