package proto.pet.pet2300 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PetInfo extends Message implements IExternalizable {
		private var petId_:int;
		private var hasPetId_:Boolean = false;
		public function get hasPetId():Boolean {
			return hasPetId_;
		}
		public function set petId(value:int):void {
			hasPetId_ = true;
			petId_ = value;
		}
		public function get petId():int {
			return petId_;
		}
		private var resPetId_:int;
		private var hasResPetId_:Boolean = false;
		public function get hasResPetId():Boolean {
			return hasResPetId_;
		}
		public function set resPetId(value:int):void {
			hasResPetId_ = true;
			resPetId_ = value;
		}
		public function get resPetId():int {
			return resPetId_;
		}
		private var petName_:String;
		public function get hasPetName():Boolean {
			return null != petName_;
		}
		public function set petName(value:String):void {
			petName_ = value;
		}
		public function get petName():String {
			return petName_;
		}
		private var petLevel_:int;
		private var hasPetLevel_:Boolean = false;
		public function get hasPetLevel():Boolean {
			return hasPetLevel_;
		}
		public function set petLevel(value:int):void {
			hasPetLevel_ = true;
			petLevel_ = value;
		}
		public function get petLevel():int {
			return petLevel_;
		}
		private var icon_:int;
		private var hasIcon_:Boolean = false;
		public function get hasIcon():Boolean {
			return hasIcon_;
		}
		public function set icon(value:int):void {
			hasIcon_ = true;
			icon_ = value;
		}
		public function get icon():int {
			return icon_;
		}
		private var type_:int;
		private var hasType_:Boolean = false;
		public function get hasType():Boolean {
			return hasType_;
		}
		public function set type(value:int):void {
			hasType_ = true;
			type_ = value;
		}
		public function get type():int {
			return type_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasPetId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, petId);
			}
			if (hasResPetId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, resPetId);
			}
			if (hasPetName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, petName);
			}
			if (hasPetLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, petLevel);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, type);
			}
		}
		public function readExternal(input:IDataInput):void {
			var petIdCount:uint = 0;
			var resPetIdCount:uint = 0;
			var petNameCount:uint = 0;
			var petLevelCount:uint = 0;
			var iconCount:uint = 0;
			var typeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (petIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petIdCount;
					petId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (resPetIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resPetIdCount;
					resPetId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (petNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petNameCount;
					petName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (petLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petLevelCount;
					petLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
