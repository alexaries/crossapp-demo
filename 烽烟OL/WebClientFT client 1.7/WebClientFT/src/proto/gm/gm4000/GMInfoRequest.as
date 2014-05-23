package proto.gm.gm4000 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GMInfoRequest extends Message implements IExternalizable {
		public var id:int;
		public var gmMsg:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, gmMsg);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var gmMsgCount:uint = 0;
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
					if (gmMsgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++gmMsgCount;
					gmMsg = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (gmMsgCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
