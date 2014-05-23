package proto.guide.guide1602 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
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
		private var characterId_:int;
		private var hasCharacterId_:Boolean = false;
		public function get hasCharacterId():Boolean {
			return hasCharacterId_;
		}
		public function set characterId(value:int):void {
			hasCharacterId_ = true;
			characterId_ = value;
		}
		public function get characterId():int {
			return characterId_;
		}
		private var placeId_:int;
		private var hasPlaceId_:Boolean = false;
		public function get hasPlaceId():Boolean {
			return hasPlaceId_;
		}
		public function set placeId(value:int):void {
			hasPlaceId_ = true;
			placeId_ = value;
		}
		public function get placeId():int {
			return placeId_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasUserId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, userId);
			}
			if (hasCharacterId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, characterId);
			}
			if (hasPlaceId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, placeId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var userIdCount:uint = 0;
			var characterIdCount:uint = 0;
			var placeIdCount:uint = 0;
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
					if (characterIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++characterIdCount;
					characterId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (placeIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++placeIdCount;
					placeId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
