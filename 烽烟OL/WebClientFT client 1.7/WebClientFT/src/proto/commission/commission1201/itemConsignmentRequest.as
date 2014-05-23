package proto.commission.commission1201 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.commission.commission1201.Operation;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class itemConsignmentRequest extends Message implements IExternalizable {
		public var id:int;
		[ArrayElementType("proto.commission.commission1201.Operation")]
		public var operationInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			for (var operationInfoIndex:uint = 0; operationInfoIndex < operationInfo.length; ++operationInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, operationInfo[operationInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
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
					operationInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.commission.commission1201.Operation));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
