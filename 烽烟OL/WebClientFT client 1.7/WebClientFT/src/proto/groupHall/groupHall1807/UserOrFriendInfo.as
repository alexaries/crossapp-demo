package proto.groupHall.groupHall1807 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class UserOrFriendInfo extends Message implements IExternalizable {
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
		private var roleProfession_:int;
		private var hasRoleProfession_:Boolean = false;
		public function get hasRoleProfession():Boolean {
			return hasRoleProfession_;
		}
		public function set roleProfession(value:int):void {
			hasRoleProfession_ = true;
			roleProfession_ = value;
		}
		public function get roleProfession():int {
			return roleProfession_;
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
			if (hasRoleProfession) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, roleProfession);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleIdCount:uint = 0;
			var roleLevelCount:uint = 0;
			var roleNameCount:uint = 0;
			var roleProfessionCount:uint = 0;
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
					if (roleProfessionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleProfessionCount;
					roleProfession = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
