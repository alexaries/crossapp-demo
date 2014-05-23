package proto.commission.commission1209 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class goldConsignmentRequest extends Message implements IExternalizable {
		public var id:int;
		public var goldNum:int;
		public var coinPrice:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, goldNum);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, coinPrice);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var goldNumCount:uint = 0;
			var coinPriceCount:uint = 0;
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
					if (goldNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldNumCount;
					goldNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (coinPriceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinPriceCount;
					coinPrice = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (goldNumCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (coinPriceCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
