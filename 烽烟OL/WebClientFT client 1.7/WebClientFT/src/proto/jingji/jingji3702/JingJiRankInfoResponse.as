package proto.jingji.jingji3702 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class JingJiRankInfoResponse extends Message implements IExternalizable {
		private var anStr_:String;
		public function get hasAnStr():Boolean {
			return null != anStr_;
		}
		public function set anStr(value:String):void {
			anStr_ = value;
		}
		public function get anStr():String {
			return anStr_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasAnStr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, anStr);
			}
		}
		public function readExternal(input:IDataInput):void {
			var anStrCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (anStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++anStrCount;
					anStr = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
