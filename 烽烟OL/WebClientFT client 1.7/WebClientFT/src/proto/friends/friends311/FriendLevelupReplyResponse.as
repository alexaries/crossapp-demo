package proto.friends.friends311 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FriendLevelupReplyResponse extends Message implements IExternalizable {
		public var result:Boolean;
		public var friendId:int;
		public var friendName:String;
		private var handleType_:int;
		private var hasHandleType_:Boolean = false;
		public function get hasHandleType():Boolean {
			return hasHandleType_;
		}
		public function set handleType(value:int):void {
			hasHandleType_ = true;
			handleType_ = value;
		}
		public function get handleType():int {
			return handleType_;
		}
		private var message_:String;
		public function get hasMessage():Boolean {
			return null != message_;
		}
		public function set message(value:String):void {
			message_ = value;
		}
		public function get message():String {
			return message_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, friendId);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, friendName);
			if (hasHandleType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, handleType);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, message);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var friendIdCount:uint = 0;
			var friendNameCount:uint = 0;
			var handleTypeCount:uint = 0;
			var messageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (friendIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++friendIdCount;
					friendId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (friendNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++friendNameCount;
					friendName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (handleTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++handleTypeCount;
					handleType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
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
			if (resultCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (friendIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (friendNameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
