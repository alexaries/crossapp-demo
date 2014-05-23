package proto.groupHall.groupHall1806 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RoleOfRoomInfo extends Message implements IExternalizable {
		private var roleId_:int;
		private var hasRoleId_:Boolean = false;
		public function get hasRoleId():Boolean {
			return hasRoleId_;
		}
		public function set roleId(value:int):void {
			hasRoleId_ = true;
			roleId_ = value;
		}
		public function get roleId():int {
			return roleId_;
		}
		private var roleLevel_:int;
		private var hasRoleLevel_:Boolean = false;
		public function get hasRoleLevel():Boolean {
			return hasRoleLevel_;
		}
		public function set roleLevel(value:int):void {
			hasRoleLevel_ = true;
			roleLevel_ = value;
		}
		public function get roleLevel():int {
			return roleLevel_;
		}
		private var roleName_:String;
		public function get hasRoleName():Boolean {
			return null != roleName_;
		}
		public function set roleName(value:String):void {
			roleName_ = value;
		}
		public function get roleName():String {
			return roleName_;
		}
		private var roleWork_:int;
		private var hasRoleWork_:Boolean = false;
		public function get hasRoleWork():Boolean {
			return hasRoleWork_;
		}
		public function set roleWork(value:int):void {
			hasRoleWork_ = true;
			roleWork_ = value;
		}
		public function get roleWork():int {
			return roleWork_;
		}
		private var isRoomOwner_:Boolean;
		private var hasIsRoomOwner_:Boolean = false;
		public function get hasIsRoomOwner():Boolean {
			return hasIsRoomOwner_;
		}
		public function set isRoomOwner(value:Boolean):void {
			hasIsRoomOwner_ = true;
			isRoomOwner_ = value;
		}
		public function get isRoomOwner():Boolean {
			return isRoomOwner_;
		}
		private var isReady_:Boolean;
		private var hasIsReady_:Boolean = false;
		public function get hasIsReady():Boolean {
			return hasIsReady_;
		}
		public function set isReady(value:Boolean):void {
			hasIsReady_ = true;
			isReady_ = value;
		}
		public function get isReady():Boolean {
			return isReady_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roleId);
			}
			if (hasRoleLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, roleLevel);
			}
			if (hasRoleName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, roleName);
			}
			if (hasRoleWork) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, roleWork);
			}
			if (hasIsRoomOwner) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_BOOL(output, isRoomOwner);
			}
			if (hasIsReady) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_BOOL(output, isReady);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleIdCount:uint = 0;
			var roleLevelCount:uint = 0;
			var roleNameCount:uint = 0;
			var roleWorkCount:uint = 0;
			var isRoomOwnerCount:uint = 0;
			var isReadyCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (roleIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleIdCount;
					roleId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (roleLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleLevelCount;
					roleLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (roleNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleNameCount;
					roleName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (roleWorkCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleWorkCount;
					roleWork = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (isRoomOwnerCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isRoomOwnerCount;
					isRoomOwner = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 6:
					if (isReadyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isReadyCount;
					isReady = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
