package proto.shop.shop206 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.shop.shop206.Suite;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ItemsInfo extends Message implements IExternalizable {
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
		private var prefixNmae_:String;
		public function get hasPrefixNmae():Boolean {
			return null != prefixNmae_;
		}
		public function set prefixNmae(value:String):void {
			prefixNmae_ = value;
		}
		public function get prefixNmae():String {
			return prefixNmae_;
		}
		private var suffixName_:String;
		public function get hasSuffixName():Boolean {
			return null != suffixName_;
		}
		public function set suffixName(value:String):void {
			suffixName_ = value;
		}
		public function get suffixName():String {
			return suffixName_;
		}
		private var bindType_:int;
		private var hasBindType_:Boolean = false;
		public function get hasBindType():Boolean {
			return hasBindType_;
		}
		public function set bindType(value:int):void {
			hasBindType_ = true;
			bindType_ = value;
		}
		public function get bindType():int {
			return bindType_;
		}
		private var isBound_:int;
		private var hasIsBound_:Boolean = false;
		public function get hasIsBound():Boolean {
			return hasIsBound_;
		}
		public function set isBound(value:int):void {
			hasIsBound_ = true;
			isBound_ = value;
		}
		public function get isBound():int {
			return isBound_;
		}
		private var description_:String;
		public function get hasDescription():Boolean {
			return null != description_;
		}
		public function set description(value:String):void {
			description_ = value;
		}
		public function get description():String {
			return description_;
		}
		private var professionRequire_:int;
		private var hasProfessionRequire_:Boolean = false;
		public function get hasProfessionRequire():Boolean {
			return hasProfessionRequire_;
		}
		public function set professionRequire(value:int):void {
			hasProfessionRequire_ = true;
			professionRequire_ = value;
		}
		public function get professionRequire():int {
			return professionRequire_;
		}
		private var canInjection_:int;
		private var hasCanInjection_:Boolean = false;
		public function get hasCanInjection():Boolean {
			return hasCanInjection_;
		}
		public function set canInjection(value:int):void {
			hasCanInjection_ = true;
			canInjection_ = value;
		}
		public function get canInjection():int {
			return canInjection_;
		}
		private var bodyType_:int;
		private var hasBodyType_:Boolean = false;
		public function get hasBodyType():Boolean {
			return hasBodyType_;
		}
		public function set bodyType(value:int):void {
			hasBodyType_ = true;
			bodyType_ = value;
		}
		public function get bodyType():int {
			return bodyType_;
		}
		private var weaponType_:int;
		private var hasWeaponType_:Boolean = false;
		public function get hasWeaponType():Boolean {
			return hasWeaponType_;
		}
		public function set weaponType(value:int):void {
			hasWeaponType_ = true;
			weaponType_ = value;
		}
		public function get weaponType():int {
			return weaponType_;
		}
		private var nowQuality_:int;
		private var hasNowQuality_:Boolean = false;
		public function get hasNowQuality():Boolean {
			return hasNowQuality_;
		}
		public function set nowQuality(value:int):void {
			hasNowQuality_ = true;
			nowQuality_ = value;
		}
		public function get nowQuality():int {
			return nowQuality_;
		}
		private var baseAttack_:int;
		private var hasBaseAttack_:Boolean = false;
		public function get hasBaseAttack():Boolean {
			return hasBaseAttack_;
		}
		public function set baseAttack(value:int):void {
			hasBaseAttack_ = true;
			baseAttack_ = value;
		}
		public function get baseAttack():int {
			return baseAttack_;
		}
		private var extAttack_:int;
		private var hasExtAttack_:Boolean = false;
		public function get hasExtAttack():Boolean {
			return hasExtAttack_;
		}
		public function set extAttack(value:int):void {
			hasExtAttack_ = true;
			extAttack_ = value;
		}
		public function get extAttack():int {
			return extAttack_;
		}
		private var attackType_:int;
		private var hasAttackType_:Boolean = false;
		public function get hasAttackType():Boolean {
			return hasAttackType_;
		}
		public function set attackType(value:int):void {
			hasAttackType_ = true;
			attackType_ = value;
		}
		public function get attackType():int {
			return attackType_;
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
		private var levelRequire_:int;
		private var hasLevelRequire_:Boolean = false;
		public function get hasLevelRequire():Boolean {
			return hasLevelRequire_;
		}
		public function set levelRequire(value:int):void {
			hasLevelRequire_ = true;
			levelRequire_ = value;
		}
		public function get levelRequire():int {
			return levelRequire_;
		}
		private var baseStr_:int;
		private var hasBaseStr_:Boolean = false;
		public function get hasBaseStr():Boolean {
			return hasBaseStr_;
		}
		public function set baseStr(value:int):void {
			hasBaseStr_ = true;
			baseStr_ = value;
		}
		public function get baseStr():int {
			return baseStr_;
		}
		private var extStr_:int;
		private var hasExtStr_:Boolean = false;
		public function get hasExtStr():Boolean {
			return hasExtStr_;
		}
		public function set extStr(value:int):void {
			hasExtStr_ = true;
			extStr_ = value;
		}
		public function get extStr():int {
			return extStr_;
		}
		private var baseVit_:int;
		private var hasBaseVit_:Boolean = false;
		public function get hasBaseVit():Boolean {
			return hasBaseVit_;
		}
		public function set baseVit(value:int):void {
			hasBaseVit_ = true;
			baseVit_ = value;
		}
		public function get baseVit():int {
			return baseVit_;
		}
		private var extVit_:int;
		private var hasExtVit_:Boolean = false;
		public function get hasExtVit():Boolean {
			return hasExtVit_;
		}
		public function set extVit(value:int):void {
			hasExtVit_ = true;
			extVit_ = value;
		}
		public function get extVit():int {
			return extVit_;
		}
		private var baseDex_:int;
		private var hasBaseDex_:Boolean = false;
		public function get hasBaseDex():Boolean {
			return hasBaseDex_;
		}
		public function set baseDex(value:int):void {
			hasBaseDex_ = true;
			baseDex_ = value;
		}
		public function get baseDex():int {
			return baseDex_;
		}
		private var extDex_:int;
		private var hasExtDex_:Boolean = false;
		public function get hasExtDex():Boolean {
			return hasExtDex_;
		}
		public function set extDex(value:int):void {
			hasExtDex_ = true;
			extDex_ = value;
		}
		public function get extDex():int {
			return extDex_;
		}
		private var baseWis_:int;
		private var hasBaseWis_:Boolean = false;
		public function get hasBaseWis():Boolean {
			return hasBaseWis_;
		}
		public function set baseWis(value:int):void {
			hasBaseWis_ = true;
			baseWis_ = value;
		}
		public function get baseWis():int {
			return baseWis_;
		}
		private var extWis_:int;
		private var hasExtWis_:Boolean = false;
		public function get hasExtWis():Boolean {
			return hasExtWis_;
		}
		public function set extWis(value:int):void {
			hasExtWis_ = true;
			extWis_ = value;
		}
		public function get extWis():int {
			return extWis_;
		}
		private var baseSpi_:int;
		private var hasBaseSpi_:Boolean = false;
		public function get hasBaseSpi():Boolean {
			return hasBaseSpi_;
		}
		public function set baseSpi(value:int):void {
			hasBaseSpi_ = true;
			baseSpi_ = value;
		}
		public function get baseSpi():int {
			return baseSpi_;
		}
		private var extSpi_:int;
		private var hasExtSpi_:Boolean = false;
		public function get hasExtSpi():Boolean {
			return hasExtSpi_;
		}
		public function set extSpi(value:int):void {
			hasExtSpi_ = true;
			extSpi_ = value;
		}
		public function get extSpi():int {
			return extSpi_;
		}
		private var basePhysicalAttack_:int;
		private var hasBasePhysicalAttack_:Boolean = false;
		public function get hasBasePhysicalAttack():Boolean {
			return hasBasePhysicalAttack_;
		}
		public function set basePhysicalAttack(value:int):void {
			hasBasePhysicalAttack_ = true;
			basePhysicalAttack_ = value;
		}
		public function get basePhysicalAttack():int {
			return basePhysicalAttack_;
		}
		private var extPhysicalAttack_:int;
		private var hasExtPhysicalAttack_:Boolean = false;
		public function get hasExtPhysicalAttack():Boolean {
			return hasExtPhysicalAttack_;
		}
		public function set extPhysicalAttack(value:int):void {
			hasExtPhysicalAttack_ = true;
			extPhysicalAttack_ = value;
		}
		public function get extPhysicalAttack():int {
			return extPhysicalAttack_;
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
		private var extMagicAttack_:int;
		private var hasExtMagicAttack_:Boolean = false;
		public function get hasExtMagicAttack():Boolean {
			return hasExtMagicAttack_;
		}
		public function set extMagicAttack(value:int):void {
			hasExtMagicAttack_ = true;
			extMagicAttack_ = value;
		}
		public function get extMagicAttack():int {
			return extMagicAttack_;
		}
		private var basePhysicalDefense_:int;
		private var hasBasePhysicalDefense_:Boolean = false;
		public function get hasBasePhysicalDefense():Boolean {
			return hasBasePhysicalDefense_;
		}
		public function set basePhysicalDefense(value:int):void {
			hasBasePhysicalDefense_ = true;
			basePhysicalDefense_ = value;
		}
		public function get basePhysicalDefense():int {
			return basePhysicalDefense_;
		}
		private var extPhysicalDefense_:int;
		private var hasExtPhysicalDefense_:Boolean = false;
		public function get hasExtPhysicalDefense():Boolean {
			return hasExtPhysicalDefense_;
		}
		public function set extPhysicalDefense(value:int):void {
			hasExtPhysicalDefense_ = true;
			extPhysicalDefense_ = value;
		}
		public function get extPhysicalDefense():int {
			return extPhysicalDefense_;
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
		private var extMagicDefense_:int;
		private var hasExtMagicDefense_:Boolean = false;
		public function get hasExtMagicDefense():Boolean {
			return hasExtMagicDefense_;
		}
		public function set extMagicDefense(value:int):void {
			hasExtMagicDefense_ = true;
			extMagicDefense_ = value;
		}
		public function get extMagicDefense():int {
			return extMagicDefense_;
		}
		private var baseHpAdditional_:int;
		private var hasBaseHpAdditional_:Boolean = false;
		public function get hasBaseHpAdditional():Boolean {
			return hasBaseHpAdditional_;
		}
		public function set baseHpAdditional(value:int):void {
			hasBaseHpAdditional_ = true;
			baseHpAdditional_ = value;
		}
		public function get baseHpAdditional():int {
			return baseHpAdditional_;
		}
		private var extHpAdditional_:int;
		private var hasExtHpAdditional_:Boolean = false;
		public function get hasExtHpAdditional():Boolean {
			return hasExtHpAdditional_;
		}
		public function set extHpAdditional(value:int):void {
			hasExtHpAdditional_ = true;
			extHpAdditional_ = value;
		}
		public function get extHpAdditional():int {
			return extHpAdditional_;
		}
		private var baseMpAdditional_:int;
		private var hasBaseMpAdditional_:Boolean = false;
		public function get hasBaseMpAdditional():Boolean {
			return hasBaseMpAdditional_;
		}
		public function set baseMpAdditional(value:int):void {
			hasBaseMpAdditional_ = true;
			baseMpAdditional_ = value;
		}
		public function get baseMpAdditional():int {
			return baseMpAdditional_;
		}
		private var extMpAdditional_:int;
		private var hasExtMpAdditional_:Boolean = false;
		public function get hasExtMpAdditional():Boolean {
			return hasExtMpAdditional_;
		}
		public function set extMpAdditional(value:int):void {
			hasExtMpAdditional_ = true;
			extMpAdditional_ = value;
		}
		public function get extMpAdditional():int {
			return extMpAdditional_;
		}
		private var baseHitAdditional_:int;
		private var hasBaseHitAdditional_:Boolean = false;
		public function get hasBaseHitAdditional():Boolean {
			return hasBaseHitAdditional_;
		}
		public function set baseHitAdditional(value:int):void {
			hasBaseHitAdditional_ = true;
			baseHitAdditional_ = value;
		}
		public function get baseHitAdditional():int {
			return baseHitAdditional_;
		}
		private var extHitAdditional_:int;
		private var hasExtHitAdditional_:Boolean = false;
		public function get hasExtHitAdditional():Boolean {
			return hasExtHitAdditional_;
		}
		public function set extHitAdditional(value:int):void {
			hasExtHitAdditional_ = true;
			extHitAdditional_ = value;
		}
		public function get extHitAdditional():int {
			return extHitAdditional_;
		}
		private var baseCritAdditional_:int;
		private var hasBaseCritAdditional_:Boolean = false;
		public function get hasBaseCritAdditional():Boolean {
			return hasBaseCritAdditional_;
		}
		public function set baseCritAdditional(value:int):void {
			hasBaseCritAdditional_ = true;
			baseCritAdditional_ = value;
		}
		public function get baseCritAdditional():int {
			return baseCritAdditional_;
		}
		private var extCritAdditional_:int;
		private var hasExtCritAdditional_:Boolean = false;
		public function get hasExtCritAdditional():Boolean {
			return hasExtCritAdditional_;
		}
		public function set extCritAdditional(value:int):void {
			hasExtCritAdditional_ = true;
			extCritAdditional_ = value;
		}
		public function get extCritAdditional():int {
			return extCritAdditional_;
		}
		private var baseDodgeAdditional_:int;
		private var hasBaseDodgeAdditional_:Boolean = false;
		public function get hasBaseDodgeAdditional():Boolean {
			return hasBaseDodgeAdditional_;
		}
		public function set baseDodgeAdditional(value:int):void {
			hasBaseDodgeAdditional_ = true;
			baseDodgeAdditional_ = value;
		}
		public function get baseDodgeAdditional():int {
			return baseDodgeAdditional_;
		}
		private var extDodgeAdditional_:int;
		private var hasExtDodgeAdditional_:Boolean = false;
		public function get hasExtDodgeAdditional():Boolean {
			return hasExtDodgeAdditional_;
		}
		public function set extDodgeAdditional(value:int):void {
			hasExtDodgeAdditional_ = true;
			extDodgeAdditional_ = value;
		}
		public function get extDodgeAdditional():int {
			return extDodgeAdditional_;
		}
		private var baseSquelchAdditional_:int;
		private var hasBaseSquelchAdditional_:Boolean = false;
		public function get hasBaseSquelchAdditional():Boolean {
			return hasBaseSquelchAdditional_;
		}
		public function set baseSquelchAdditional(value:int):void {
			hasBaseSquelchAdditional_ = true;
			baseSquelchAdditional_ = value;
		}
		public function get baseSquelchAdditional():int {
			return baseSquelchAdditional_;
		}
		private var extSquelchAdditional_:int;
		private var hasExtSquelchAdditional_:Boolean = false;
		public function get hasExtSquelchAdditional():Boolean {
			return hasExtSquelchAdditional_;
		}
		public function set extSquelchAdditional(value:int):void {
			hasExtSquelchAdditional_ = true;
			extSquelchAdditional_ = value;
		}
		public function get extSquelchAdditional():int {
			return extSquelchAdditional_;
		}
		private var baseSpeedAdditional_:int;
		private var hasBaseSpeedAdditional_:Boolean = false;
		public function get hasBaseSpeedAdditional():Boolean {
			return hasBaseSpeedAdditional_;
		}
		public function set baseSpeedAdditional(value:int):void {
			hasBaseSpeedAdditional_ = true;
			baseSpeedAdditional_ = value;
		}
		public function get baseSpeedAdditional():int {
			return baseSpeedAdditional_;
		}
		private var extSpeedAdditional_:int;
		private var hasExtSpeedAdditional_:Boolean = false;
		public function get hasExtSpeedAdditional():Boolean {
			return hasExtSpeedAdditional_;
		}
		public function set extSpeedAdditional(value:int):void {
			hasExtSpeedAdditional_ = true;
			extSpeedAdditional_ = value;
		}
		public function get extSpeedAdditional():int {
			return extSpeedAdditional_;
		}
		private var baseBogeyAdditional_:int;
		private var hasBaseBogeyAdditional_:Boolean = false;
		public function get hasBaseBogeyAdditional():Boolean {
			return hasBaseBogeyAdditional_;
		}
		public function set baseBogeyAdditional(value:int):void {
			hasBaseBogeyAdditional_ = true;
			baseBogeyAdditional_ = value;
		}
		public function get baseBogeyAdditional():int {
			return baseBogeyAdditional_;
		}
		private var extBogeyAdditional_:int;
		private var hasExtBogeyAdditional_:Boolean = false;
		public function get hasExtBogeyAdditional():Boolean {
			return hasExtBogeyAdditional_;
		}
		public function set extBogeyAdditional(value:int):void {
			hasExtBogeyAdditional_ = true;
			extBogeyAdditional_ = value;
		}
		public function get extBogeyAdditional():int {
			return extBogeyAdditional_;
		}
		private var equipEffect_:String;
		public function get hasEquipEffect():Boolean {
			return null != equipEffect_;
		}
		public function set equipEffect(value:String):void {
			equipEffect_ = value;
		}
		public function get equipEffect():String {
			return equipEffect_;
		}
		private var devilEffect_:String;
		public function get hasDevilEffect():Boolean {
			return null != devilEffect_;
		}
		public function set devilEffect(value:String):void {
			devilEffect_ = value;
		}
		public function get devilEffect():String {
			return devilEffect_;
		}
		private var suiteEffect_:String;
		public function get hasSuiteEffect():Boolean {
			return null != suiteEffect_;
		}
		public function set suiteEffect(value:String):void {
			suiteEffect_ = value;
		}
		public function get suiteEffect():String {
			return suiteEffect_;
		}
		[ArrayElementType("proto.shop.shop206.Suite")]
		public var SuiteItems:Array = [];
		private var buyingRateCoin_:int;
		private var hasBuyingRateCoin_:Boolean = false;
		public function get hasBuyingRateCoin():Boolean {
			return hasBuyingRateCoin_;
		}
		public function set buyingRateCoin(value:int):void {
			hasBuyingRateCoin_ = true;
			buyingRateCoin_ = value;
		}
		public function get buyingRateCoin():int {
			return buyingRateCoin_;
		}
		private var baseDurability_:int;
		private var hasBaseDurability_:Boolean = false;
		public function get hasBaseDurability():Boolean {
			return hasBaseDurability_;
		}
		public function set baseDurability(value:int):void {
			hasBaseDurability_ = true;
			baseDurability_ = value;
		}
		public function get baseDurability():int {
			return baseDurability_;
		}
		private var nowDurability_:int;
		private var hasNowDurability_:Boolean = false;
		public function get hasNowDurability():Boolean {
			return hasNowDurability_;
		}
		public function set nowDurability(value:int):void {
			hasNowDurability_ = true;
			nowDurability_ = value;
		}
		public function get nowDurability():int {
			return nowDurability_;
		}
		private var baseDefense_:int;
		private var hasBaseDefense_:Boolean = false;
		public function get hasBaseDefense():Boolean {
			return hasBaseDefense_;
		}
		public function set baseDefense(value:int):void {
			hasBaseDefense_ = true;
			baseDefense_ = value;
		}
		public function get baseDefense():int {
			return baseDefense_;
		}
		private var extDefense_:int;
		private var hasExtDefense_:Boolean = false;
		public function get hasExtDefense():Boolean {
			return hasExtDefense_;
		}
		public function set extDefense(value:int):void {
			hasExtDefense_ = true;
			extDefense_ = value;
		}
		public function get extDefense():int {
			return extDefense_;
		}
		private var stack_:int;
		private var hasStack_:Boolean = false;
		public function get hasStack():Boolean {
			return hasStack_;
		}
		public function set stack(value:int):void {
			hasStack_ = true;
			stack_ = value;
		}
		public function get stack():int {
			return stack_;
		}
		private var starLevel_:int;
		private var hasStarLevel_:Boolean = false;
		public function get hasStarLevel():Boolean {
			return hasStarLevel_;
		}
		public function set starLevel(value:int):void {
			hasStarLevel_ = true;
			starLevel_ = value;
		}
		public function get starLevel():int {
			return starLevel_;
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
		private var templateId_:int;
		private var hasTemplateId_:Boolean = false;
		public function get hasTemplateId():Boolean {
			return hasTemplateId_;
		}
		public function set templateId(value:int):void {
			hasTemplateId_ = true;
			templateId_ = value;
		}
		public function get templateId():int {
			return templateId_;
		}
		private var maxStack_:int;
		private var hasMaxStack_:Boolean = false;
		public function get hasMaxStack():Boolean {
			return hasMaxStack_;
		}
		public function set maxStack(value:int):void {
			hasMaxStack_ = true;
			maxStack_ = value;
		}
		public function get maxStack():int {
			return maxStack_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasPrefixNmae) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, prefixNmae);
			}
			if (hasSuffixName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, suffixName);
			}
			if (hasBindType) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, bindType);
			}
			if (hasIsBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, isBound);
			}
			if (hasDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, description);
			}
			if (hasProfessionRequire) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, professionRequire);
			}
			if (hasCanInjection) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, canInjection);
			}
			if (hasBodyType) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, bodyType);
			}
			if (hasWeaponType) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, weaponType);
			}
			if (hasNowQuality) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, nowQuality);
			}
			if (hasBaseAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, baseAttack);
			}
			if (hasExtAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, extAttack);
			}
			if (hasAttackType) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, attackType);
			}
			if (hasBaseSpeed) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, baseSpeed);
			}
			if (hasLevelRequire) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, levelRequire);
			}
			if (hasBaseStr) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, baseStr);
			}
			if (hasExtStr) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, extStr);
			}
			if (hasBaseVit) {
				WriteUtils.writeTag(output, WireType.VARINT, 21);
				WriteUtils.write_TYPE_INT32(output, baseVit);
			}
			if (hasExtVit) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, extVit);
			}
			if (hasBaseDex) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, baseDex);
			}
			if (hasExtDex) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_INT32(output, extDex);
			}
			if (hasBaseWis) {
				WriteUtils.writeTag(output, WireType.VARINT, 25);
				WriteUtils.write_TYPE_INT32(output, baseWis);
			}
			if (hasExtWis) {
				WriteUtils.writeTag(output, WireType.VARINT, 26);
				WriteUtils.write_TYPE_INT32(output, extWis);
			}
			if (hasBaseSpi) {
				WriteUtils.writeTag(output, WireType.VARINT, 27);
				WriteUtils.write_TYPE_INT32(output, baseSpi);
			}
			if (hasExtSpi) {
				WriteUtils.writeTag(output, WireType.VARINT, 28);
				WriteUtils.write_TYPE_INT32(output, extSpi);
			}
			if (hasBasePhysicalAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 29);
				WriteUtils.write_TYPE_INT32(output, basePhysicalAttack);
			}
			if (hasExtPhysicalAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 30);
				WriteUtils.write_TYPE_INT32(output, extPhysicalAttack);
			}
			if (hasBaseMagicAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 31);
				WriteUtils.write_TYPE_INT32(output, baseMagicAttack);
			}
			if (hasExtMagicAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 32);
				WriteUtils.write_TYPE_INT32(output, extMagicAttack);
			}
			if (hasBasePhysicalDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 33);
				WriteUtils.write_TYPE_INT32(output, basePhysicalDefense);
			}
			if (hasExtPhysicalDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 34);
				WriteUtils.write_TYPE_INT32(output, extPhysicalDefense);
			}
			if (hasBaseMagicDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 35);
				WriteUtils.write_TYPE_INT32(output, baseMagicDefense);
			}
			if (hasExtMagicDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 36);
				WriteUtils.write_TYPE_INT32(output, extMagicDefense);
			}
			if (hasBaseHpAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 37);
				WriteUtils.write_TYPE_INT32(output, baseHpAdditional);
			}
			if (hasExtHpAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 38);
				WriteUtils.write_TYPE_INT32(output, extHpAdditional);
			}
			if (hasBaseMpAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 39);
				WriteUtils.write_TYPE_INT32(output, baseMpAdditional);
			}
			if (hasExtMpAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 40);
				WriteUtils.write_TYPE_INT32(output, extMpAdditional);
			}
			if (hasBaseHitAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 41);
				WriteUtils.write_TYPE_INT32(output, baseHitAdditional);
			}
			if (hasExtHitAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 42);
				WriteUtils.write_TYPE_INT32(output, extHitAdditional);
			}
			if (hasBaseCritAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 43);
				WriteUtils.write_TYPE_INT32(output, baseCritAdditional);
			}
			if (hasExtCritAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 44);
				WriteUtils.write_TYPE_INT32(output, extCritAdditional);
			}
			if (hasBaseDodgeAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 45);
				WriteUtils.write_TYPE_INT32(output, baseDodgeAdditional);
			}
			if (hasExtDodgeAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 46);
				WriteUtils.write_TYPE_INT32(output, extDodgeAdditional);
			}
			if (hasBaseSquelchAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 47);
				WriteUtils.write_TYPE_INT32(output, baseSquelchAdditional);
			}
			if (hasExtSquelchAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 48);
				WriteUtils.write_TYPE_INT32(output, extSquelchAdditional);
			}
			if (hasBaseSpeedAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 49);
				WriteUtils.write_TYPE_INT32(output, baseSpeedAdditional);
			}
			if (hasExtSpeedAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 50);
				WriteUtils.write_TYPE_INT32(output, extSpeedAdditional);
			}
			if (hasBaseBogeyAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 51);
				WriteUtils.write_TYPE_INT32(output, baseBogeyAdditional);
			}
			if (hasExtBogeyAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 52);
				WriteUtils.write_TYPE_INT32(output, extBogeyAdditional);
			}
			if (hasEquipEffect) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 53);
				WriteUtils.write_TYPE_STRING(output, equipEffect);
			}
			if (hasDevilEffect) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 54);
				WriteUtils.write_TYPE_STRING(output, devilEffect);
			}
			if (hasSuiteEffect) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 55);
				WriteUtils.write_TYPE_STRING(output, suiteEffect);
			}
			for (var SuiteItemsIndex:uint = 0; SuiteItemsIndex < SuiteItems.length; ++SuiteItemsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 56);
				WriteUtils.write_TYPE_MESSAGE(output, SuiteItems[SuiteItemsIndex]);
			}
			if (hasBuyingRateCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 57);
				WriteUtils.write_TYPE_INT32(output, buyingRateCoin);
			}
			if (hasBaseDurability) {
				WriteUtils.writeTag(output, WireType.VARINT, 58);
				WriteUtils.write_TYPE_INT32(output, baseDurability);
			}
			if (hasNowDurability) {
				WriteUtils.writeTag(output, WireType.VARINT, 59);
				WriteUtils.write_TYPE_INT32(output, nowDurability);
			}
			if (hasBaseDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 60);
				WriteUtils.write_TYPE_INT32(output, baseDefense);
			}
			if (hasExtDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 61);
				WriteUtils.write_TYPE_INT32(output, extDefense);
			}
			if (hasStack) {
				WriteUtils.writeTag(output, WireType.VARINT, 62);
				WriteUtils.write_TYPE_INT32(output, stack);
			}
			if (hasStarLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 63);
				WriteUtils.write_TYPE_INT32(output, starLevel);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 64);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasTemplateId) {
				WriteUtils.writeTag(output, WireType.VARINT, 65);
				WriteUtils.write_TYPE_INT32(output, templateId);
			}
			if (hasMaxStack) {
				WriteUtils.writeTag(output, WireType.VARINT, 66);
				WriteUtils.write_TYPE_INT32(output, maxStack);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var typeCount:uint = 0;
			var nameCount:uint = 0;
			var prefixNmaeCount:uint = 0;
			var suffixNameCount:uint = 0;
			var bindTypeCount:uint = 0;
			var isBoundCount:uint = 0;
			var descriptionCount:uint = 0;
			var professionRequireCount:uint = 0;
			var canInjectionCount:uint = 0;
			var bodyTypeCount:uint = 0;
			var weaponTypeCount:uint = 0;
			var nowQualityCount:uint = 0;
			var baseAttackCount:uint = 0;
			var extAttackCount:uint = 0;
			var attackTypeCount:uint = 0;
			var baseSpeedCount:uint = 0;
			var levelRequireCount:uint = 0;
			var baseStrCount:uint = 0;
			var extStrCount:uint = 0;
			var baseVitCount:uint = 0;
			var extVitCount:uint = 0;
			var baseDexCount:uint = 0;
			var extDexCount:uint = 0;
			var baseWisCount:uint = 0;
			var extWisCount:uint = 0;
			var baseSpiCount:uint = 0;
			var extSpiCount:uint = 0;
			var basePhysicalAttackCount:uint = 0;
			var extPhysicalAttackCount:uint = 0;
			var baseMagicAttackCount:uint = 0;
			var extMagicAttackCount:uint = 0;
			var basePhysicalDefenseCount:uint = 0;
			var extPhysicalDefenseCount:uint = 0;
			var baseMagicDefenseCount:uint = 0;
			var extMagicDefenseCount:uint = 0;
			var baseHpAdditionalCount:uint = 0;
			var extHpAdditionalCount:uint = 0;
			var baseMpAdditionalCount:uint = 0;
			var extMpAdditionalCount:uint = 0;
			var baseHitAdditionalCount:uint = 0;
			var extHitAdditionalCount:uint = 0;
			var baseCritAdditionalCount:uint = 0;
			var extCritAdditionalCount:uint = 0;
			var baseDodgeAdditionalCount:uint = 0;
			var extDodgeAdditionalCount:uint = 0;
			var baseSquelchAdditionalCount:uint = 0;
			var extSquelchAdditionalCount:uint = 0;
			var baseSpeedAdditionalCount:uint = 0;
			var extSpeedAdditionalCount:uint = 0;
			var baseBogeyAdditionalCount:uint = 0;
			var extBogeyAdditionalCount:uint = 0;
			var equipEffectCount:uint = 0;
			var devilEffectCount:uint = 0;
			var suiteEffectCount:uint = 0;
			var buyingRateCoinCount:uint = 0;
			var baseDurabilityCount:uint = 0;
			var nowDurabilityCount:uint = 0;
			var baseDefenseCount:uint = 0;
			var extDefenseCount:uint = 0;
			var stackCount:uint = 0;
			var starLevelCount:uint = 0;
			var iconCount:uint = 0;
			var templateIdCount:uint = 0;
			var maxStackCount:uint = 0;
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
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (prefixNmaeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++prefixNmaeCount;
					prefixNmae = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (suffixNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++suffixNameCount;
					suffixName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (bindTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bindTypeCount;
					bindType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (isBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isBoundCount;
					isBound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (descriptionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++descriptionCount;
					description = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (professionRequireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionRequireCount;
					professionRequire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (canInjectionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++canInjectionCount;
					canInjection = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (bodyTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bodyTypeCount;
					bodyType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (weaponTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++weaponTypeCount;
					weaponType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (nowQualityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nowQualityCount;
					nowQuality = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (baseAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseAttackCount;
					baseAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (extAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extAttackCount;
					extAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (attackTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++attackTypeCount;
					attackType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (baseSpeedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseSpeedCount;
					baseSpeed = ReadUtils.read_TYPE_INT32(input);
					break;
				case 18:
					if (levelRequireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelRequireCount;
					levelRequire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 19:
					if (baseStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseStrCount;
					baseStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (extStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extStrCount;
					extStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 21:
					if (baseVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseVitCount;
					baseVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 22:
					if (extVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extVitCount;
					extVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (baseDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseDexCount;
					baseDex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (extDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extDexCount;
					extDex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 25:
					if (baseWisCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseWisCount;
					baseWis = ReadUtils.read_TYPE_INT32(input);
					break;
				case 26:
					if (extWisCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extWisCount;
					extWis = ReadUtils.read_TYPE_INT32(input);
					break;
				case 27:
					if (baseSpiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseSpiCount;
					baseSpi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 28:
					if (extSpiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extSpiCount;
					extSpi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 29:
					if (basePhysicalAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++basePhysicalAttackCount;
					basePhysicalAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 30:
					if (extPhysicalAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extPhysicalAttackCount;
					extPhysicalAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 31:
					if (baseMagicAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseMagicAttackCount;
					baseMagicAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 32:
					if (extMagicAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extMagicAttackCount;
					extMagicAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 33:
					if (basePhysicalDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++basePhysicalDefenseCount;
					basePhysicalDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 34:
					if (extPhysicalDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extPhysicalDefenseCount;
					extPhysicalDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 35:
					if (baseMagicDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseMagicDefenseCount;
					baseMagicDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 36:
					if (extMagicDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extMagicDefenseCount;
					extMagicDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 37:
					if (baseHpAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseHpAdditionalCount;
					baseHpAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 38:
					if (extHpAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extHpAdditionalCount;
					extHpAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 39:
					if (baseMpAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseMpAdditionalCount;
					baseMpAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 40:
					if (extMpAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extMpAdditionalCount;
					extMpAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 41:
					if (baseHitAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseHitAdditionalCount;
					baseHitAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 42:
					if (extHitAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extHitAdditionalCount;
					extHitAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 43:
					if (baseCritAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseCritAdditionalCount;
					baseCritAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 44:
					if (extCritAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extCritAdditionalCount;
					extCritAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 45:
					if (baseDodgeAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseDodgeAdditionalCount;
					baseDodgeAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 46:
					if (extDodgeAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extDodgeAdditionalCount;
					extDodgeAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 47:
					if (baseSquelchAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseSquelchAdditionalCount;
					baseSquelchAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 48:
					if (extSquelchAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extSquelchAdditionalCount;
					extSquelchAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 49:
					if (baseSpeedAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseSpeedAdditionalCount;
					baseSpeedAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 50:
					if (extSpeedAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extSpeedAdditionalCount;
					extSpeedAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 51:
					if (baseBogeyAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseBogeyAdditionalCount;
					baseBogeyAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 52:
					if (extBogeyAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extBogeyAdditionalCount;
					extBogeyAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 53:
					if (equipEffectCount != 0) {
						throw new IOError('Bad data format.');
					}
					++equipEffectCount;
					equipEffect = ReadUtils.read_TYPE_STRING(input);
					break;
				case 54:
					if (devilEffectCount != 0) {
						throw new IOError('Bad data format.');
					}
					++devilEffectCount;
					devilEffect = ReadUtils.read_TYPE_STRING(input);
					break;
				case 55:
					if (suiteEffectCount != 0) {
						throw new IOError('Bad data format.');
					}
					++suiteEffectCount;
					suiteEffect = ReadUtils.read_TYPE_STRING(input);
					break;
				case 56:
					SuiteItems.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.shop.shop206.Suite));
					break;
				case 57:
					if (buyingRateCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buyingRateCoinCount;
					buyingRateCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 58:
					if (baseDurabilityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseDurabilityCount;
					baseDurability = ReadUtils.read_TYPE_INT32(input);
					break;
				case 59:
					if (nowDurabilityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nowDurabilityCount;
					nowDurability = ReadUtils.read_TYPE_INT32(input);
					break;
				case 60:
					if (baseDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseDefenseCount;
					baseDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 61:
					if (extDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extDefenseCount;
					extDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 62:
					if (stackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stackCount;
					stack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 63:
					if (starLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++starLevelCount;
					starLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 64:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 65:
					if (templateIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++templateIdCount;
					templateId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 66:
					if (maxStackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxStackCount;
					maxStack = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
