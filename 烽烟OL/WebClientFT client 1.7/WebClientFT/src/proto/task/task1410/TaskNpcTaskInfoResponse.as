package proto.task.task1410 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.TaskItemInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TaskNpcTaskInfoResponse extends Message implements IExternalizable {
		public var result:Boolean;
		public var npcId:int;
		public var npcImg:int;
		public var npcName:String;
		public var npcWord:String;
		[ArrayElementType("proto.task.TaskItemInfo")]
		public var ncpTaskItem:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, npcId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, npcImg);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, npcName);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
			WriteUtils.write_TYPE_STRING(output, npcWord);
			for (var ncpTaskItemIndex:uint = 0; ncpTaskItemIndex < ncpTaskItem.length; ++ncpTaskItemIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, ncpTaskItem[ncpTaskItemIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var npcIdCount:uint = 0;
			var npcImgCount:uint = 0;
			var npcNameCount:uint = 0;
			var npcWordCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (npcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcIdCount;
					npcId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (npcImgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcImgCount;
					npcImg = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (npcNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcNameCount;
					npcName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (npcWordCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcWordCount;
					npcWord = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					ncpTaskItem.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.TaskItemInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (resultCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (npcIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (npcImgCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (npcNameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (npcWordCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
