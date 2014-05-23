package proto.task.task1406 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1406.ProcessQuest;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		[ArrayElementType("proto.task.task1406.ProcessQuest")]
		public var progressingquestList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var progressingquestListIndex:uint = 0; progressingquestListIndex < progressingquestList.length; ++progressingquestListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, progressingquestList[progressingquestListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					progressingquestList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1406.ProcessQuest));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
