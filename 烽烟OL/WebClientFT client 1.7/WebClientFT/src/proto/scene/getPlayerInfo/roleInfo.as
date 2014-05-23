package proto.scene.getPlayerInfo {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.getPlayerInfo.Damage;
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
		private var manualStr_:int;
		private var hasManualStr_:Boolean = false;
		public function get hasManualStr():Boolean {
			return hasManualStr_;
		}
		public function set manualStr(value:int):void {
			hasManualStr_ = true;
			manualStr_ = value;
		}
		public function get manualStr():int {
			return manualStr_;
		}
		private var manualVit_:int;
		private var hasManualVit_:Boolean = false;
		public function get hasManualVit():Boolean {
			return hasManualVit_;
		}
		public function set manualVit(value:int):void {
			hasManualVit_ = true;
			manualVit_ = value;
		}
		public function get manualVit():int {
			return manualVit_;
		}
		private var manualDex_:int;
		private var hasManualDex_:Boolean = false;
		public function get hasManualDex():Boolean {
			return hasManualDex_;
		}
		public function set manualDex(value:int):void {
			hasManualDex_ = true;
			manualDex_ = value;
		}
		public function get manualDex():int {
			return manualDex_;
		}
		private var extraStr_:int;
		private var hasExtraStr_:Boolean = false;
		public function get hasExtraStr():Boolean {
			return hasExtraStr_;
		}
		public function set extraStr(value:int):void {
			hasExtraStr_ = true;
			extraStr_ = value;
		}
		public function get extraStr():int {
			return extraStr_;
		}
		private var extraDex_:int;
		private var hasExtraDex_:Boolean = false;
		public function get hasExtraDex():Boolean {
			return hasExtraDex_;
		}
		public function set extraDex(value:int):void {
			hasExtraDex_ = true;
			extraDex_ = value;
		}
		public function get extraDex():int {
			return extraDex_;
		}
		private var extraVit_:int;
		private var hasExtraVit_:Boolean = false;
		public function get hasExtraVit():Boolean {
			return hasExtraVit_;
		}
		public function set extraVit(value:int):void {
			hasExtraVit_ = true;
			extraVit_ = value;
		}
		public function get extraVit():int {
			return extraVit_;
		}
		private var gender_:int;
		private var hasGender_:Boolean = false;
		public function get hasGender():Boolean {
			return hasGender_;
		}
		public function set gender(value:int):void {
			hasGender_ = true;
			gender_ = value;
		}
		public function get gender():int {
			return gender_;
		}
		private var sparePoint_:int;
		private var hasSparePoint_:Boolean = false;
		public function get hasSparePoint():Boolean {
			return hasSparePoint_;
		}
		public function set sparePoint(value:int):void {
			hasSparePoint_ = true;
			sparePoint_ = value;
		}
		public function get sparePoint():int {
			return sparePoint_;
		}
		private var nickName_:String;
		public function get hasNickName():Boolean {
			return null != nickName_;
		}
		public function set nickName(value:String):void {
			nickName_ = value;
		}
		public function get nickName():String {
			return nickName_;
		}
		private var portrait_:String;
		public function get hasPortrait():Boolean {
			return null != portrait_;
		}
		public function set portrait(value:String):void {
			portrait_ = value;
		}
		public function get portrait():String {
			return portrait_;
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
		private var status_:String;
		public function get hasStatus():Boolean {
			return null != status_;
		}
		public function set status(value:String):void {
			status_ = value;
		}
		public function get status():String {
			return status_;
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
		private var professionDescription_:String;
		public function get hasProfessionDescription():Boolean {
			return null != professionDescription_;
		}
		public function set professionDescription(value:String):void {
			professionDescription_ = value;
		}
		public function get professionDescription():String {
			return professionDescription_;
		}
		private var currentProfessionStageIndex_:int;
		private var hasCurrentProfessionStageIndex_:Boolean = false;
		public function get hasCurrentProfessionStageIndex():Boolean {
			return hasCurrentProfessionStageIndex_;
		}
		public function set currentProfessionStageIndex(value:int):void {
			hasCurrentProfessionStageIndex_ = true;
			currentProfessionStageIndex_ = value;
		}
		public function get currentProfessionStageIndex():int {
			return currentProfessionStageIndex_;
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
		private var hp_:int;
		private var hasHp_:Boolean = false;
		public function get hasHp():Boolean {
			return hasHp_;
		}
		public function set hp(value:int):void {
			hasHp_ = true;
			hp_ = value;
		}
		public function get hp():int {
			return hp_;
		}
		private var maxMp_:int;
		private var hasMaxMp_:Boolean = false;
		public function get hasMaxMp():Boolean {
			return hasMaxMp_;
		}
		public function set maxMp(value:int):void {
			hasMaxMp_ = true;
			maxMp_ = value;
		}
		public function get maxMp():int {
			return maxMp_;
		}
		private var mp_:int;
		private var hasMp_:Boolean = false;
		public function get hasMp():Boolean {
			return hasMp_;
		}
		public function set mp(value:int):void {
			hasMp_ = true;
			mp_ = value;
		}
		public function get mp():int {
			return mp_;
		}
		private var exp_:int;
		private var hasExp_:Boolean = false;
		public function get hasExp():Boolean {
			return hasExp_;
		}
		public function set exp(value:int):void {
			hasExp_ = true;
			exp_ = value;
		}
		public function get exp():int {
			return exp_;
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
		private var location_:int;
		private var hasLocation_:Boolean = false;
		public function get hasLocation():Boolean {
			return hasLocation_;
		}
		public function set location(value:int):void {
			hasLocation_ = true;
			location_ = value;
		}
		public function get location():int {
			return location_;
		}
		private var town_:int;
		private var hasTown_:Boolean = false;
		public function get hasTown():Boolean {
			return hasTown_;
		}
		public function set town(value:int):void {
			hasTown_ = true;
			town_ = value;
		}
		public function get town():int {
			return town_;
		}
		private var coupon_:int;
		private var hasCoupon_:Boolean = false;
		public function get hasCoupon():Boolean {
			return hasCoupon_;
		}
		public function set coupon(value:int):void {
			hasCoupon_ = true;
			coupon_ = value;
		}
		public function get coupon():int {
			return coupon_;
		}
		private var coin_:int;
		private var hasCoin_:Boolean = false;
		public function get hasCoin():Boolean {
			return hasCoin_;
		}
		public function set coin(value:int):void {
			hasCoin_ = true;
			coin_ = value;
		}
		public function get coin():int {
			return coin_;
		}
		private var gold_:int;
		private var hasGold_:Boolean = false;
		public function get hasGold():Boolean {
			return hasGold_;
		}
		public function set gold(value:int):void {
			hasGold_ = true;
			gold_ = value;
		}
		public function get gold():int {
			return gold_;
		}
		private var energy_:int;
		private var hasEnergy_:Boolean = false;
		public function get hasEnergy():Boolean {
			return hasEnergy_;
		}
		public function set energy(value:int):void {
			hasEnergy_ = true;
			energy_ = value;
		}
		public function get energy():int {
			return energy_;
		}
		private var pkStatus_:String;
		public function get hasPkStatus():Boolean {
			return null != pkStatus_;
		}
		public function set pkStatus(value:String):void {
			pkStatus_ = value;
		}
		public function get pkStatus():String {
			return pkStatus_;
		}
		private var station_:String;
		public function get hasStation():Boolean {
			return null != station_;
		}
		public function set station(value:String):void {
			station_ = value;
		}
		public function get station():String {
			return station_;
		}
		private var camp_:int;
		private var hasCamp_:Boolean = false;
		public function get hasCamp():Boolean {
			return hasCamp_;
		}
		public function set camp(value:int):void {
			hasCamp_ = true;
			camp_ = value;
		}
		public function get camp():int {
			return camp_;
		}
		private var hitRate_:Number;
		private var hasHitRate_:Boolean = false;
		public function get hasHitRate():Boolean {
			return hasHitRate_;
		}
		public function set hitRate(value:Number):void {
			hasHitRate_ = true;
			hitRate_ = value;
		}
		public function get hitRate():Number {
			return hitRate_;
		}
		private var criRate_:Number;
		private var hasCriRate_:Boolean = false;
		public function get hasCriRate():Boolean {
			return hasCriRate_;
		}
		public function set criRate(value:Number):void {
			hasCriRate_ = true;
			criRate_ = value;
		}
		public function get criRate():Number {
			return criRate_;
		}
		private var dodgeRate_:Number;
		private var hasDodgeRate_:Boolean = false;
		public function get hasDodgeRate():Boolean {
			return hasDodgeRate_;
		}
		public function set dodgeRate(value:Number):void {
			hasDodgeRate_ = true;
			dodgeRate_ = value;
		}
		public function get dodgeRate():Number {
			return dodgeRate_;
		}
		private var bogeyRate_:Number;
		private var hasBogeyRate_:Boolean = false;
		public function get hasBogeyRate():Boolean {
			return hasBogeyRate_;
		}
		public function set bogeyRate(value:Number):void {
			hasBogeyRate_ = true;
			bogeyRate_ = value;
		}
		public function get bogeyRate():Number {
			return bogeyRate_;
		}
		private var currentSpeed_:Number;
		private var hasCurrentSpeed_:Boolean = false;
		public function get hasCurrentSpeed():Boolean {
			return hasCurrentSpeed_;
		}
		public function set currentSpeed(value:Number):void {
			hasCurrentSpeed_ = true;
			currentSpeed_ = value;
		}
		public function get currentSpeed():Number {
			return currentSpeed_;
		}
		private var currentSpeedDescription_:String;
		public function get hasCurrentSpeedDescription():Boolean {
			return null != currentSpeedDescription_;
		}
		public function set currentSpeedDescription(value:String):void {
			currentSpeedDescription_ = value;
		}
		public function get currentSpeedDescription():String {
			return currentSpeedDescription_;
		}
		private var currentDefense_:Number;
		private var hasCurrentDefense_:Boolean = false;
		public function get hasCurrentDefense():Boolean {
			return hasCurrentDefense_;
		}
		public function set currentDefense(value:Number):void {
			hasCurrentDefense_ = true;
			currentDefense_ = value;
		}
		public function get currentDefense():Number {
			return currentDefense_;
		}
		private var currentDamage_:proto.scene.getPlayerInfo.Damage;
		public function get hasCurrentDamage():Boolean {
			return null != currentDamage_;
		}
		public function set currentDamage(value:proto.scene.getPlayerInfo.Damage):void {
			currentDamage_ = value;
		}
		public function get currentDamage():proto.scene.getPlayerInfo.Damage {
			return currentDamage_;
		}
		private var isTeamMember_:Boolean;
		private var hasIsTeamMember_:Boolean = false;
		public function get hasIsTeamMember():Boolean {
			return hasIsTeamMember_;
		}
		public function set isTeamMember(value:Boolean):void {
			hasIsTeamMember_ = true;
			isTeamMember_ = value;
		}
		public function get isTeamMember():Boolean {
			return isTeamMember_;
		}
		private var isLeader_:Boolean;
		private var hasIsLeader_:Boolean = false;
		public function get hasIsLeader():Boolean {
			return hasIsLeader_;
		}
		public function set isLeader(value:Boolean):void {
			hasIsLeader_ = true;
			isLeader_ = value;
		}
		public function get isLeader():Boolean {
			return isLeader_;
		}
		private var warehouses_:int;
		private var hasWarehouses_:Boolean = false;
		public function get hasWarehouses():Boolean {
			return hasWarehouses_;
		}
		public function set warehouses(value:int):void {
			hasWarehouses_ = true;
			warehouses_ = value;
		}
		public function get warehouses():int {
			return warehouses_;
		}
		private var deposit_:int;
		private var hasDeposit_:Boolean = false;
		public function get hasDeposit():Boolean {
			return hasDeposit_;
		}
		public function set deposit(value:int):void {
			hasDeposit_ = true;
			deposit_ = value;
		}
		public function get deposit():int {
			return deposit_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasRoletype) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, roletype);
			}
			if (hasBaseStr) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, baseStr);
			}
			if (hasBaseVit) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, baseVit);
			}
			if (hasBaseDex) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, baseDex);
			}
			if (hasManualStr) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, manualStr);
			}
			if (hasManualVit) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, manualVit);
			}
			if (hasManualDex) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, manualDex);
			}
			if (hasExtraStr) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, extraStr);
			}
			if (hasExtraDex) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, extraDex);
			}
			if (hasExtraVit) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, extraVit);
			}
			if (hasGender) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, gender);
			}
			if (hasSparePoint) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, sparePoint);
			}
			if (hasNickName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 15);
				WriteUtils.write_TYPE_STRING(output, nickName);
			}
			if (hasPortrait) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 16);
				WriteUtils.write_TYPE_STRING(output, portrait);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 18);
				WriteUtils.write_TYPE_STRING(output, description);
			}
			if (hasStatus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 19);
				WriteUtils.write_TYPE_STRING(output, status);
			}
			if (hasProfession) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 20);
				WriteUtils.write_TYPE_STRING(output, profession);
			}
			if (hasProfessionDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 21);
				WriteUtils.write_TYPE_STRING(output, professionDescription);
			}
			if (hasCurrentProfessionStageIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, currentProfessionStageIndex);
			}
			if (hasMaxHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, maxHp);
			}
			if (hasHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_INT32(output, hp);
			}
			if (hasMaxMp) {
				WriteUtils.writeTag(output, WireType.VARINT, 25);
				WriteUtils.write_TYPE_INT32(output, maxMp);
			}
			if (hasMp) {
				WriteUtils.writeTag(output, WireType.VARINT, 26);
				WriteUtils.write_TYPE_INT32(output, mp);
			}
			if (hasExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 27);
				WriteUtils.write_TYPE_INT32(output, exp);
			}
			if (hasMaxExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 28);
				WriteUtils.write_TYPE_INT32(output, maxExp);
			}
			if (hasLocation) {
				WriteUtils.writeTag(output, WireType.VARINT, 29);
				WriteUtils.write_TYPE_INT32(output, location);
			}
			if (hasTown) {
				WriteUtils.writeTag(output, WireType.VARINT, 30);
				WriteUtils.write_TYPE_INT32(output, town);
			}
			if (hasCoupon) {
				WriteUtils.writeTag(output, WireType.VARINT, 31);
				WriteUtils.write_TYPE_INT32(output, coupon);
			}
			if (hasCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 32);
				WriteUtils.write_TYPE_INT32(output, coin);
			}
			if (hasGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 33);
				WriteUtils.write_TYPE_INT32(output, gold);
			}
			if (hasEnergy) {
				WriteUtils.writeTag(output, WireType.VARINT, 34);
				WriteUtils.write_TYPE_INT32(output, energy);
			}
			if (hasPkStatus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 35);
				WriteUtils.write_TYPE_STRING(output, pkStatus);
			}
			if (hasStation) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 36);
				WriteUtils.write_TYPE_STRING(output, station);
			}
			if (hasCamp) {
				WriteUtils.writeTag(output, WireType.VARINT, 37);
				WriteUtils.write_TYPE_INT32(output, camp);
			}
			if (hasHitRate) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 38);
				WriteUtils.write_TYPE_FLOAT(output, hitRate);
			}
			if (hasCriRate) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 39);
				WriteUtils.write_TYPE_FLOAT(output, criRate);
			}
			if (hasDodgeRate) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 40);
				WriteUtils.write_TYPE_FLOAT(output, dodgeRate);
			}
			if (hasBogeyRate) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 41);
				WriteUtils.write_TYPE_FLOAT(output, bogeyRate);
			}
			if (hasCurrentSpeed) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 42);
				WriteUtils.write_TYPE_FLOAT(output, currentSpeed);
			}
			if (hasCurrentSpeedDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 43);
				WriteUtils.write_TYPE_STRING(output, currentSpeedDescription);
			}
			if (hasCurrentDefense) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 44);
				WriteUtils.write_TYPE_FLOAT(output, currentDefense);
			}
			if (hasCurrentDamage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 45);
				WriteUtils.write_TYPE_MESSAGE(output, currentDamage);
			}
			if (hasIsTeamMember) {
				WriteUtils.writeTag(output, WireType.VARINT, 46);
				WriteUtils.write_TYPE_BOOL(output, isTeamMember);
			}
			if (hasIsLeader) {
				WriteUtils.writeTag(output, WireType.VARINT, 47);
				WriteUtils.write_TYPE_BOOL(output, isLeader);
			}
			if (hasWarehouses) {
				WriteUtils.writeTag(output, WireType.VARINT, 48);
				WriteUtils.write_TYPE_INT32(output, warehouses);
			}
			if (hasDeposit) {
				WriteUtils.writeTag(output, WireType.VARINT, 49);
				WriteUtils.write_TYPE_INT32(output, deposit);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nameCount:uint = 0;
			var roletypeCount:uint = 0;
			var baseStrCount:uint = 0;
			var baseVitCount:uint = 0;
			var baseDexCount:uint = 0;
			var manualStrCount:uint = 0;
			var manualVitCount:uint = 0;
			var manualDexCount:uint = 0;
			var extraStrCount:uint = 0;
			var extraDexCount:uint = 0;
			var extraVitCount:uint = 0;
			var genderCount:uint = 0;
			var sparePointCount:uint = 0;
			var nickNameCount:uint = 0;
			var portraitCount:uint = 0;
			var levelCount:uint = 0;
			var descriptionCount:uint = 0;
			var statusCount:uint = 0;
			var professionCount:uint = 0;
			var professionDescriptionCount:uint = 0;
			var currentProfessionStageIndexCount:uint = 0;
			var maxHpCount:uint = 0;
			var hpCount:uint = 0;
			var maxMpCount:uint = 0;
			var mpCount:uint = 0;
			var expCount:uint = 0;
			var maxExpCount:uint = 0;
			var locationCount:uint = 0;
			var townCount:uint = 0;
			var couponCount:uint = 0;
			var coinCount:uint = 0;
			var goldCount:uint = 0;
			var energyCount:uint = 0;
			var pkStatusCount:uint = 0;
			var stationCount:uint = 0;
			var campCount:uint = 0;
			var hitRateCount:uint = 0;
			var criRateCount:uint = 0;
			var dodgeRateCount:uint = 0;
			var bogeyRateCount:uint = 0;
			var currentSpeedCount:uint = 0;
			var currentSpeedDescriptionCount:uint = 0;
			var currentDefenseCount:uint = 0;
			var currentDamageCount:uint = 0;
			var isTeamMemberCount:uint = 0;
			var isLeaderCount:uint = 0;
			var warehousesCount:uint = 0;
			var depositCount:uint = 0;
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
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (roletypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roletypeCount;
					roletype = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (baseStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseStrCount;
					baseStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (baseVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseVitCount;
					baseVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (baseDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++baseDexCount;
					baseDex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (manualStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualStrCount;
					manualStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (manualVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualVitCount;
					manualVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (manualDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualDexCount;
					manualDex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (extraStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extraStrCount;
					extraStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (extraDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extraDexCount;
					extraDex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (extraVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extraVitCount;
					extraVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (genderCount != 0) {
						throw new IOError('Bad data format.');
					}
					++genderCount;
					gender = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (sparePointCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sparePointCount;
					sparePoint = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (nickNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nickNameCount;
					nickName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 16:
					if (portraitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++portraitCount;
					portrait = ReadUtils.read_TYPE_STRING(input);
					break;
				case 17:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 18:
					if (descriptionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++descriptionCount;
					description = ReadUtils.read_TYPE_STRING(input);
					break;
				case 19:
					if (statusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++statusCount;
					status = ReadUtils.read_TYPE_STRING(input);
					break;
				case 20:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_STRING(input);
					break;
				case 21:
					if (professionDescriptionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionDescriptionCount;
					professionDescription = ReadUtils.read_TYPE_STRING(input);
					break;
				case 22:
					if (currentProfessionStageIndexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentProfessionStageIndexCount;
					currentProfessionStageIndex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (maxHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxHpCount;
					maxHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (hpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hpCount;
					hp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 25:
					if (maxMpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxMpCount;
					maxMp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 26:
					if (mpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++mpCount;
					mp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 27:
					if (expCount != 0) {
						throw new IOError('Bad data format.');
					}
					++expCount;
					exp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 28:
					if (maxExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxExpCount;
					maxExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 29:
					if (locationCount != 0) {
						throw new IOError('Bad data format.');
					}
					++locationCount;
					location = ReadUtils.read_TYPE_INT32(input);
					break;
				case 30:
					if (townCount != 0) {
						throw new IOError('Bad data format.');
					}
					++townCount;
					town = ReadUtils.read_TYPE_INT32(input);
					break;
				case 31:
					if (couponCount != 0) {
						throw new IOError('Bad data format.');
					}
					++couponCount;
					coupon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 32:
					if (coinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinCount;
					coin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 33:
					if (goldCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldCount;
					gold = ReadUtils.read_TYPE_INT32(input);
					break;
				case 34:
					if (energyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++energyCount;
					energy = ReadUtils.read_TYPE_INT32(input);
					break;
				case 35:
					if (pkStatusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pkStatusCount;
					pkStatus = ReadUtils.read_TYPE_STRING(input);
					break;
				case 36:
					if (stationCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stationCount;
					station = ReadUtils.read_TYPE_STRING(input);
					break;
				case 37:
					if (campCount != 0) {
						throw new IOError('Bad data format.');
					}
					++campCount;
					camp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 38:
					if (hitRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hitRateCount;
					hitRate = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 39:
					if (criRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++criRateCount;
					criRate = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 40:
					if (dodgeRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dodgeRateCount;
					dodgeRate = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 41:
					if (bogeyRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bogeyRateCount;
					bogeyRate = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 42:
					if (currentSpeedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentSpeedCount;
					currentSpeed = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 43:
					if (currentSpeedDescriptionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentSpeedDescriptionCount;
					currentSpeedDescription = ReadUtils.read_TYPE_STRING(input);
					break;
				case 44:
					if (currentDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentDefenseCount;
					currentDefense = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 45:
					if (currentDamageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++currentDamageCount;
					currentDamage = new proto.scene.getPlayerInfo.Damage;
					ReadUtils.read_TYPE_MESSAGE(input, currentDamage);
					break;
				case 46:
					if (isTeamMemberCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isTeamMemberCount;
					isTeamMember = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 47:
					if (isLeaderCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isLeaderCount;
					isLeader = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 48:
					if (warehousesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++warehousesCount;
					warehouses = ReadUtils.read_TYPE_INT32(input);
					break;
				case 49:
					if (depositCount != 0) {
						throw new IOError('Bad data format.');
					}
					++depositCount;
					deposit = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
