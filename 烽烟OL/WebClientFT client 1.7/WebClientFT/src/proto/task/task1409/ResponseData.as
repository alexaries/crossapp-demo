package proto.task.task1409 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1409.QuestInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ResponseData extends Message implements IExternalizable {
		private var questInfo_:proto.task.task1409.QuestInfo;
		public function get hasQuestInfo():Boolean {
			return null != questInfo_;
		}
		public function set questInfo(value:proto.task.task1409.QuestInfo):void {
			questInfo_ = value;
		}
		public function get questInfo():proto.task.task1409.QuestInfo {
			return questInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasQuestInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, questInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var questInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (questInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++questInfoCount;
					questInfo = new proto.task.task1409.QuestInfo;
					ReadUtils.read_TYPE_MESSAGE(input, questInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
