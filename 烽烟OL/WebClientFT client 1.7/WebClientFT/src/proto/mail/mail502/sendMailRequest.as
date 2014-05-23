package proto.mail.mail502 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class sendMailRequest extends Message implements IExternalizable {
		public var id:int;
		public var acceptName:String;
		public var mailTitle:String;
		public var mailContent:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, acceptName);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, mailTitle);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, mailContent);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var acceptNameCount:uint = 0;
			var mailTitleCount:uint = 0;
			var mailContentCount:uint = 0;
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
					if (acceptNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++acceptNameCount;
					acceptName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (mailTitleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailTitleCount;
					mailTitle = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (mailContentCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mailContentCount;
					mailContent = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (acceptNameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (mailTitleCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (mailContentCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
