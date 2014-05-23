package proto.groupHall.groupHall1810 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class InviteJoinGroupMsg extends Message implements IExternalizable {
		public var inviteID:int;
		public var areaID:int;
		public var roomId:int;
		public var message:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, inviteID);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, areaID);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, roomId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, message);
		}
		public function readExternal(input:IDataInput):void {
			var inviteIDCount:uint = 0;
			var areaIDCount:uint = 0;
			var roomIdCount:uint = 0;
			var messageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (inviteIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++inviteIDCount;
					inviteID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (areaIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++areaIDCount;
					areaID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (roomIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roomIdCount;
					roomId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (inviteIDCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (areaIDCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (roomIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (messageCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
