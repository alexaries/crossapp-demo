package proto.task.task1406 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ProcessQuest extends Message implements IExternalizable {
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
		private var trackStatu_:int;
		private var hasTrackStatu_:Boolean = false;
		public function get hasTrackStatu():Boolean {
			return hasTrackStatu_;
		}
		public function set trackStatu(value:int):void {
			hasTrackStatu_ = true;
			trackStatu_ = value;
		}
		public function get trackStatu():int {
			return trackStatu_;
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
			if (hasTrackStatu) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, trackStatu);
			}
		}
		public function readExternal(input:IDataInput):void {
			var taskIdCount:uint = 0;
			var tasknameCount:uint = 0;
			var trackStatuCount:uint = 0;
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
					if (trackStatuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++trackStatuCount;
					trackStatu = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
