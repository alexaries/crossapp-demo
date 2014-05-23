package proto.guaji.guaji3205 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BattleInfo extends Message implements IExternalizable {
		private var baDesStr_:String;
		public function get hasBaDesStr():Boolean {
			return null != baDesStr_;
		}
		public function set baDesStr(value:String):void {
			baDesStr_ = value;
		}
		public function get baDesStr():String {
			return baDesStr_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBaDesStr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, baDesStr);
			}
		}
		public function readExternal(input:IDataInput):void {
			var baDesStrCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (baDesStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baDesStrCount;
					baDesStr = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
