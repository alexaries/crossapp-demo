package proto.jingji.jingji3701 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class JingJiCDResponse extends Message implements IExternalizable {
		private var cdTime_:int;
		private var hasCdTime_:Boolean = false;
		public function get hasCdTime():Boolean {
			return hasCdTime_;
		}
		public function set cdTime(value:int):void {
			hasCdTime_ = true;
			cdTime_ = value;
		}
		public function get cdTime():int {
			return cdTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCdTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, cdTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var cdTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (cdTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++cdTimeCount;
					cdTime = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
