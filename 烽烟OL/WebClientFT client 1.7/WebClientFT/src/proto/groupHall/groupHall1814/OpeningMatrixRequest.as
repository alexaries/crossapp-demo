package proto.groupHall.groupHall1814 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupHall.groupHall1814.MatrixListInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class OpeningMatrixRequest extends Message implements IExternalizable {
		public var id:int;
		public var matrixId:int;
		[ArrayElementType("proto.groupHall.groupHall1814.MatrixListInfo")]
		public var matrixInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, matrixId);
			for (var matrixInfoIndex:uint = 0; matrixInfoIndex < matrixInfo.length; ++matrixInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, matrixInfo[matrixInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var matrixIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (matrixIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++matrixIdCount;
					matrixId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					matrixInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupHall.groupHall1814.MatrixListInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (matrixIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
