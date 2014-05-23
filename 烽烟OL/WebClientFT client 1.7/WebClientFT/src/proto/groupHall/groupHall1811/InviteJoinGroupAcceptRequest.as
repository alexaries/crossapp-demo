package proto.groupHall.groupHall1811 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class InviteJoinGroupAcceptRequest extends Message implements IExternalizable {
		public var id:int;
		public var inviteId:int;
		public var areaId:int;
		public var roomId:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, inviteId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, areaId);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, roomId);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var inviteIdCount:uint = 0;
			var areaIdCount:uint = 0;
			var roomIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (inviteIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++inviteIdCount;
					inviteId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (areaIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++areaIdCount;
					areaId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (roomIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roomIdCount;
					roomId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (inviteIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (areaIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (roomIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
