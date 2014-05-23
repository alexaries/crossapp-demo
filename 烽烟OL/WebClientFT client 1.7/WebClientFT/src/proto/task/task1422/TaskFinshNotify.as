package proto.task.task1422 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TaskFinshNotify extends Message implements IExternalizable {
		public var finshID:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, finshID);
		}
		public function readExternal(input:IDataInput):void {
			var finshIDCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (finshIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++finshIDCount;
					finshID = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (finshIDCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
