package proto.login.login104 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class roleInfo extends Message implements IExternalizable {
		private var id_:int;
		private var hasId_:Boolean = false;
		public function get hasId():Boolean {
			return hasId_;
		}
		public function set id(value:int):void {
			hasId_ = true;
			id_ = value;
		}
		public function get id():int {
			return id_;
		}
		private var nicName_:String;
		public function get hasNicName():Boolean {
			return null != nicName_;
		}
		public function set nicName(value:String):void {
			nicName_ = value;
		}
		public function get nicName():String {
			return nicName_;
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
		private var profession_:String;
		public function get hasProfession():Boolean {
			return null != profession_;
		}
		public function set profession(value:String):void {
			profession_ = value;
		}
		public function get profession():String {
			return profession_;
		}
		private var roletype_:int;
		private var hasRoletype_:Boolean = false;
		public function get hasRoletype():Boolean {
			return hasRoletype_;
		}
		public function set roletype(value:int):void {
			hasRoletype_ = true;
			roletype_ = value;
		}
		public function get roletype():int {
			return roletype_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasNicName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, nicName);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasProfession) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, profession);
			}
			if (hasRoletype) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, roletype);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nicNameCount:uint = 0;
			var levelCount:uint = 0;
			var professionCount:uint = 0;
			var roletypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (nicNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nicNameCount;
					nicName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (roletypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roletypeCount;
					roletype = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
