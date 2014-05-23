package proto.shop.shop214 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class buyItemInMallRequest extends Message implements IExternalizable {
		public var id:int;
		public var itemTemplateId:int;
		public var count:int;
		public var priceType:int;
		public var buyType:int;
		private var presentName_:String;
		public function get hasPresentName():Boolean {
			return null != presentName_;
		}
		public function set presentName(value:String):void {
			presentName_ = value;
		}
		public function get presentName():String {
			return presentName_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, itemTemplateId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, count);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, priceType);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, buyType);
			if (hasPresentName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, presentName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var itemTemplateIdCount:uint = 0;
			var countCount:uint = 0;
			var priceTypeCount:uint = 0;
			var buyTypeCount:uint = 0;
			var presentNameCount:uint = 0;
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
					if (itemTemplateIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemTemplateIdCount;
					itemTemplateId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (countCount != 0) {
						throw new IOError('Bad data format.');
					}
					++countCount;
					count = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (priceTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++priceTypeCount;
					priceType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (buyTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buyTypeCount;
					buyType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (presentNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++presentNameCount;
					presentName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (itemTemplateIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (countCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (priceTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (buyTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
