package proto.commission.commission1203 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.commission.commission1203.Trend;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		[ArrayElementType("proto.commission.commission1203.Trend")]
		public var trends:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var trendsIndex:uint = 0; trendsIndex < trends.length; ++trendsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, trends[trendsIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					trends.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.commission.commission1203.Trend));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
