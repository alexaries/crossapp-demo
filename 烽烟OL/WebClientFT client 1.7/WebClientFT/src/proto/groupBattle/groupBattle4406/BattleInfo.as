package proto.groupBattle.groupBattle4406 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BattleInfo extends Message implements IExternalizable {
		private var roleId1_:int;
		private var hasRoleId1_:Boolean = false;
		public function get hasRoleId1():Boolean {
			return hasRoleId1_;
		}
		public function set roleId1(value:int):void {
			hasRoleId1_ = true;
			roleId1_ = value;
		}
		public function get roleId1():int {
			return roleId1_;
		}
		private var roleName1_:String;
		public function get hasRoleName1():Boolean {
			return null != roleName1_;
		}
		public function set roleName1(value:String):void {
			roleName1_ = value;
		}
		public function get roleName1():String {
			return roleName1_;
		}
		private var roleId2_:int;
		private var hasRoleId2_:Boolean = false;
		public function get hasRoleId2():Boolean {
			return hasRoleId2_;
		}
		public function set roleId2(value:int):void {
			hasRoleId2_ = true;
			roleId2_ = value;
		}
		public function get roleId2():int {
			return roleId2_;
		}
		private var roleName2_:String;
		public function get hasRoleName2():Boolean {
			return null != roleName2_;
		}
		public function set roleName2(value:String):void {
			roleName2_ = value;
		}
		public function get roleName2():String {
			return roleName2_;
		}
		private var sucObCoin_:int;
		private var hasSucObCoin_:Boolean = false;
		public function get hasSucObCoin():Boolean {
			return hasSucObCoin_;
		}
		public function set sucObCoin(value:int):void {
			hasSucObCoin_ = true;
			sucObCoin_ = value;
		}
		public function get sucObCoin():int {
			return sucObCoin_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoleId1) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roleId1);
			}
			if (hasRoleName1) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, roleName1);
			}
			if (hasRoleId2) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, roleId2);
			}
			if (hasRoleName2) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, roleName2);
			}
			if (hasSucObCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, sucObCoin);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roleId1Count:uint = 0;
			var roleName1Count:uint = 0;
			var roleId2Count:uint = 0;
			var roleName2Count:uint = 0;
			var sucObCoinCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (roleId1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++roleId1Count;
					roleId1 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (roleName1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++roleName1Count;
					roleName1 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (roleId2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++roleId2Count;
					roleId2 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (roleName2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++roleName2Count;
					roleName2 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (sucObCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sucObCoinCount;
					sucObCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
