package proto.groupHall.groupHall1820 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class QuitHallMessage extends Message implements IExternalizable {
		public var signal:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, signal);
		}
		public function readExternal(input:IDataInput):void {
			var signalCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (signalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++signalCount;
					signal = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (signalCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
