package proto.resur.resur1705 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class pushAskForRevive extends Message implements IExternalizable {
		public var victimerId:int;
		public var victimerName:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, victimerId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, victimerName);
		}
		public function readExternal(input:IDataInput):void {
			var victimerIdCount:uint = 0;
			var victimerNameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (victimerIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++victimerIdCount;
					victimerId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (victimerNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++victimerNameCount;
					victimerName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (victimerIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (victimerNameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
