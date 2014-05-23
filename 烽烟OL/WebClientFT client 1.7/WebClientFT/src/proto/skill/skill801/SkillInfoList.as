package proto.skill.skill801 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SkillInfoList extends Message implements IExternalizable {
		private var skillId_:int;
		private var hasSkillId_:Boolean = false;
		public function get hasSkillId():Boolean {
			return hasSkillId_;
		}
		public function set skillId(value:int):void {
			hasSkillId_ = true;
			skillId_ = value;
		}
		public function get skillId():int {
			return skillId_;
		}
		private var skillName_:String;
		public function get hasSkillName():Boolean {
			return null != skillName_;
		}
		public function set skillName(value:String):void {
			skillName_ = value;
		}
		public function get skillName():String {
			return skillName_;
		}
		private var skillLevel_:int;
		private var hasSkillLevel_:Boolean = false;
		public function get hasSkillLevel():Boolean {
			return hasSkillLevel_;
		}
		public function set skillLevel(value:int):void {
			hasSkillLevel_ = true;
			skillLevel_ = value;
		}
		public function get skillLevel():int {
			return skillLevel_;
		}
		private var remainRoleLevel_:int;
		private var hasRemainRoleLevel_:Boolean = false;
		public function get hasRemainRoleLevel():Boolean {
			return hasRemainRoleLevel_;
		}
		public function set remainRoleLevel(value:int):void {
			hasRemainRoleLevel_ = true;
			remainRoleLevel_ = value;
		}
		public function get remainRoleLevel():int {
			return remainRoleLevel_;
		}
		private var skillDes_:String;
		public function get hasSkillDes():Boolean {
			return null != skillDes_;
		}
		public function set skillDes(value:String):void {
			skillDes_ = value;
		}
		public function get skillDes():String {
			return skillDes_;
		}
		private var releasePreEnergy_:int;
		private var hasReleasePreEnergy_:Boolean = false;
		public function get hasReleasePreEnergy():Boolean {
			return hasReleasePreEnergy_;
		}
		public function set releasePreEnergy(value:int):void {
			hasReleasePreEnergy_ = true;
			releasePreEnergy_ = value;
		}
		public function get releasePreEnergy():int {
			return releasePreEnergy_;
		}
		private var levelUpEffect_:String;
		public function get hasLevelUpEffect():Boolean {
			return null != levelUpEffect_;
		}
		public function set levelUpEffect(value:String):void {
			levelUpEffect_ = value;
		}
		public function get levelUpEffect():String {
			return levelUpEffect_;
		}
		private var levelUpProps_:String;
		public function get hasLevelUpProps():Boolean {
			return null != levelUpProps_;
		}
		public function set levelUpProps(value:String):void {
			levelUpProps_ = value;
		}
		public function get levelUpProps():String {
			return levelUpProps_;
		}
		private var levelUpMoney_:int;
		private var hasLevelUpMoney_:Boolean = false;
		public function get hasLevelUpMoney():Boolean {
			return hasLevelUpMoney_;
		}
		public function set levelUpMoney(value:int):void {
			hasLevelUpMoney_ = true;
			levelUpMoney_ = value;
		}
		public function get levelUpMoney():int {
			return levelUpMoney_;
		}
		private var levelUpRoleLevel_:int;
		private var hasLevelUpRoleLevel_:Boolean = false;
		public function get hasLevelUpRoleLevel():Boolean {
			return hasLevelUpRoleLevel_;
		}
		public function set levelUpRoleLevel(value:int):void {
			hasLevelUpRoleLevel_ = true;
			levelUpRoleLevel_ = value;
		}
		public function get levelUpRoleLevel():int {
			return levelUpRoleLevel_;
		}
		private var skillStatus_:int;
		private var hasSkillStatus_:Boolean = false;
		public function get hasSkillStatus():Boolean {
			return hasSkillStatus_;
		}
		public function set skillStatus(value:int):void {
			hasSkillStatus_ = true;
			skillStatus_ = value;
		}
		public function get skillStatus():int {
			return skillStatus_;
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
		private var skillType_:int;
		private var hasSkillType_:Boolean = false;
		public function get hasSkillType():Boolean {
			return hasSkillType_;
		}
		public function set skillType(value:int):void {
			hasSkillType_ = true;
			skillType_ = value;
		}
		public function get skillType():int {
			return skillType_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasSkillId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, skillId);
			}
			if (hasSkillName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, skillName);
			}
			if (hasSkillLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, skillLevel);
			}
			if (hasRemainRoleLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, remainRoleLevel);
			}
			if (hasSkillDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, skillDes);
			}
			if (hasReleasePreEnergy) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, releasePreEnergy);
			}
			if (hasLevelUpEffect) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, levelUpEffect);
			}
			if (hasLevelUpProps) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, levelUpProps);
			}
			if (hasLevelUpMoney) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, levelUpMoney);
			}
			if (hasLevelUpRoleLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, levelUpRoleLevel);
			}
			if (hasSkillStatus) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, skillStatus);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasSkillType) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, skillType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var skillIdCount:uint = 0;
			var skillNameCount:uint = 0;
			var skillLevelCount:uint = 0;
			var remainRoleLevelCount:uint = 0;
			var skillDesCount:uint = 0;
			var releasePreEnergyCount:uint = 0;
			var levelUpEffectCount:uint = 0;
			var levelUpPropsCount:uint = 0;
			var levelUpMoneyCount:uint = 0;
			var levelUpRoleLevelCount:uint = 0;
			var skillStatusCount:uint = 0;
			var iconCount:uint = 0;
			var typeCount:uint = 0;
			var skillTypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (skillIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++skillIdCount;
					skillId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (skillNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++skillNameCount;
					skillName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (skillLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++skillLevelCount;
					skillLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (remainRoleLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainRoleLevelCount;
					remainRoleLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (skillDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++skillDesCount;
					skillDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (releasePreEnergyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++releasePreEnergyCount;
					releasePreEnergy = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (levelUpEffectCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelUpEffectCount;
					levelUpEffect = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (levelUpPropsCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelUpPropsCount;
					levelUpProps = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (levelUpMoneyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelUpMoneyCount;
					levelUpMoney = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (levelUpRoleLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelUpRoleLevelCount;
					levelUpRoleLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (skillStatusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++skillStatusCount;
					skillStatus = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (skillTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++skillTypeCount;
					skillType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
