package proto.task.task1404 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1404.QuestProcess;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class pushQuestProcessList extends Message implements IExternalizable {
		[ArrayElementType("proto.task.task1404.QuestProcess")]
		public var questprocesslist:Array = [];
		private var circulatingCount_:int;
		private var hasCirculatingCount_:Boolean = false;
		public function get hasCirculatingCount():Boolean {
			return hasCirculatingCount_;
		}
		public function set circulatingCount(value:int):void {
			hasCirculatingCount_ = true;
			circulatingCount_ = value;
		}
		public function get circulatingCount():int {
			return circulatingCount_;
		}
		private var circulatingNum_:int;
		private var hasCirculatingNum_:Boolean = false;
		public function get hasCirculatingNum():Boolean {
			return hasCirculatingNum_;
		}
		public function set circulatingNum(value:int):void {
			hasCirculatingNum_ = true;
			circulatingNum_ = value;
		}
		public function get circulatingNum():int {
			return circulatingNum_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var questprocesslistIndex:uint = 0; questprocesslistIndex < questprocesslist.length; ++questprocesslistIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, questprocesslist[questprocesslistIndex]);
			}
			if (hasCirculatingCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, circulatingCount);
			}
			if (hasCirculatingNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, circulatingNum);
			}
		}
		public function readExternal(input:IDataInput):void {
			var circulatingCountCount:uint = 0;
			var circulatingNumCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					questprocesslist.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.task.task1404.QuestProcess));
					break;
				case 2:
					if (circulatingCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++circulatingCountCount;
					circulatingCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (circulatingNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++circulatingNumCount;
					circulatingNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
