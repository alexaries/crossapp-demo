package proto.panpa.panpa4202 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PaTaInfo extends Message implements IExternalizable {
		private var itemStr_:String;
		public function get hasItemStr():Boolean {
			return null != itemStr_;
		}
		public function set itemStr(value:String):void {
			itemStr_ = value;
		}
		public function get itemStr():String {
			return itemStr_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemStr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, itemStr);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemStrCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemStrCount;
					itemStr = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
