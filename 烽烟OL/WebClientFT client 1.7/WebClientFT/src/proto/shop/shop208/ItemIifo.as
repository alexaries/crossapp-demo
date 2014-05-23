package proto.shop.shop208 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ItemIifo extends Message implements IExternalizable {
		public var templateId:int;
		public var type:int;
		public var price:int;
		public var count:int;
		public var itemID:int;
		private var priceNow_:int;
		private var hasPriceNow_:Boolean = false;
		public function get hasPriceNow():Boolean {
			return hasPriceNow_;
		}
		public function set priceNow(value:int):void {
			hasPriceNow_ = true;
			priceNow_ = value;
		}
		public function get priceNow():int {
			return priceNow_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, templateId);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, type);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, price);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, count);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, itemID);
			if (hasPriceNow) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, priceNow);
			}
		}
		public function readExternal(input:IDataInput):void {
			var templateIdCount:uint = 0;
			var typeCount:uint = 0;
			var priceCount:uint = 0;
			var countCount:uint = 0;
			var itemIDCount:uint = 0;
			var priceNowCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (templateIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++templateIdCount;
					templateId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (priceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++priceCount;
					price = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (countCount != 0) {
						throw new IOError('Bad data format.');
					}
					++countCount;
					count = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (itemIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemIDCount;
					itemID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (priceNowCount != 0) {
						throw new IOError('Bad data format.');
					}
					++priceNowCount;
					priceNow = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (templateIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (typeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (priceCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (countCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemIDCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
