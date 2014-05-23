package proto.task.task1407 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1407.Quest;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		[ArrayElementType("proto.task.task1407.Quest")]
		public var canReceivedquestList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var canReceivedquestListIndex:uint = 0; canReceivedquestListIndex < canReceivedquestList.length; ++canReceivedquestListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, canReceivedquestList[canReceivedquestListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					canReceivedquestList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1407.Quest));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
