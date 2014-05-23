package proto.task.task1404 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1404.ProcessInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class QuestProcess extends Message implements IExternalizable {
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
		private var taskname_:String;
		public function get hasTaskname():Boolean {
			return null != taskname_;
		}
		public function set taskname(value:String):void {
			taskname_ = value;
		}
		public function get taskname():String {
			return taskname_;
		}
		private var hasFinished_:int;
		private var hasHasFinished_:Boolean = false;
		public function get hasHasFinished():Boolean {
			return hasHasFinished_;
		}
		public function set hasFinished(value:int):void {
			hasHasFinished_ = true;
			hasFinished_ = value;
		}
		public function get hasFinished():int {
			return hasFinished_;
		}
		[ArrayElementType("proto.task.task1404.ProcessInfo")]
		public var processinfolist:Array = [];
		private var tasktype_:int;
		private var hasTasktype_:Boolean = false;
		public function get hasTasktype():Boolean {
			return hasTasktype_;
		}
		public function set tasktype(value:int):void {
			hasTasktype_ = true;
			tasktype_ = value;
		}
		public function get tasktype():int {
			return tasktype_;
		}
		private var finishedNpcId_:int;
		private var hasFinishedNpcId_:Boolean = false;
		public function get hasFinishedNpcId():Boolean {
			return hasFinishedNpcId_;
		}
		public function set finishedNpcId(value:int):void {
			hasFinishedNpcId_ = true;
			finishedNpcId_ = value;
		}
		public function get finishedNpcId():int {
			return finishedNpcId_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasTaskId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, taskId);
			}
			if (hasTaskname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, taskname);
			}
			if (hasHasFinished) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, hasFinished);
			}
			for (var processinfolistIndex:uint = 0; processinfolistIndex < processinfolist.length; ++processinfolistIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, processinfolist[processinfolistIndex]);
			}
			if (hasTasktype) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, tasktype);
			}
			if (hasFinishedNpcId) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, finishedNpcId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var taskIdCount:uint = 0;
			var tasknameCount:uint = 0;
			var hasFinishedCount:uint = 0;
			var tasktypeCount:uint = 0;
			var finishedNpcIdCount:uint = 0;
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
					if (tasknameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tasknameCount;
					taskname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (hasFinishedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hasFinishedCount;
					hasFinished = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					processinfolist.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1404.ProcessInfo));
					break;
				case 5:
					if (tasktypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tasktypeCount;
					tasktype = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (finishedNpcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++finishedNpcIdCount;
					finishedNpcId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
