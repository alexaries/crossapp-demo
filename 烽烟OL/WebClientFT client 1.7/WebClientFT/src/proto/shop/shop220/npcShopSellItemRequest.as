package proto.shop.shop220 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class npcShopSellItemRequest extends Message implements IExternalizable {
		public var id:int;
		public var itemPos:int;
		public var packageType:int;
		public var curpage:int;
		public var sellCount:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, itemPos);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, packageType);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, curpage);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, sellCount);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var itemPosCount:uint = 0;
			var packageTypeCount:uint = 0;
			var curpageCount:uint = 0;
			var sellCountCount:uint = 0;
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
					if (itemPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemPosCount;
					itemPos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (packageTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++packageTypeCount;
					packageType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (sellCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sellCountCount;
					sellCount = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemPosCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (packageTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (curpageCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sellCountCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
