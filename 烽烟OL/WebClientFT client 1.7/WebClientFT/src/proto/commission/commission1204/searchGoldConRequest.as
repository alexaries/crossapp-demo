package proto.commission.commission1204 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class searchGoldConRequest extends Message implements IExternalizable {
		public var id:int;
		public var keyName:String;
		public var searchType:int;
		public var sortType:int;
		public var index:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, keyName);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, searchType);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, sortType);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, index);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var keyNameCount:uint = 0;
			var searchTypeCount:uint = 0;
			var sortTypeCount:uint = 0;
			var indexCount:uint = 0;
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
					if (keyNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++keyNameCount;
					keyName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (searchTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++searchTypeCount;
					searchType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (sortTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sortTypeCount;
					sortType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (indexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++indexCount;
					index = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (keyNameCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (searchTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sortTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (indexCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
