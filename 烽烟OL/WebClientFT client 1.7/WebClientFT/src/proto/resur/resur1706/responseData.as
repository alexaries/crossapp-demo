package proto.resur.resur1706 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		public var faildtype:int;
		private var goldprice_:int;
		private var hasGoldprice_:Boolean = false;
		public function get hasGoldprice():Boolean {
			return hasGoldprice_;
		}
		public function set goldprice(value:int):void {
			hasGoldprice_ = true;
			goldprice_ = value;
		}
		public function get goldprice():int {
			return goldprice_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, faildtype);
			if (hasGoldprice) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, goldprice);
			}
		}
		public function readExternal(input:IDataInput):void {
			var faildtypeCount:uint = 0;
			var goldpriceCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (faildtypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++faildtypeCount;
					faildtype = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (goldpriceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldpriceCount;
					goldprice = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (faildtypeCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
