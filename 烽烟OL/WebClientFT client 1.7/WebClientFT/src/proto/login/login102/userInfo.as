package proto.login.login102 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class userInfo extends Message implements IExternalizable {
		private var userId_:int;
		private var hasUserId_:Boolean = false;
		public function get hasUserId():Boolean {
			return hasUserId_;
		}
		public function set userId(value:int):void {
			hasUserId_ = true;
			userId_ = value;
		}
		public function get userId():int {
			return userId_;
		}
		private var newCharacterId_:int;
		private var hasNewCharacterId_:Boolean = false;
		public function get hasNewCharacterId():Boolean {
			return hasNewCharacterId_;
		}
		public function set newCharacterId(value:int):void {
			hasNewCharacterId_ = true;
			newCharacterId_ = value;
		}
		public function get newCharacterId():int {
			return newCharacterId_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasUserId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, userId);
			}
			if (hasNewCharacterId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, newCharacterId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var userIdCount:uint = 0;
			var newCharacterIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (userIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++userIdCount;
					userId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (newCharacterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++newCharacterIdCount;
					newCharacterId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
