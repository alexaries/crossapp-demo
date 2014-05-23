package proto.scene.scene204 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class getItemsInPackageRequest extends Message implements IExternalizable {
		public var id:int;
		public var packCategory:int;
		public var curpage:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, packCategory);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, curpage);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var packCategoryCount:uint = 0;
			var curpageCount:uint = 0;
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
					if (packCategoryCount != 0) {
						throw new IOError('Bad data format.');
					}
					++packCategoryCount;
					packCategory = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (packCategoryCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (curpageCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
