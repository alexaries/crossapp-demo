package proto.task.task1421 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1421.TaskTracLinkInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TaskTracItem extends Message implements IExternalizable {
		public var taskId:int;
		private var taskState_:int;
		private var hasTaskState_:Boolean = false;
		public function get hasTaskState():Boolean {
			return hasTaskState_;
		}
		public function set taskState(value:int):void {
			hasTaskState_ = true;
			taskState_ = value;
		}
		public function get taskState():int {
			return taskState_;
		}
		private var taskAccpetNpcId_:int;
		private var hasTaskAccpetNpcId_:Boolean = false;
		public function get hasTaskAccpetNpcId():Boolean {
			return hasTaskAccpetNpcId_;
		}
		public function set taskAccpetNpcId(value:int):void {
			hasTaskAccpetNpcId_ = true;
			taskAccpetNpcId_ = value;
		}
		public function get taskAccpetNpcId():int {
			return taskAccpetNpcId_;
		}
		private var taskAccpetCityId_:int;
		private var hasTaskAccpetCityId_:Boolean = false;
		public function get hasTaskAccpetCityId():Boolean {
			return hasTaskAccpetCityId_;
		}
		public function set taskAccpetCityId(value:int):void {
			hasTaskAccpetCityId_ = true;
			taskAccpetCityId_ = value;
		}
		public function get taskAccpetCityId():int {
			return taskAccpetCityId_;
		}
		private var needNum_:int;
		private var hasNeedNum_:Boolean = false;
		public function get hasNeedNum():Boolean {
			return hasNeedNum_;
		}
		public function set needNum(value:int):void {
			hasNeedNum_ = true;
			needNum_ = value;
		}
		public function get needNum():int {
			return needNum_;
		}
		private var curNum_:int;
		private var hasCurNum_:Boolean = false;
		public function get hasCurNum():Boolean {
			return hasCurNum_;
		}
		public function set curNum(value:int):void {
			hasCurNum_ = true;
			curNum_ = value;
		}
		public function get curNum():int {
			return curNum_;
		}
		private var isTrac_:int;
		private var hasIsTrac_:Boolean = false;
		public function get hasIsTrac():Boolean {
			return hasIsTrac_;
		}
		public function set isTrac(value:int):void {
			hasIsTrac_ = true;
			isTrac_ = value;
		}
		public function get isTrac():int {
			return isTrac_;
		}
		private var needLv_:int;
		private var hasNeedLv_:Boolean = false;
		public function get hasNeedLv():Boolean {
			return hasNeedLv_;
		}
		public function set needLv(value:int):void {
			hasNeedLv_ = true;
			needLv_ = value;
		}
		public function get needLv():int {
			return needLv_;
		}
		private var taskRunningDes_:String;
		public function get hasTaskRunningDes():Boolean {
			return null != taskRunningDes_;
		}
		public function set taskRunningDes(value:String):void {
			taskRunningDes_ = value;
		}
		public function get taskRunningDes():String {
			return taskRunningDes_;
		}
		private var taskCompleteDes_:String;
		public function get hasTaskCompleteDes():Boolean {
			return null != taskCompleteDes_;
		}
		public function set taskCompleteDes(value:String):void {
			taskCompleteDes_ = value;
		}
		public function get taskCompleteDes():String {
			return taskCompleteDes_;
		}
		private var taskName_:String;
		public function get hasTaskName():Boolean {
			return null != taskName_;
		}
		public function set taskName(value:String):void {
			taskName_ = value;
		}
		public function get taskName():String {
			return taskName_;
		}
		[ArrayElementType("proto.task.task1421.TaskTracLinkInfo")]
		public var runingArgs:Array = [];
		[ArrayElementType("proto.task.task1421.TaskTracLinkInfo")]
		public var completeArgs:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, taskId);
			if (hasTaskState) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, taskState);
			}
			if (hasTaskAccpetNpcId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, taskAccpetNpcId);
			}
			if (hasTaskAccpetCityId) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, taskAccpetCityId);
			}
			if (hasNeedNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, needNum);
			}
			if (hasCurNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, curNum);
			}
			if (hasIsTrac) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, isTrac);
			}
			if (hasNeedLv) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, needLv);
			}
			if (hasTaskRunningDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, taskRunningDes);
			}
			if (hasTaskCompleteDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, taskCompleteDes);
			}
			if (hasTaskName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_STRING(output, taskName);
			}
			for (var runingArgsIndex:uint = 0; runingArgsIndex < runingArgs.length; ++runingArgsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 12);
				WriteUtils.write_TYPE_MESSAGE(output, runingArgs[runingArgsIndex]);
			}
			for (var completeArgsIndex:uint = 0; completeArgsIndex < completeArgs.length; ++completeArgsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 13);
				WriteUtils.write_TYPE_MESSAGE(output, completeArgs[completeArgsIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var taskIdCount:uint = 0;
			var taskStateCount:uint = 0;
			var taskAccpetNpcIdCount:uint = 0;
			var taskAccpetCityIdCount:uint = 0;
			var needNumCount:uint = 0;
			var curNumCount:uint = 0;
			var isTracCount:uint = 0;
			var needLvCount:uint = 0;
			var taskRunningDesCount:uint = 0;
			var taskCompleteDesCount:uint = 0;
			var taskNameCount:uint = 0;
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
					if (taskStateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskStateCount;
					taskState = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (taskAccpetNpcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskAccpetNpcIdCount;
					taskAccpetNpcId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (taskAccpetCityIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskAccpetCityIdCount;
					taskAccpetCityId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (needNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++needNumCount;
					needNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (curNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curNumCount;
					curNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (isTracCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isTracCount;
					isTrac = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (needLvCount != 0) {
						throw new IOError('Bad data format.');
					}
					++needLvCount;
					needLv = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (taskRunningDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskRunningDesCount;
					taskRunningDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (taskCompleteDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskCompleteDesCount;
					taskCompleteDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (taskNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskNameCount;
					taskName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 12:
					runingArgs.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1421.TaskTracLinkInfo));
					break;
				case 13:
					completeArgs.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1421.TaskTracLinkInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (taskIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
