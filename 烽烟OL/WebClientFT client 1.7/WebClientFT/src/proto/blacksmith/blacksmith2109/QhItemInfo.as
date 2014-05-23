package proto.blacksmith.blacksmith2109 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class QhItemInfo extends Message implements IExternalizable {
		public var itemtag:int;
		public var item:proto.ItemsInfo;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, itemtag);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_MESSAGE(output, item);
		}
		public function readExternal(input:IDataInput):void {
			var itemtagCount:uint = 0;
			var itemCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemtagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemtagCount;
					itemtag = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemCount;
					item = new proto.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, item);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (itemtagCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
