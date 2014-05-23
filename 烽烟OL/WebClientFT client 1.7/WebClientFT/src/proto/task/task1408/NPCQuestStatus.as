package proto.task.task1408 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class NPCQuestStatus extends Message implements IExternalizable {
		private var npcID_:int;
		private var hasNpcID_:Boolean = false;
		public function get hasNpcID():Boolean {
			return hasNpcID_;
		}
		public function set npcID(value:int):void {
			hasNpcID_ = true;
			npcID_ = value;
		}
		public function get npcID():int {
			return npcID_;
		}
		private var statu_:int;
		private var hasStatu_:Boolean = false;
		public function get hasStatu():Boolean {
			return hasStatu_;
		}
		public function set statu(value:int):void {
			hasStatu_ = true;
			statu_ = value;
		}
		public function get statu():int {
			return statu_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasNpcID) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, npcID);
			}
			if (hasStatu) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, statu);
			}
		}
		public function readExternal(input:IDataInput):void {
			var npcIDCount:uint = 0;
			var statuCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (npcIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcIDCount;
					npcID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (statuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++statuCount;
					statu = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
