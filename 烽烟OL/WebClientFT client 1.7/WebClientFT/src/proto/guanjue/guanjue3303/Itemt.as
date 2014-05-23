package proto.guanjue.guanjue3303 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.guanjue.guanjue3303.Wupin;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Itemt extends Message implements IExternalizable {
		[ArrayElementType("proto.guanjue.guanjue3303.Wupin")]
		public var wp:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var wpIndex:uint = 0; wpIndex < wp.length; ++wpIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, wp[wpIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					wp.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.guanjue.guanjue3303.Wupin));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
