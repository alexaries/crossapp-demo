package proto.groupHall.groupHall1821 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RoomInfo extends Message implements IExternalizable {
		private var roomId_:int;
		private var hasRoomId_:Boolean = false;
		public function get hasRoomId():Boolean {
			return hasRoomId_;
		}
		public function set roomId(value:int):void {
			hasRoomId_ = true;
			roomId_ = value;
		}
		public function get roomId():int {
			return roomId_;
		}
		private var groupName_:String;
		public function get hasGroupName():Boolean {
			return null != groupName_;
		}
		public function set groupName(value:String):void {
			groupName_ = value;
		}
		public function get groupName():String {
			return groupName_;
		}
		private var groupPassword_:String;
		public function get hasGroupPassword():Boolean {
			return null != groupPassword_;
		}
		public function set groupPassword(value:String):void {
			groupPassword_ = value;
		}
		public function get groupPassword():String {
			return groupPassword_;
		}
		private var copySceneId_:int;
		private var hasCopySceneId_:Boolean = false;
		public function get hasCopySceneId():Boolean {
			return hasCopySceneId_;
		}
		public function set copySceneId(value:int):void {
			hasCopySceneId_ = true;
			copySceneId_ = value;
		}
		public function get copySceneId():int {
			return copySceneId_;
		}
		private var copyLevel_:int;
		private var hasCopyLevel_:Boolean = false;
		public function get hasCopyLevel():Boolean {
			return hasCopyLevel_;
		}
		public function set copyLevel(value:int):void {
			hasCopyLevel_ = true;
			copyLevel_ = value;
		}
		public function get copyLevel():int {
			return copyLevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoomId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roomId);
			}
			if (hasGroupName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, groupName);
			}
			if (hasGroupPassword) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, groupPassword);
			}
			if (hasCopySceneId) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, copySceneId);
			}
			if (hasCopyLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, copyLevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roomIdCount:uint = 0;
			var groupNameCount:uint = 0;
			var groupPasswordCount:uint = 0;
			var copySceneIdCount:uint = 0;
			var copyLevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (roomIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roomIdCount;
					roomId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (groupNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupNameCount;
					groupName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (groupPasswordCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupPasswordCount;
					groupPassword = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (copySceneIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++copySceneIdCount;
					copySceneId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (copyLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++copyLevelCount;
					copyLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
