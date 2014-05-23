package proto.guide.guide1604 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RecordStepIDRequest extends Message implements IExternalizable {
		public var beginnerId:int;
		public var recordId:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, beginnerId);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, recordId);
		}
		public function readExternal(input:IDataInput):void {
			var beginnerIdCount:uint = 0;
			var recordIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (beginnerIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++beginnerIdCount;
					beginnerId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (recordIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++recordIdCount;
					recordId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (beginnerIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (recordIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
