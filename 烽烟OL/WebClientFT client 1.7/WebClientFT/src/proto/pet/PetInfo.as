package proto.pet {
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
		private var inMatrixFlag_:Boolean;
		private var hasInMatrixFlag_:Boolean = false;
		public function get hasInMatrixFlag():Boolean {
			return hasInMatrixFlag_;
		}
		public function set inMatrixFlag(value:Boolean):void {
			hasInMatrixFlag_ = true;
			inMatrixFlag_ = value;
		}
		public function get inMatrixFlag():Boolean {
			return inMatrixFlag_;
		}
		private var petDes_:String;
		public function get hasPetDes():Boolean {
			return null != petDes_;
		}
		public function set petDes(value:String):void {
			petDes_ = value;
		}
		public function get petDes():String {
			return petDes_;
		}
		private var baseHp_:int;
		private var hasBaseHp_:Boolean = false;
		public function get hasBaseHp():Boolean {
			return hasBaseHp_;
		}
		public function set baseHp(value:int):void {
			hasBaseHp_ = true;
			baseHp_ = value;
		}
		public function get baseHp():int {
			return baseHp_;
		}
		private var manualHp_:int;
		private var hasManualHp_:Boolean = false;
		public function get hasManualHp():Boolean {
			return hasManualHp_;
		}
		public function set manualHp(value:int):void {
			hasManualHp_ = true;
			manualHp_ = value;
		}
		public function get manualHp():int {
			return manualHp_;
		}
		private var basePhyAttack_:int;
		private var hasBasePhyAttack_:Boolean = false;
		public function get hasBasePhyAttack():Boolean {
			return hasBasePhyAttack_;
		}
		public function set basePhyAttack(value:int):void {
			hasBasePhyAttack_ = true;
			basePhyAttack_ = value;
		}
		public function get basePhyAttack():int {
			return basePhyAttack_;
		}
		private var manualPhyAttack_:int;
		private var hasManualPhyAttack_:Boolean = false;
		public function get hasManualPhyAttack():Boolean {
			return hasManualPhyAttack_;
		}
		public function set manualPhyAttack(value:int):void {
			hasManualPhyAttack_ = true;
			manualPhyAttack_ = value;
		}
		public function get manualPhyAttack():int {
			return manualPhyAttack_;
		}
		private var baseMagicAttack_:int;
		private var hasBaseMagicAttack_:Boolean = false;
		public function get hasBaseMagicAttack():Boolean {
			return hasBaseMagicAttack_;
		}
		public function set baseMagicAttack(value:int):void {
			hasBaseMagicAttack_ = true;
			baseMagicAttack_ = value;
		}
		public function get baseMagicAttack():int {
			return baseMagicAttack_;
		}
		private var manualMagicAttack_:int;
		private var hasManualMagicAttack_:Boolean = false;
		public function get hasManualMagicAttack():Boolean {
			return hasManualMagicAttack_;
		}
		public function set manualMagicAttack(value:int):void {
			hasManualMagicAttack_ = true;
			manualMagicAttack_ = value;
		}
		public function get manualMagicAttack():int {
			return manualMagicAttack_;
		}
		private var basePhyDefense_:int;
		private var hasBasePhyDefense_:Boolean = false;
		public function get hasBasePhyDefense():Boolean {
			return hasBasePhyDefense_;
		}
		public function set basePhyDefense(value:int):void {
			hasBasePhyDefense_ = true;
			basePhyDefense_ = value;
		}
		public function get basePhyDefense():int {
			return basePhyDefense_;
		}
		private var manualPhyDefense_:int;
		private var hasManualPhyDefense_:Boolean = false;
		public function get hasManualPhyDefense():Boolean {
			return hasManualPhyDefense_;
		}
		public function set manualPhyDefense(value:int):void {
			hasManualPhyDefense_ = true;
			manualPhyDefense_ = value;
		}
		public function get manualPhyDefense():int {
			return manualPhyDefense_;
		}
		private var baseMagicDefense_:int;
		private var hasBaseMagicDefense_:Boolean = false;
		public function get hasBaseMagicDefense():Boolean {
			return hasBaseMagicDefense_;
		}
		public function set baseMagicDefense(value:int):void {
			hasBaseMagicDefense_ = true;
			baseMagicDefense_ = value;
		}
		public function get baseMagicDefense():int {
			return baseMagicDefense_;
		}
		private var manualMagicDefense_:int;
		private var hasManualMagicDefense_:Boolean = false;
		public function get hasManualMagicDefense():Boolean {
			return hasManualMagicDefense_;
		}
		public function set manualMagicDefense(value:int):void {
			hasManualMagicDefense_ = true;
			manualMagicDefense_ = value;
		}
		public function get manualMagicDefense():int {
			return manualMagicDefense_;
		}
		private var baseHitRate_:int;
		private var hasBaseHitRate_:Boolean = false;
		public function get hasBaseHitRate():Boolean {
			return hasBaseHitRate_;
		}
		public function set baseHitRate(value:int):void {
			hasBaseHitRate_ = true;
			baseHitRate_ = value;
		}
		public function get baseHitRate():int {
			return baseHitRate_;
		}
		private var manualHitRate_:int;
		private var hasManualHitRate_:Boolean = false;
		public function get hasManualHitRate():Boolean {
			return hasManualHitRate_;
		}
		public function set manualHitRate(value:int):void {
			hasManualHitRate_ = true;
			manualHitRate_ = value;
		}
		public function get manualHitRate():int {
			return manualHitRate_;
		}
		private var baseDodgeRate_:int;
		private var hasBaseDodgeRate_:Boolean = false;
		public function get hasBaseDodgeRate():Boolean {
			return hasBaseDodgeRate_;
		}
		public function set baseDodgeRate(value:int):void {
			hasBaseDodgeRate_ = true;
			baseDodgeRate_ = value;
		}
		public function get baseDodgeRate():int {
			return baseDodgeRate_;
		}
		private var manualDodgeRate_:int;
		private var hasManualDodgeRate_:Boolean = false;
		public function get hasManualDodgeRate():Boolean {
			return hasManualDodgeRate_;
		}
		public function set manualDodgeRate(value:int):void {
			hasManualDodgeRate_ = true;
			manualDodgeRate_ = value;
		}
		public function get manualDodgeRate():int {
			return manualDodgeRate_;
		}
		private var baseSpeed_:int;
		private var hasBaseSpeed_:Boolean = false;
		public function get hasBaseSpeed():Boolean {
			return hasBaseSpeed_;
		}
		public function set baseSpeed(value:int):void {
			hasBaseSpeed_ = true;
			baseSpeed_ = value;
		}
		public function get baseSpeed():int {
			return baseSpeed_;
		}
		private var manualSpeed_:int;
		private var hasManualSpeed_:Boolean = false;
		public function get hasManualSpeed():Boolean {
			return hasManualSpeed_;
		}
		public function set manualSpeed(value:int):void {
			hasManualSpeed_ = true;
			manualSpeed_ = value;
		}
		public function get manualSpeed():int {
			return manualSpeed_;
		}
		private var baseCritRate_:int;
		private var hasBaseCritRate_:Boolean = false;
		public function get hasBaseCritRate():Boolean {
			return hasBaseCritRate_;
		}
		public function set baseCritRate(value:int):void {
			hasBaseCritRate_ = true;
			baseCritRate_ = value;
		}
		public function get baseCritRate():int {
			return baseCritRate_;
		}
		private var manualCritRate_:int;
		private var hasManualCritRate_:Boolean = false;
		public function get hasManualCritRate():Boolean {
			return hasManualCritRate_;
		}
		public function set manualCritRate(value:int):void {
			hasManualCritRate_ = true;
			manualCritRate_ = value;
		}
		public function get manualCritRate():int {
			return manualCritRate_;
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
		private var petSkillInfo_:String;
		public function get hasPetSkillInfo():Boolean {
			return null != petSkillInfo_;
		}
		public function set petSkillInfo(value:String):void {
			petSkillInfo_ = value;
		}
		public function get petSkillInfo():String {
			return petSkillInfo_;
		}
		private var flowFlag_:Boolean;
		private var hasFlowFlag_:Boolean = false;
		public function get hasFlowFlag():Boolean {
			return hasFlowFlag_;
		}
		public function set flowFlag(value:Boolean):void {
			hasFlowFlag_ = true;
			flowFlag_ = value;
		}
		public function get flowFlag():Boolean {
			return flowFlag_;
		}
		private var baseBlock_:int;
		private var hasBaseBlock_:Boolean = false;
		public function get hasBaseBlock():Boolean {
			return hasBaseBlock_;
		}
		public function set baseBlock(value:int):void {
			hasBaseBlock_ = true;
			baseBlock_ = value;
		}
		public function get baseBlock():int {
			return baseBlock_;
		}
		private var manualBlock_:int;
		private var hasManualBlock_:Boolean = false;
		public function get hasManualBlock():Boolean {
			return hasManualBlock_;
		}
		public function set manualBlock(value:int):void {
			hasManualBlock_ = true;
			manualBlock_ = value;
		}
		public function get manualBlock():int {
			return manualBlock_;
		}
		private var liliang_:int;
		private var hasLiliang_:Boolean = false;
		public function get hasLiliang():Boolean {
			return hasLiliang_;
		}
		public function set liliang(value:int):void {
			hasLiliang_ = true;
			liliang_ = value;
		}
		public function get liliang():int {
			return liliang_;
		}
		private var zhili_:int;
		private var hasZhili_:Boolean = false;
		public function get hasZhili():Boolean {
			return hasZhili_;
		}
		public function set zhili(value:int):void {
			hasZhili_ = true;
			zhili_ = value;
		}
		public function get zhili():int {
			return zhili_;
		}
		private var naili_:int;
		private var hasNaili_:Boolean = false;
		public function get hasNaili():Boolean {
			return hasNaili_;
		}
		public function set naili(value:int):void {
			hasNaili_ = true;
			naili_ = value;
		}
		public function get naili():int {
			return naili_;
		}
		private var minjie_:int;
		private var hasMinjie_:Boolean = false;
		public function get hasMinjie():Boolean {
			return hasMinjie_;
		}
		public function set minjie(value:int):void {
			hasMinjie_ = true;
			minjie_ = value;
		}
		public function get minjie():int {
			return minjie_;
		}
		private var maxHp_:int;
		private var hasMaxHp_:Boolean = false;
		public function get hasMaxHp():Boolean {
			return hasMaxHp_;
		}
		public function set maxHp(value:int):void {
			hasMaxHp_ = true;
			maxHp_ = value;
		}
		public function get maxHp():int {
			return maxHp_;
		}
		private var curExp_:int;
		private var hasCurExp_:Boolean = false;
		public function get hasCurExp():Boolean {
			return hasCurExp_;
		}
		public function set curExp(value:int):void {
			hasCurExp_ = true;
			curExp_ = value;
		}
		public function get curExp():int {
			return curExp_;
		}
		private var maxExp_:int;
		private var hasMaxExp_:Boolean = false;
		public function get hasMaxExp():Boolean {
			return hasMaxExp_;
		}
		public function set maxExp(value:int):void {
			hasMaxExp_ = true;
			maxExp_ = value;
		}
		public function get maxExp():int {
			return maxExp_;
		}
		private var curQuality_:int;
		private var hasCurQuality_:Boolean = false;
		public function get hasCurQuality():Boolean {
			return hasCurQuality_;
		}
		public function set curQuality(value:int):void {
			hasCurQuality_ = true;
			curQuality_ = value;
		}
		public function get curQuality():int {
			return curQuality_;
		}
		private var texing_:String;
		public function get hasTexing():Boolean {
			return null != texing_;
		}
		public function set texing(value:String):void {
			texing_ = value;
		}
		public function get texing():String {
			return texing_;
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
			if (hasInMatrixFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_BOOL(output, inMatrixFlag);
			}
			if (hasPetDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, petDes);
			}
			if (hasBaseHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, baseHp);
			}
			if (hasManualHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, manualHp);
			}
			if (hasBasePhyAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, basePhyAttack);
			}
			if (hasManualPhyAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, manualPhyAttack);
			}
			if (hasBaseMagicAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, baseMagicAttack);
			}
			if (hasManualMagicAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, manualMagicAttack);
			}
			if (hasBasePhyDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, basePhyDefense);
			}
			if (hasManualPhyDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, manualPhyDefense);
			}
			if (hasBaseMagicDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, baseMagicDefense);
			}
			if (hasManualMagicDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, manualMagicDefense);
			}
			if (hasBaseHitRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, baseHitRate);
			}
			if (hasManualHitRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, manualHitRate);
			}
			if (hasBaseDodgeRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, baseDodgeRate);
			}
			if (hasManualDodgeRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, manualDodgeRate);
			}
			if (hasBaseSpeed) {
				WriteUtils.writeTag(output, WireType.VARINT, 21);
				WriteUtils.write_TYPE_INT32(output, baseSpeed);
			}
			if (hasManualSpeed) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, manualSpeed);
			}
			if (hasBaseCritRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, baseCritRate);
			}
			if (hasManualCritRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_INT32(output, manualCritRate);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 25);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 26);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasPetSkillInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 27);
				WriteUtils.write_TYPE_STRING(output, petSkillInfo);
			}
			if (hasFlowFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 28);
				WriteUtils.write_TYPE_BOOL(output, flowFlag);
			}
			if (hasBaseBlock) {
				WriteUtils.writeTag(output, WireType.VARINT, 29);
				WriteUtils.write_TYPE_INT32(output, baseBlock);
			}
			if (hasManualBlock) {
				WriteUtils.writeTag(output, WireType.VARINT, 30);
				WriteUtils.write_TYPE_INT32(output, manualBlock);
			}
			if (hasLiliang) {
				WriteUtils.writeTag(output, WireType.VARINT, 31);
				WriteUtils.write_TYPE_INT32(output, liliang);
			}
			if (hasZhili) {
				WriteUtils.writeTag(output, WireType.VARINT, 32);
				WriteUtils.write_TYPE_INT32(output, zhili);
			}
			if (hasNaili) {
				WriteUtils.writeTag(output, WireType.VARINT, 33);
				WriteUtils.write_TYPE_INT32(output, naili);
			}
			if (hasMinjie) {
				WriteUtils.writeTag(output, WireType.VARINT, 34);
				WriteUtils.write_TYPE_INT32(output, minjie);
			}
			if (hasMaxHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 35);
				WriteUtils.write_TYPE_INT32(output, maxHp);
			}
			if (hasCurExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 36);
				WriteUtils.write_TYPE_INT32(output, curExp);
			}
			if (hasMaxExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 37);
				WriteUtils.write_TYPE_INT32(output, maxExp);
			}
			if (hasCurQuality) {
				WriteUtils.writeTag(output, WireType.VARINT, 38);
				WriteUtils.write_TYPE_INT32(output, curQuality);
			}
			if (hasTexing) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 39);
				WriteUtils.write_TYPE_STRING(output, texing);
			}
		}
		public function readExternal(input:IDataInput):void {
			var petIdCount:uint = 0;
			var resPetIdCount:uint = 0;
			var petNameCount:uint = 0;
			var petLevelCount:uint = 0;
			var inMatrixFlagCount:uint = 0;
			var petDesCount:uint = 0;
			var baseHpCount:uint = 0;
			var manualHpCount:uint = 0;
			var basePhyAttackCount:uint = 0;
			var manualPhyAttackCount:uint = 0;
			var baseMagicAttackCount:uint = 0;
			var manualMagicAttackCount:uint = 0;
			var basePhyDefenseCount:uint = 0;
			var manualPhyDefenseCount:uint = 0;
			var baseMagicDefenseCount:uint = 0;
			var manualMagicDefenseCount:uint = 0;
			var baseHitRateCount:uint = 0;
			var manualHitRateCount:uint = 0;
			var baseDodgeRateCount:uint = 0;
			var manualDodgeRateCount:uint = 0;
			var baseSpeedCount:uint = 0;
			var manualSpeedCount:uint = 0;
			var baseCritRateCount:uint = 0;
			var manualCritRateCount:uint = 0;
			var iconCount:uint = 0;
			var typeCount:uint = 0;
			var petSkillInfoCount:uint = 0;
			var flowFlagCount:uint = 0;
			var baseBlockCount:uint = 0;
			var manualBlockCount:uint = 0;
			var liliangCount:uint = 0;
			var zhiliCount:uint = 0;
			var nailiCount:uint = 0;
			var minjieCount:uint = 0;
			var maxHpCount:uint = 0;
			var curExpCount:uint = 0;
			var maxExpCount:uint = 0;
			var curQualityCount:uint = 0;
			var texingCount:uint = 0;
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
					if (inMatrixFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++inMatrixFlagCount;
					inMatrixFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 6:
					if (petDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petDesCount;
					petDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (baseHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseHpCount;
					baseHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (manualHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualHpCount;
					manualHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (basePhyAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++basePhyAttackCount;
					basePhyAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (manualPhyAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualPhyAttackCount;
					manualPhyAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (baseMagicAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseMagicAttackCount;
					baseMagicAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (manualMagicAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualMagicAttackCount;
					manualMagicAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (basePhyDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++basePhyDefenseCount;
					basePhyDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (manualPhyDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualPhyDefenseCount;
					manualPhyDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (baseMagicDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseMagicDefenseCount;
					baseMagicDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (manualMagicDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualMagicDefenseCount;
					manualMagicDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (baseHitRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseHitRateCount;
					baseHitRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 18:
					if (manualHitRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualHitRateCount;
					manualHitRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 19:
					if (baseDodgeRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseDodgeRateCount;
					baseDodgeRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (manualDodgeRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualDodgeRateCount;
					manualDodgeRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 21:
					if (baseSpeedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseSpeedCount;
					baseSpeed = ReadUtils.read_TYPE_INT32(input);
					break;
				case 22:
					if (manualSpeedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualSpeedCount;
					manualSpeed = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (baseCritRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseCritRateCount;
					baseCritRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (manualCritRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualCritRateCount;
					manualCritRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 25:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 26:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 27:
					if (petSkillInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petSkillInfoCount;
					petSkillInfo = ReadUtils.read_TYPE_STRING(input);
					break;
				case 28:
					if (flowFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++flowFlagCount;
					flowFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 29:
					if (baseBlockCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseBlockCount;
					baseBlock = ReadUtils.read_TYPE_INT32(input);
					break;
				case 30:
					if (manualBlockCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualBlockCount;
					manualBlock = ReadUtils.read_TYPE_INT32(input);
					break;
				case 31:
					if (liliangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++liliangCount;
					liliang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 32:
					if (zhiliCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zhiliCount;
					zhili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 33:
					if (nailiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nailiCount;
					naili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 34:
					if (minjieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++minjieCount;
					minjie = ReadUtils.read_TYPE_INT32(input);
					break;
				case 35:
					if (maxHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxHpCount;
					maxHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 36:
					if (curExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curExpCount;
					curExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 37:
					if (maxExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxExpCount;
					maxExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 38:
					if (curQualityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curQualityCount;
					curQuality = ReadUtils.read_TYPE_INT32(input);
					break;
				case 39:
					if (texingCount != 0) {
						throw new IOError('Bad data format.');
					}
					++texingCount;
					texing = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
