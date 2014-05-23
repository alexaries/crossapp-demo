package proto.pratice.restOperate {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class restOperateRequest extends Message implements IExternalizable {
		public var id:int;
		public var type:String;
		public var payType:String;
		public var payNum:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, type);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, payType);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, payNum);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var typeCount:uint = 0;
			var payTypeCount:uint = 0;
			var payNumCount:uint = 0;
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
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (payTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++payTypeCount;
					payType = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (payNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++payNumCount;
					payNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (typeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (payTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (payNumCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
