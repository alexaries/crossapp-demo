package proto.groupHall.groupHall1815 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Role extends Message implements IExternalizable {
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
		private var profession_:int;
		private var hasProfession_:Boolean = false;
		public function get hasProfession():Boolean {
			return hasProfession_;
		}
		public function set profession(value:int):void {
			hasProfession_ = true;
			profession_ = value;
		}
		public function get profession():int {
			return profession_;
		}
		private var rolename_:String;
		public function get hasRolename():Boolean {
			return null != rolename_;
		}
		public function set rolename(value:String):void {
			rolename_ = value;
		}
		public function get rolename():String {
			return rolename_;
		}
		private var rolelevel_:int;
		private var hasRolelevel_:Boolean = false;
		public function get hasRolelevel():Boolean {
			return hasRolelevel_;
		}
		public function set rolelevel(value:int):void {
			hasRolelevel_ = true;
			rolelevel_ = value;
		}
		public function get rolelevel():int {
			return rolelevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roleId);
			}
			if (hasProfession) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, profession);
			}
			if (hasRolename) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, rolename);
			}
			if (hasRolelevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, rolelevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleIdCount:uint = 0;
			var professionCount:uint = 0;
			var rolenameCount:uint = 0;
			var rolelevelCount:uint = 0;
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
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (rolenameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rolenameCount;
					rolename = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (rolelevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rolelevelCount;
					rolelevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
