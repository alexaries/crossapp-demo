package proto.blacksmith.blacksmith2114 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.blacksmith.blacksmith2114.HeChenInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class HeChenInfoList extends Message implements IExternalizable {
		[ArrayElementType("proto.blacksmith.blacksmith2114.HeChenInfo")]
		public var equiplist:Array = [];
		[ArrayElementType("proto.blacksmith.blacksmith2114.HeChenInfo")]
		public var gemlist:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var equiplistIndex:uint = 0; equiplistIndex < equiplist.length; ++equiplistIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, equiplist[equiplistIndex]);
			}
			for (var gemlistIndex:uint = 0; gemlistIndex < gemlist.length; ++gemlistIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, gemlist[gemlistIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					equiplist.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.blacksmith.blacksmith2114.HeChenInfo));
					break;
				case 2:
					gemlist.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.blacksmith.blacksmith2114.HeChenInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
