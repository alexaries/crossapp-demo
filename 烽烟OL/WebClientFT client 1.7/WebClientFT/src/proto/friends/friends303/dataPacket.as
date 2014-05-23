package proto.friends.friends303 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
		private var friendId_:int;
		private var hasFriendId_:Boolean = false;
		public function get hasFriendId():Boolean {
			return hasFriendId_;
		}
		public function set friendId(value:int):void {
			hasFriendId_ = true;
			friendId_ = value;
		}
		public function get friendId():int {
			return friendId_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasFriendId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, friendId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var friendIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (friendIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++friendIdCount;
					friendId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
