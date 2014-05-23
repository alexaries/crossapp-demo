package proto.guide.guide1603 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class beginnersLoginRequest extends Message implements IExternalizable {
		public function writeExternal(output:IDataOutput):void {
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
