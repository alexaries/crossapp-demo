package proto.zudui.zudui4302 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PosRoleInfo extends Message implements IExternalizable {
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
		private var pos_:int;
		private var hasPos_:Boolean = false;
		public function get hasPos():Boolean {
			return hasPos_;
		}
		public function set pos(value:int):void {
			hasPos_ = true;
			pos_ = value;
		}
		public function get pos():int {
			return pos_;
		}
		private var level_:int;
		private var hasLevel_:Boolean = false;
		public function get hasLevel():Boolean {
			return hasLevel_;
		}
		public function set level(value:int):void {
			hasLevel_ = true;
			level_ = value;
		}
		public function get level():int {
			return level_;
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
		private var roleType_:int;
		private var hasRoleType_:Boolean = false;
		public function get hasRoleType():Boolean {
			return hasRoleType_;
		}
		public function set roleType(value:int):void {
			hasRoleType_ = true;
			roleType_ = value;
		}
		public function get roleType():int {
			return roleType_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roleId);
			}
			if (hasPos) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, pos);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasRoleName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, roleName);
			}
			if (hasRoleType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, roleType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleIdCount:uint = 0;
			var posCount:uint = 0;
			var levelCount:uint = 0;
			var roleNameCount:uint = 0;
			var roleTypeCount:uint = 0;
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
					if (posCount != 0) {
						throw new IOError('Bad data format.');
					}
					++posCount;
					pos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (roleNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleNameCount;
					roleName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (roleTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleTypeCount;
					roleType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
