package proto.resur.resur1701 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class pushLifeStatus extends Message implements IExternalizable {
		public var Signal:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, Signal);
		}
		public function readExternal(input:IDataInput):void {
			var SignalCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (SignalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++SignalCount;
					Signal = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (SignalCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
