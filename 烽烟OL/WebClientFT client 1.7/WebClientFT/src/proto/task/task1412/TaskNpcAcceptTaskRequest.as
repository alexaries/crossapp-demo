package proto.task.task1412 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TaskNpcAcceptTaskRequest extends Message implements IExternalizable {
		public var id:int;
		public var taskId:int;
		private var npcId_:int;
		private var hasNpcId_:Boolean = false;
		public function get hasNpcId():Boolean {
			return hasNpcId_;
		}
		public function set npcId(value:int):void {
			hasNpcId_ = true;
			npcId_ = value;
		}
		public function get npcId():int {
			return npcId_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, taskId);
			if (hasNpcId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, npcId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var taskIdCount:uint = 0;
			var npcIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (taskIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskIdCount;
					taskId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (npcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcIdCount;
					npcId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
