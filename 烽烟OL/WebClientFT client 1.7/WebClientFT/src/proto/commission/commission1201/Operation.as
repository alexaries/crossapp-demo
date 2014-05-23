package proto.commission.commission1201 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Operation extends Message implements IExternalizable {
		public var position:int;
		public var stack:int;
		public var coinPrice:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, position);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, stack);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, coinPrice);
		}
		public function readExternal(input:IDataInput):void {
			var positionCount:uint = 0;
			var stackCount:uint = 0;
			var coinPriceCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (positionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++positionCount;
					position = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (stackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stackCount;
					stack = ReadUtils.read_TYPE_INT32(input);
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
			if (positionCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (stackCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (coinPriceCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
