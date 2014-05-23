package proto.group.group905 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class OtherMessage extends Message implements IExternalizable {
		public var msg:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, msg);
		}
		public function readExternal(input:IDataInput):void {
			var msgCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (msgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++msgCount;
					msg = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (msgCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
