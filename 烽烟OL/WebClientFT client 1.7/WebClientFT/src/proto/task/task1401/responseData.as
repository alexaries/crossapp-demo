package proto.task.task1401 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1401.Quest;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		public var npcId:int;
		[ArrayElementType("proto.task.task1401.Quest")]
		public var canReceivedquestList:Array = [];
		[ArrayElementType("proto.task.task1401.Quest")]
		public var progressingquestList:Array = [];
		[ArrayElementType("proto.task.task1401.Quest")]
		public var cancommitquestList:Array = [];
		[ArrayElementType("proto.task.task1401.Quest")]
		public var failedquestList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, npcId);
			for (var canReceivedquestListIndex:uint = 0; canReceivedquestListIndex < canReceivedquestList.length; ++canReceivedquestListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, canReceivedquestList[canReceivedquestListIndex]);
			}
			for (var progressingquestListIndex:uint = 0; progressingquestListIndex < progressingquestList.length; ++progressingquestListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, progressingquestList[progressingquestListIndex]);
			}
			for (var cancommitquestListIndex:uint = 0; cancommitquestListIndex < cancommitquestList.length; ++cancommitquestListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, cancommitquestList[cancommitquestListIndex]);
			}
			for (var failedquestListIndex:uint = 0; failedquestListIndex < failedquestList.length; ++failedquestListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, failedquestList[failedquestListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var npcIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (npcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcIdCount;
					npcId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					canReceivedquestList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1401.Quest));
					break;
				case 3:
					progressingquestList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1401.Quest));
					break;
				case 4:
					cancommitquestList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1401.Quest));
					break;
				case 5:
					failedquestList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1401.Quest));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (npcIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
