package proto.shop.shop219 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class npcShopBuyItemRequest extends Message implements IExternalizable {
		public var id:int;
		public var itemId:int;
		public var opeType:int;
		public var buyNum:int;
		public var npcId:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, itemId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, opeType);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, buyNum);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, npcId);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var itemIdCount:uint = 0;
			var opeTypeCount:uint = 0;
			var buyNumCount:uint = 0;
			var npcIdCount:uint = 0;
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
					if (itemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemIdCount;
					itemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (opeTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++opeTypeCount;
					opeType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (buyNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buyNumCount;
					buyNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (npcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcIdCount;
					npcId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (opeTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (buyNumCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (npcIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
