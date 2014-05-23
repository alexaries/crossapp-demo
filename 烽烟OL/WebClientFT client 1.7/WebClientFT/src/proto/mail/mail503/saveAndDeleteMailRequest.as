package proto.mail.mail503 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class saveAndDeleteMailRequest extends Message implements IExternalizable {
		public var id:int;
		public var setType:int;
		public var requestInfo:int;
		[ArrayElementType("int")]
		public var mailId:Array = [];
		public var mailType:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, setType);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, requestInfo);
			for (var mailIdIndex:uint = 0; mailIdIndex < mailId.length; ++mailIdIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, mailId[mailIdIndex]);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, mailType);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var setTypeCount:uint = 0;
			var requestInfoCount:uint = 0;
			var mailTypeCount:uint = 0;
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
					if (setTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++setTypeCount;
					setType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (requestInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++requestInfoCount;
					requestInfo = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, mailId);
					break;
					}
					mailId.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 5:
					if (mailTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailTypeCount;
					mailType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (setTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (requestInfoCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (mailTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
