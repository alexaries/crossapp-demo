package proto.friends.friends305 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Friend extends Message implements IExternalizable {
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
		private var comp_:String;
		public function get hasComp():Boolean {
			return null != comp_;
		}
		public function set comp(value:String):void {
			comp_ = value;
		}
		public function get comp():String {
			return comp_;
		}
		private var lastLoadTime_:String;
		public function get hasLastLoadTime():Boolean {
			return null != lastLoadTime_;
		}
		public function set lastLoadTime(value:String):void {
			lastLoadTime_ = value;
		}
		public function get lastLoadTime():String {
			return lastLoadTime_;
		}
		private var tishi_:int;
		private var hasTishi_:Boolean = false;
		public function get hasTishi():Boolean {
			return hasTishi_;
		}
		public function set tishi(value:int):void {
			hasTishi_ = true;
			tishi_ = value;
		}
		public function get tishi():int {
			return tishi_;
		}
		private var zx_:int;
		private var hasZx_:Boolean = false;
		public function get hasZx():Boolean {
			return hasZx_;
		}
		public function set zx(value:int):void {
			hasZx_ = true;
			zx_ = value;
		}
		public function get zx():int {
			return zx_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roleId);
			}
			if (hasRoleName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, roleName);
			}
			if (hasRoleProfession) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, roleProfession);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasComp) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, comp);
			}
			if (hasLastLoadTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, lastLoadTime);
			}
			if (hasTishi) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, tishi);
			}
			if (hasZx) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, zx);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleIdCount:uint = 0;
			var roleNameCount:uint = 0;
			var roleProfessionCount:uint = 0;
			var levelCount:uint = 0;
			var compCount:uint = 0;
			var lastLoadTimeCount:uint = 0;
			var tishiCount:uint = 0;
			var zxCount:uint = 0;
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
					if (roleNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleNameCount;
					roleName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (roleProfessionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roleProfessionCount;
					roleProfession = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (compCount != 0) {
						throw new IOError('Bad data format.');
					}
					++compCount;
					comp = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (lastLoadTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lastLoadTimeCount;
					lastLoadTime = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (tishiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tishiCount;
					tishi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (zxCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zxCount;
					zx = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
