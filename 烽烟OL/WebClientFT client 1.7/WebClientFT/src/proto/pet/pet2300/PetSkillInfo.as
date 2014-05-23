package proto.pet.pet2300 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PetSkillInfo extends Message implements IExternalizable {
		private var hasActivationFlag_:Boolean;
		private var hasHasActivationFlag_:Boolean = false;
		public function get hasHasActivationFlag():Boolean {
			return hasHasActivationFlag_;
		}
		public function set hasActivationFlag(value:Boolean):void {
			hasHasActivationFlag_ = true;
			hasActivationFlag_ = value;
		}
		public function get hasActivationFlag():Boolean {
			return hasActivationFlag_;
		}
		private var petSkillId_:int;
		private var hasPetSkillId_:Boolean = false;
		public function get hasPetSkillId():Boolean {
			return hasPetSkillId_;
		}
		public function set petSkillId(value:int):void {
			hasPetSkillId_ = true;
			petSkillId_ = value;
		}
		public function get petSkillId():int {
			return petSkillId_;
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
		private var petSkillName_:String;
		public function get hasPetSkillName():Boolean {
			return null != petSkillName_;
		}
		public function set petSkillName(value:String):void {
			petSkillName_ = value;
		}
		public function get petSkillName():String {
			return petSkillName_;
		}
		private var petSkillLevel_:int;
		private var hasPetSkillLevel_:Boolean = false;
		public function get hasPetSkillLevel():Boolean {
			return hasPetSkillLevel_;
		}
		public function set petSkillLevel(value:int):void {
			hasPetSkillLevel_ = true;
			petSkillLevel_ = value;
		}
		public function get petSkillLevel():int {
			return petSkillLevel_;
		}
		private var petSkillDes_:String;
		public function get hasPetSkillDes():Boolean {
			return null != petSkillDes_;
		}
		public function set petSkillDes(value:String):void {
			petSkillDes_ = value;
		}
		public function get petSkillDes():String {
			return petSkillDes_;
		}
		private var petSkillMaxLevel_:int;
		private var hasPetSkillMaxLevel_:Boolean = false;
		public function get hasPetSkillMaxLevel():Boolean {
			return hasPetSkillMaxLevel_;
		}
		public function set petSkillMaxLevel(value:int):void {
			hasPetSkillMaxLevel_ = true;
			petSkillMaxLevel_ = value;
		}
		public function get petSkillMaxLevel():int {
			return petSkillMaxLevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasHasActivationFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, hasActivationFlag);
			}
			if (hasPetSkillId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, petSkillId);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasPetSkillName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, petSkillName);
			}
			if (hasPetSkillLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, petSkillLevel);
			}
			if (hasPetSkillDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, petSkillDes);
			}
			if (hasPetSkillMaxLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, petSkillMaxLevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var hasActivationFlagCount:uint = 0;
			var petSkillIdCount:uint = 0;
			var iconCount:uint = 0;
			var typeCount:uint = 0;
			var petSkillNameCount:uint = 0;
			var petSkillLevelCount:uint = 0;
			var petSkillDesCount:uint = 0;
			var petSkillMaxLevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (hasActivationFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hasActivationFlagCount;
					hasActivationFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (petSkillIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petSkillIdCount;
					petSkillId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (petSkillNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petSkillNameCount;
					petSkillName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (petSkillLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petSkillLevelCount;
					petSkillLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (petSkillDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petSkillDesCount;
					petSkillDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (petSkillMaxLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petSkillMaxLevelCount;
					petSkillMaxLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
