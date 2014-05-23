package proto.shop.shop219 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ResponseInfo extends Message implements IExternalizable {
		private var opeType_:int;
		private var hasOpeType_:Boolean = false;
		public function get hasOpeType():Boolean {
			return hasOpeType_;
		}
		public function set opeType(value:int):void {
			hasOpeType_ = true;
			opeType_ = value;
		}
		public function get opeType():int {
			return opeType_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasOpeType) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, opeType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var opeTypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (opeTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++opeTypeCount;
					opeType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
