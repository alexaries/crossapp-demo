package proto.scene.scene222 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.scene222.BuffInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetBuffListInfoResponse extends Message implements IExternalizable {
		[ArrayElementType("proto.scene.scene222.BuffInfo")]
		public var buffInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var buffInfoIndex:uint = 0; buffInfoIndex < buffInfo.length; ++buffInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, buffInfo[buffInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					buffInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene222.BuffInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
