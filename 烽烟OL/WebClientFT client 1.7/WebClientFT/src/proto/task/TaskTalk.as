package proto.task {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TaskTalk extends Message implements IExternalizable {
		private var roleType_:String;
		public function get hasRoleType():Boolean {
			return null != roleType_;
		}
		public function set roleType(value:String):void {
			roleType_ = value;
		}
		public function get roleType():String {
			return roleType_;
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
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleType) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, roleType);
			}
			if (hasTaskDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, taskDes);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleTypeCount:uint = 0;
			var taskDesCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (roleTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleTypeCount;
					roleType = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (taskDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskDesCount;
					taskDes = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
