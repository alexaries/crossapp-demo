package proto.groupHall.groupHall1813 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupHall.groupHall1813.MatrixInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		[ArrayElementType("proto.groupHall.groupHall1813.MatrixInfo")]
		public var matrixList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			for (var matrixListIndex:uint = 0; matrixListIndex < matrixList.length; ++matrixListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, matrixList[matrixListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					matrixList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupHall.groupHall1813.MatrixInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
