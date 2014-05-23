package proto.login.login104 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.login.login104.roleInfo;
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
		private var len_:int;
		private var hasLen_:Boolean = false;
		public function get hasLen():Boolean {
			return hasLen_;
		}
		public function set len(value:int):void {
			hasLen_ = true;
			len_ = value;
		}
		public function get len():int {
			return len_;
		}
		[ArrayElementType("proto.login.login104.roleInfo")]
		public var character:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasUserId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, userId);
			}
			if (hasLen) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, len);
			}
			for (var characterIndex:uint = 0; characterIndex < character.length; ++characterIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, character[characterIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var userIdCount:uint = 0;
			var lenCount:uint = 0;
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
				case 2:
					if (lenCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lenCount;
					len = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					character.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.login.login104.roleInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
