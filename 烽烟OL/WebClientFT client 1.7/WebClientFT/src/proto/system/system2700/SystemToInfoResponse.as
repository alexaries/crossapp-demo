package proto.system.system2700 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SystemToInfoResponse extends Message implements IExternalizable {
		private var sInfo_:String;
		public function get hasSInfo():Boolean {
			return null != sInfo_;
		}
		public function set sInfo(value:String):void {
			sInfo_ = value;
		}
		public function get sInfo():String {
			return sInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasSInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, sInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var sInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (sInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sInfoCount;
					sInfo = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
