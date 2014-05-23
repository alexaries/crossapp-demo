package proto.task.task1402 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
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
		public function writeExternal(output:IDataOutput):void {
			if (hasTaskId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, taskId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var taskIdCount:uint = 0;
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
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
