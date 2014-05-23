package proto.pratice.getPratice {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var status_:String;
		public function get hasStatus():Boolean {
			return null != status_;
		}
		public function set status(value:String):void {
			status_ = value;
		}
		public function get status():String {
			return status_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasStatus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, status);
			}
		}
		public function readExternal(input:IDataInput):void {
			var statusCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (statusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++statusCount;
					status = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
