package proto.prompted.prompted2200 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PromptedMessage extends Message implements IExternalizable {
		public var prompted:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, prompted);
		}
		public function readExternal(input:IDataInput):void {
			var promptedCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (promptedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++promptedCount;
					prompted = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (promptedCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
