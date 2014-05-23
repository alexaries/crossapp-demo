package proto.jingji.jingji3700 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BattleInfo extends Message implements IExternalizable {
		private var battleStr_:String;
		public function get hasBattleStr():Boolean {
			return null != battleStr_;
		}
		public function set battleStr(value:String):void {
			battleStr_ = value;
		}
		public function get battleStr():String {
			return battleStr_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBattleStr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, battleStr);
			}
		}
		public function readExternal(input:IDataInput):void {
			var battleStrCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (battleStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++battleStrCount;
					battleStr = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
