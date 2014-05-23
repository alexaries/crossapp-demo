package proto.shop.shop1605 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		public var endtime:Int64;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT64(output, endtime);
		}
		public function readExternal(input:IDataInput):void {
			var endtimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (endtimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++endtimeCount;
					endtime = ReadUtils.read_TYPE_INT64(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (endtimeCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
