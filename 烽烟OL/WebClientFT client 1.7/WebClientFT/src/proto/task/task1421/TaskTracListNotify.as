package proto.task.task1421 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1421.TaskTracItem;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TaskTracListNotify extends Message implements IExternalizable {
		[ArrayElementType("proto.task.task1421.TaskTracItem")]
		public var curList:Array = [];
		[ArrayElementType("proto.task.task1421.TaskTracItem")]
		public var acceptableList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var curListIndex:uint = 0; curListIndex < curList.length; ++curListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, curList[curListIndex]);
			}
			for (var acceptableListIndex:uint = 0; acceptableListIndex < acceptableList.length; ++acceptableListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, acceptableList[acceptableListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					curList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1421.TaskTracItem));
					break;
				case 2:
					acceptableList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1421.TaskTracItem));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
