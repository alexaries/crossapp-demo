package proto.scene.scene201 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Appellation extends Message implements IExternalizable {
		private var idInDB_:int;
		private var hasIdInDB_:Boolean = false;
		public function get hasIdInDB():Boolean {
			return hasIdInDB_;
		}
		public function set idInDB(value:int):void {
			hasIdInDB_ = true;
			idInDB_ = value;
		}
		public function get idInDB():int {
			return idInDB_;
		}
		private var modID_:int;
		private var hasModID_:Boolean = false;
		public function get hasModID():Boolean {
			return hasModID_;
		}
		public function set modID(value:int):void {
			hasModID_ = true;
			modID_ = value;
		}
		public function get modID():int {
			return modID_;
		}
		private var name_:String;
		public function get hasName():Boolean {
			return null != name_;
		}
		public function set name(value:String):void {
			name_ = value;
		}
		public function get name():String {
			return name_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasIdInDB) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, idInDB);
			}
			if (hasModID) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, modID);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, name);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idInDBCount:uint = 0;
			var modIDCount:uint = 0;
			var nameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idInDBCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idInDBCount;
					idInDB = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (modIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++modIDCount;
					modID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
