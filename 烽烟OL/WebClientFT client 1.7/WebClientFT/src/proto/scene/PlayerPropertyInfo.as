package proto.scene {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.Appellation;
	import proto.scene.CorpsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PlayerPropertyInfo extends Message implements IExternalizable {
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
		private var nickname_:String;
		public function get hasNickname():Boolean {
			return null != nickname_;
		}
		public function set nickname(value:String):void {
			nickname_ = value;
		}
		public function get nickname():String {
			return nickname_;
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
		private var rank_:String;
		public function get hasRank():Boolean {
			return null != rank_;
		}
		public function set rank(value:String):void {
			rank_ = value;
		}
		public function get rank():String {
			return rank_;
		}
		private var guildname_:String;
		public function get hasGuildname():Boolean {
			return null != guildname_;
		}
		public function set guildname(value:String):void {
			guildname_ = value;
		}
		public function get guildname():String {
			return guildname_;
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
		private var manualWis_:int;
		private var hasManualWis_:Boolean = false;
		public function get hasManualWis():Boolean {
			return hasManualWis_;
		}
		public function set manualWis(value:int):void {
			hasManualWis_ = true;
			manualWis_ = value;
		}
		public function get manualWis():int {
			return manualWis_;
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
		private var physicalAttack_:Number;
		private var hasPhysicalAttack_:Boolean = false;
		public function get hasPhysicalAttack():Boolean {
			return hasPhysicalAttack_;
		}
		public function set physicalAttack(value:Number):void {
			hasPhysicalAttack_ = true;
			physicalAttack_ = value;
		}
		public function get physicalAttack():Number {
			return physicalAttack_;
		}
		private var magicAttack_:Number;
		private var hasMagicAttack_:Boolean = false;
		public function get hasMagicAttack():Boolean {
			return hasMagicAttack_;
		}
		public function set magicAttack(value:Number):void {
			hasMagicAttack_ = true;
			magicAttack_ = value;
		}
		public function get magicAttack():Number {
			return magicAttack_;
		}
		private var physicalDefense_:Number;
		private var hasPhysicalDefense_:Boolean = false;
		public function get hasPhysicalDefense():Boolean {
			return hasPhysicalDefense_;
		}
		public function set physicalDefense(value:Number):void {
			hasPhysicalDefense_ = true;
			physicalDefense_ = value;
		}
		public function get physicalDefense():Number {
			return physicalDefense_;
		}
		private var magicDefense_:Number;
		private var hasMagicDefense_:Boolean = false;
		public function get hasMagicDefense():Boolean {
			return hasMagicDefense_;
		}
		public function set magicDefense(value:Number):void {
			hasMagicDefense_ = true;
			magicDefense_ = value;
		}
		public function get magicDefense():Number {
			return magicDefense_;
		}
		private var speed_:Number;
		private var hasSpeed_:Boolean = false;
		public function get hasSpeed():Boolean {
			return hasSpeed_;
		}
		public function set speed(value:Number):void {
			hasSpeed_ = true;
			speed_ = value;
		}
		public function get speed():Number {
			return speed_;
		}
		private var critRate_:Number;
		private var hasCritRate_:Boolean = false;
		public function get hasCritRate():Boolean {
			return hasCritRate_;
		}
		public function set critRate(value:Number):void {
			hasCritRate_ = true;
			critRate_ = value;
		}
		public function get critRate():Number {
			return critRate_;
		}
		private var block_:Number;
		private var hasBlock_:Boolean = false;
		public function get hasBlock():Boolean {
			return hasBlock_;
		}
		public function set block(value:Number):void {
			hasBlock_ = true;
			block_ = value;
		}
		public function get block():Number {
			return block_;
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
		private var exULiliang_:int;
		private var hasExULiliang_:Boolean = false;
		public function get hasExULiliang():Boolean {
			return hasExULiliang_;
		}
		public function set exULiliang(value:int):void {
			hasExULiliang_ = true;
			exULiliang_ = value;
		}
		public function get exULiliang():int {
			return exULiliang_;
		}
		private var exUMinjie_:int;
		private var hasExUMinjie_:Boolean = false;
		public function get hasExUMinjie():Boolean {
			return hasExUMinjie_;
		}
		public function set exUMinjie(value:int):void {
			hasExUMinjie_ = true;
			exUMinjie_ = value;
		}
		public function get exUMinjie():int {
			return exUMinjie_;
		}
		private var exUZhili_:int;
		private var hasExUZhili_:Boolean = false;
		public function get hasExUZhili():Boolean {
			return hasExUZhili_;
		}
		public function set exUZhili(value:int):void {
			hasExUZhili_ = true;
			exUZhili_ = value;
		}
		public function get exUZhili():int {
			return exUZhili_;
		}
		private var exUNaili_:int;
		private var hasExUNaili_:Boolean = false;
		public function get hasExUNaili():Boolean {
			return hasExUNaili_;
		}
		public function set exUNaili(value:int):void {
			hasExUNaili_ = true;
			exUNaili_ = value;
		}
		public function get exUNaili():int {
			return exUNaili_;
		}
		private var exUWugong_:int;
		private var hasExUWugong_:Boolean = false;
		public function get hasExUWugong():Boolean {
			return hasExUWugong_;
		}
		public function set exUWugong(value:int):void {
			hasExUWugong_ = true;
			exUWugong_ = value;
		}
		public function get exUWugong():int {
			return exUWugong_;
		}
		private var exUMonggong_:int;
		private var hasExUMonggong_:Boolean = false;
		public function get hasExUMonggong():Boolean {
			return hasExUMonggong_;
		}
		public function set exUMonggong(value:int):void {
			hasExUMonggong_ = true;
			exUMonggong_ = value;
		}
		public function get exUMonggong():int {
			return exUMonggong_;
		}
		private var unionType_:String;
		public function get hasUnionType():Boolean {
			return null != unionType_;
		}
		public function set unionType(value:String):void {
			unionType_ = value;
		}
		public function get unionType():String {
			return unionType_;
		}
		private var appellation_:proto.scene.Appellation;
		public function get hasAppellation():Boolean {
			return null != appellation_;
		}
		public function set appellation(value:proto.scene.Appellation):void {
			appellation_ = value;
		}
		public function get appellation():proto.scene.Appellation {
			return appellation_;
		}
		[ArrayElementType("proto.scene.Appellation")]
		public var appellationList:Array = [];
		private var corpsInfo_:proto.scene.CorpsInfo;
		public function get hasCorpsInfo():Boolean {
			return null != corpsInfo_;
		}
		public function set corpsInfo(value:proto.scene.CorpsInfo):void {
			corpsInfo_ = value;
		}
		public function get corpsInfo():proto.scene.CorpsInfo {
			return corpsInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasNickname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, nickname);
			}
			if (hasRoletype) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, roletype);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasProfession) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, profession);
			}
			if (hasEnergy) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, energy);
			}
			if (hasRank) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, rank);
			}
			if (hasGuildname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, guildname);
			}
			if (hasManualStr) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, manualStr);
			}
			if (hasManualVit) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, manualVit);
			}
			if (hasManualDex) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, manualDex);
			}
			if (hasManualWis) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, manualWis);
			}
			if (hasMaxHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, maxHp);
			}
			if (hasHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, hp);
			}
			if (hasExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, exp);
			}
			if (hasMaxExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, maxExp);
			}
			if (hasPhysicalAttack) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 17);
				WriteUtils.write_TYPE_FLOAT(output, physicalAttack);
			}
			if (hasMagicAttack) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 18);
				WriteUtils.write_TYPE_FLOAT(output, magicAttack);
			}
			if (hasPhysicalDefense) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 19);
				WriteUtils.write_TYPE_FLOAT(output, physicalDefense);
			}
			if (hasMagicDefense) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 20);
				WriteUtils.write_TYPE_FLOAT(output, magicDefense);
			}
			if (hasSpeed) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 21);
				WriteUtils.write_TYPE_FLOAT(output, speed);
			}
			if (hasCritRate) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 22);
				WriteUtils.write_TYPE_FLOAT(output, critRate);
			}
			if (hasBlock) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 23);
				WriteUtils.write_TYPE_FLOAT(output, block);
			}
			if (hasHitRate) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 24);
				WriteUtils.write_TYPE_FLOAT(output, hitRate);
			}
			if (hasDodgeRate) {
				WriteUtils.writeTag(output, WireType.FIXED_32_BIT, 25);
				WriteUtils.write_TYPE_FLOAT(output, dodgeRate);
			}
			if (hasGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 26);
				WriteUtils.write_TYPE_INT32(output, gold);
			}
			if (hasCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 27);
				WriteUtils.write_TYPE_INT32(output, coin);
			}
			if (hasDeposit) {
				WriteUtils.writeTag(output, WireType.VARINT, 28);
				WriteUtils.write_TYPE_INT32(output, deposit);
			}
			if (hasExULiliang) {
				WriteUtils.writeTag(output, WireType.VARINT, 29);
				WriteUtils.write_TYPE_INT32(output, exULiliang);
			}
			if (hasExUMinjie) {
				WriteUtils.writeTag(output, WireType.VARINT, 30);
				WriteUtils.write_TYPE_INT32(output, exUMinjie);
			}
			if (hasExUZhili) {
				WriteUtils.writeTag(output, WireType.VARINT, 31);
				WriteUtils.write_TYPE_INT32(output, exUZhili);
			}
			if (hasExUNaili) {
				WriteUtils.writeTag(output, WireType.VARINT, 32);
				WriteUtils.write_TYPE_INT32(output, exUNaili);
			}
			if (hasExUWugong) {
				WriteUtils.writeTag(output, WireType.VARINT, 33);
				WriteUtils.write_TYPE_INT32(output, exUWugong);
			}
			if (hasExUMonggong) {
				WriteUtils.writeTag(output, WireType.VARINT, 34);
				WriteUtils.write_TYPE_INT32(output, exUMonggong);
			}
			if (hasUnionType) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 35);
				WriteUtils.write_TYPE_STRING(output, unionType);
			}
			if (hasAppellation) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 36);
				WriteUtils.write_TYPE_MESSAGE(output, appellation);
			}
			for (var appellationListIndex:uint = 0; appellationListIndex < appellationList.length; ++appellationListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 37);
				WriteUtils.write_TYPE_MESSAGE(output, appellationList[appellationListIndex]);
			}
			if (hasCorpsInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 38);
				WriteUtils.write_TYPE_MESSAGE(output, corpsInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nicknameCount:uint = 0;
			var roletypeCount:uint = 0;
			var levelCount:uint = 0;
			var professionCount:uint = 0;
			var energyCount:uint = 0;
			var rankCount:uint = 0;
			var guildnameCount:uint = 0;
			var manualStrCount:uint = 0;
			var manualVitCount:uint = 0;
			var manualDexCount:uint = 0;
			var manualWisCount:uint = 0;
			var maxHpCount:uint = 0;
			var hpCount:uint = 0;
			var expCount:uint = 0;
			var maxExpCount:uint = 0;
			var physicalAttackCount:uint = 0;
			var magicAttackCount:uint = 0;
			var physicalDefenseCount:uint = 0;
			var magicDefenseCount:uint = 0;
			var speedCount:uint = 0;
			var critRateCount:uint = 0;
			var blockCount:uint = 0;
			var hitRateCount:uint = 0;
			var dodgeRateCount:uint = 0;
			var goldCount:uint = 0;
			var coinCount:uint = 0;
			var depositCount:uint = 0;
			var exULiliangCount:uint = 0;
			var exUMinjieCount:uint = 0;
			var exUZhiliCount:uint = 0;
			var exUNailiCount:uint = 0;
			var exUWugongCount:uint = 0;
			var exUMonggongCount:uint = 0;
			var unionTypeCount:uint = 0;
			var appellationCount:uint = 0;
			var corpsInfoCount:uint = 0;
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
					if (nicknameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nicknameCount;
					nickname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (roletypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roletypeCount;
					roletype = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (energyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++energyCount;
					energy = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (rankCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rankCount;
					rank = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (guildnameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++guildnameCount;
					guildname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (manualStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualStrCount;
					manualStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (manualVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualVitCount;
					manualVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (manualDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualDexCount;
					manualDex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (manualWisCount != 0) {
						throw new IOError('Bad data format.');
					}
					++manualWisCount;
					manualWis = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (maxHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxHpCount;
					maxHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (hpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hpCount;
					hp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (expCount != 0) {
						throw new IOError('Bad data format.');
					}
					++expCount;
					exp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (maxExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxExpCount;
					maxExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (physicalAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++physicalAttackCount;
					physicalAttack = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 18:
					if (magicAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++magicAttackCount;
					magicAttack = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 19:
					if (physicalDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++physicalDefenseCount;
					physicalDefense = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 20:
					if (magicDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++magicDefenseCount;
					magicDefense = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 21:
					if (speedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++speedCount;
					speed = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 22:
					if (critRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++critRateCount;
					critRate = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 23:
					if (blockCount != 0) {
						throw new IOError('Bad data format.');
					}
					++blockCount;
					block = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 24:
					if (hitRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hitRateCount;
					hitRate = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 25:
					if (dodgeRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dodgeRateCount;
					dodgeRate = ReadUtils.read_TYPE_FLOAT(input);
					break;
				case 26:
					if (goldCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldCount;
					gold = ReadUtils.read_TYPE_INT32(input);
					break;
				case 27:
					if (coinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinCount;
					coin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 28:
					if (depositCount != 0) {
						throw new IOError('Bad data format.');
					}
					++depositCount;
					deposit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 29:
					if (exULiliangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++exULiliangCount;
					exULiliang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 30:
					if (exUMinjieCount != 0) {
						throw new IOError('Bad data format.');
					}
					++exUMinjieCount;
					exUMinjie = ReadUtils.read_TYPE_INT32(input);
					break;
				case 31:
					if (exUZhiliCount != 0) {
						throw new IOError('Bad data format.');
					}
					++exUZhiliCount;
					exUZhili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 32:
					if (exUNailiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++exUNailiCount;
					exUNaili = ReadUtils.read_TYPE_INT32(input);
					break;
				case 33:
					if (exUWugongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++exUWugongCount;
					exUWugong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 34:
					if (exUMonggongCount != 0) {
						throw new IOError('Bad data format.');
					}
					++exUMonggongCount;
					exUMonggong = ReadUtils.read_TYPE_INT32(input);
					break;
				case 35:
					if (unionTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionTypeCount;
					unionType = ReadUtils.read_TYPE_STRING(input);
					break;
				case 36:
					if (appellationCount != 0) {
						throw new IOError('Bad data format.');
					}
					++appellationCount;
					appellation = new proto.scene.Appellation;
					ReadUtils.read_TYPE_MESSAGE(input, appellation);
					break;
				case 37:
					appellationList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.Appellation));
					break;
				case 38:
					if (corpsInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsInfoCount;
					corpsInfo = new proto.scene.CorpsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, corpsInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
