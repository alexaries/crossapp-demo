package proto.task.task1420 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class updateQuestTraceStatuRequest extends Message implements IExternalizable {
		public var id:int;
		public var taskID:int;
		public var traceStatu:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, taskID);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, traceStatu);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var taskIDCount:uint = 0;
			var traceStatuCount:uint = 0;
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
					if (taskIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++taskIDCount;
					taskID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (traceStatuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++traceStatuCount;
					traceStatu = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (taskIDCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (traceStatuCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
