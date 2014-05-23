package proto.group.group901 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class pushInvitedGroupRequest extends Message implements IExternalizable {
		public var inviterId:int;
		public var msg:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, inviterId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, msg);
		}
		public function readExternal(input:IDataInput):void {
			var inviterIdCount:uint = 0;
			var msgCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (inviterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++inviterIdCount;
					inviterId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
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
			if (inviterIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (msgCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
