package proto.task.task1408 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1408.NPCQuestStatus;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class getScenceNpcQuestStatusResponse extends Message implements IExternalizable {
		[ArrayElementType("proto.task.task1408.NPCQuestStatus")]
		public var NPCQuestStatusList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var NPCQuestStatusListIndex:uint = 0; NPCQuestStatusListIndex < NPCQuestStatusList.length; ++NPCQuestStatusListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, NPCQuestStatusList[NPCQuestStatusListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					NPCQuestStatusList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1408.NPCQuestStatus));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
