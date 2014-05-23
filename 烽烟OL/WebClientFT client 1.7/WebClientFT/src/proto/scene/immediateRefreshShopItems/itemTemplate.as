package proto.scene.immediateRefreshShopItems {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class itemTemplate extends Message implements IExternalizable {
		private var addEffect_:String;
		public function get hasAddEffect():Boolean {
			return null != addEffect_;
		}
		public function set addEffect(value:String):void {
			addEffect_ = value;
		}
		public function get addEffect():String {
			return addEffect_;
		}
		private var alive_:int;
		private var hasAlive_:Boolean = false;
		public function get hasAlive():Boolean {
			return hasAlive_;
		}
		public function set alive(value:int):void {
			hasAlive_ = true;
			alive_ = value;
		}
		public function get alive():int {
			return alive_;
		}
		private var aliveTime_:int;
		private var hasAliveTime_:Boolean = false;
		public function get hasAliveTime():Boolean {
			return hasAliveTime_;
		}
		public function set aliveTime(value:int):void {
			hasAliveTime_ = true;
			aliveTime_ = value;
		}
		public function get aliveTime():int {
			return aliveTime_;
		}
		private var bind_:int;
		private var hasBind_:Boolean = false;
		public function get hasBind():Boolean {
			return hasBind_;
		}
		public function set bind(value:int):void {
			hasBind_ = true;
			bind_ = value;
		}
		public function get bind():int {
			return bind_;
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
		private var buyingRate_:int;
		private var hasBuyingRate_:Boolean = false;
		public function get hasBuyingRate():Boolean {
			return hasBuyingRate_;
		}
		public function set buyingRate(value:int):void {
			hasBuyingRate_ = true;
			buyingRate_ = value;
		}
		public function get buyingRate():int {
			return buyingRate_;
		}
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
		private var buyingRateGold_:int;
		private var hasBuyingRateGold_:Boolean = false;
		public function get hasBuyingRateGold():Boolean {
			return hasBuyingRateGold_;
		}
		public function set buyingRateGold(value:int):void {
			hasBuyingRateGold_ = true;
			buyingRateGold_ = value;
		}
		public function get buyingRateGold():int {
			return buyingRateGold_;
		}
		private var defense_:int;
		private var hasDefense_:Boolean = false;
		public function get hasDefense():Boolean {
			return hasDefense_;
		}
		public function set defense(value:int):void {
			hasDefense_ = true;
			defense_ = value;
		}
		public function get defense():int {
			return defense_;
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
		private var dexRequire_:int;
		private var hasDexRequire_:Boolean = false;
		public function get hasDexRequire():Boolean {
			return hasDexRequire_;
		}
		public function set dexRequire(value:int):void {
			hasDexRequire_ = true;
			dexRequire_ = value;
		}
		public function get dexRequire():int {
			return dexRequire_;
		}
		private var druability_:int;
		private var hasDruability_:Boolean = false;
		public function get hasDruability():Boolean {
			return hasDruability_;
		}
		public function set druability(value:int):void {
			hasDruability_ = true;
			druability_ = value;
		}
		public function get druability():int {
			return druability_;
		}
		private var extraAttributeGroup_:int;
		private var hasExtraAttributeGroup_:Boolean = false;
		public function get hasExtraAttributeGroup():Boolean {
			return hasExtraAttributeGroup_;
		}
		public function set extraAttributeGroup(value:int):void {
			hasExtraAttributeGroup_ = true;
			extraAttributeGroup_ = value;
		}
		public function get extraAttributeGroup():int {
			return extraAttributeGroup_;
		}
		private var extraAttributeID_:int;
		private var hasExtraAttributeID_:Boolean = false;
		public function get hasExtraAttributeID():Boolean {
			return hasExtraAttributeID_;
		}
		public function set extraAttributeID(value:int):void {
			hasExtraAttributeID_ = true;
			extraAttributeID_ = value;
		}
		public function get extraAttributeID():int {
			return extraAttributeID_;
		}
		private var height_:int;
		private var hasHeight_:Boolean = false;
		public function get hasHeight():Boolean {
			return hasHeight_;
		}
		public function set height(value:int):void {
			hasHeight_ = true;
			height_ = value;
		}
		public function get height():int {
			return height_;
		}
		private var icon_:String;
		public function get hasIcon():Boolean {
			return null != icon_;
		}
		public function set icon(value:String):void {
			icon_ = value;
		}
		public function get icon():String {
			return icon_;
		}
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
		private var maxDamage_:int;
		private var hasMaxDamage_:Boolean = false;
		public function get hasMaxDamage():Boolean {
			return hasMaxDamage_;
		}
		public function set maxDamage(value:int):void {
			hasMaxDamage_ = true;
			maxDamage_ = value;
		}
		public function get maxDamage():int {
			return maxDamage_;
		}
		private var minDamage_:int;
		private var hasMinDamage_:Boolean = false;
		public function get hasMinDamage():Boolean {
			return hasMinDamage_;
		}
		public function set minDamage(value:int):void {
			hasMinDamage_ = true;
			minDamage_ = value;
		}
		public function get minDamage():int {
			return minDamage_;
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
		private var qualityLevel_:int;
		private var hasQualityLevel_:Boolean = false;
		public function get hasQualityLevel():Boolean {
			return hasQualityLevel_;
		}
		public function set qualityLevel(value:int):void {
			hasQualityLevel_ = true;
			qualityLevel_ = value;
		}
		public function get qualityLevel():int {
			return qualityLevel_;
		}
		private var repaire_:int;
		private var hasRepaire_:Boolean = false;
		public function get hasRepaire():Boolean {
			return hasRepaire_;
		}
		public function set repaire(value:int):void {
			hasRepaire_ = true;
			repaire_ = value;
		}
		public function get repaire():int {
			return repaire_;
		}
		private var script_:String;
		public function get hasScript():Boolean {
			return null != script_;
		}
		public function set script(value:String):void {
			script_ = value;
		}
		public function get script():String {
			return script_;
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
		private var store_:int;
		private var hasStore_:Boolean = false;
		public function get hasStore():Boolean {
			return hasStore_;
		}
		public function set store(value:int):void {
			hasStore_ = true;
			store_ = value;
		}
		public function get store():int {
			return store_;
		}
		private var strRequire_:int;
		private var hasStrRequire_:Boolean = false;
		public function get hasStrRequire():Boolean {
			return hasStrRequire_;
		}
		public function set strRequire(value:int):void {
			hasStrRequire_ = true;
			strRequire_ = value;
		}
		public function get strRequire():int {
			return strRequire_;
		}
		private var trade_:int;
		private var hasTrade_:Boolean = false;
		public function get hasTrade():Boolean {
			return hasTrade_;
		}
		public function set trade(value:int):void {
			hasTrade_ = true;
			trade_ = value;
		}
		public function get trade():int {
			return trade_;
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
		private var vitRequire_:int;
		private var hasVitRequire_:Boolean = false;
		public function get hasVitRequire():Boolean {
			return hasVitRequire_;
		}
		public function set vitRequire(value:int):void {
			hasVitRequire_ = true;
			vitRequire_ = value;
		}
		public function get vitRequire():int {
			return vitRequire_;
		}
		private var width_:int;
		private var hasWidth_:Boolean = false;
		public function get hasWidth():Boolean {
			return hasWidth_;
		}
		public function set width(value:int):void {
			hasWidth_ = true;
			width_ = value;
		}
		public function get width():int {
			return width_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasAddEffect) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, addEffect);
			}
			if (hasAlive) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, alive);
			}
			if (hasAliveTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, aliveTime);
			}
			if (hasBind) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, bind);
			}
			if (hasBodyType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, bodyType);
			}
			if (hasBuyingRate) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, buyingRate);
			}
			if (hasBuyingRateCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, buyingRateCoin);
			}
			if (hasBuyingRateGold) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, buyingRateGold);
			}
			if (hasDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, defense);
			}
			if (hasDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, description);
			}
			if (hasDexRequire) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, dexRequire);
			}
			if (hasDruability) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, druability);
			}
			if (hasExtraAttributeGroup) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, extraAttributeGroup);
			}
			if (hasExtraAttributeID) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, extraAttributeID);
			}
			if (hasHeight) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, height);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 16);
				WriteUtils.write_TYPE_STRING(output, icon);
			}
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasLevelRequire) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, levelRequire);
			}
			if (hasMaxDamage) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, maxDamage);
			}
			if (hasMinDamage) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, minDamage);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 21);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasProfessionRequire) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, professionRequire);
			}
			if (hasQualityLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, qualityLevel);
			}
			if (hasRepaire) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_INT32(output, repaire);
			}
			if (hasScript) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 25);
				WriteUtils.write_TYPE_STRING(output, script);
			}
			if (hasStack) {
				WriteUtils.writeTag(output, WireType.VARINT, 26);
				WriteUtils.write_TYPE_INT32(output, stack);
			}
			if (hasStore) {
				WriteUtils.writeTag(output, WireType.VARINT, 27);
				WriteUtils.write_TYPE_INT32(output, store);
			}
			if (hasStrRequire) {
				WriteUtils.writeTag(output, WireType.VARINT, 28);
				WriteUtils.write_TYPE_INT32(output, strRequire);
			}
			if (hasTrade) {
				WriteUtils.writeTag(output, WireType.VARINT, 29);
				WriteUtils.write_TYPE_INT32(output, trade);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 30);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasVitRequire) {
				WriteUtils.writeTag(output, WireType.VARINT, 31);
				WriteUtils.write_TYPE_INT32(output, vitRequire);
			}
			if (hasWidth) {
				WriteUtils.writeTag(output, WireType.VARINT, 32);
				WriteUtils.write_TYPE_INT32(output, width);
			}
		}
		public function readExternal(input:IDataInput):void {
			var addEffectCount:uint = 0;
			var aliveCount:uint = 0;
			var aliveTimeCount:uint = 0;
			var bindCount:uint = 0;
			var bodyTypeCount:uint = 0;
			var buyingRateCount:uint = 0;
			var buyingRateCoinCount:uint = 0;
			var buyingRateGoldCount:uint = 0;
			var defenseCount:uint = 0;
			var descriptionCount:uint = 0;
			var dexRequireCount:uint = 0;
			var druabilityCount:uint = 0;
			var extraAttributeGroupCount:uint = 0;
			var extraAttributeIDCount:uint = 0;
			var heightCount:uint = 0;
			var iconCount:uint = 0;
			var idCount:uint = 0;
			var levelRequireCount:uint = 0;
			var maxDamageCount:uint = 0;
			var minDamageCount:uint = 0;
			var nameCount:uint = 0;
			var professionRequireCount:uint = 0;
			var qualityLevelCount:uint = 0;
			var repaireCount:uint = 0;
			var scriptCount:uint = 0;
			var stackCount:uint = 0;
			var storeCount:uint = 0;
			var strRequireCount:uint = 0;
			var tradeCount:uint = 0;
			var typeCount:uint = 0;
			var vitRequireCount:uint = 0;
			var widthCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (addEffectCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addEffectCount;
					addEffect = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (aliveCount != 0) {
						throw new IOError('Bad data format.');
					}
					++aliveCount;
					alive = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (aliveTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++aliveTimeCount;
					aliveTime = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (bindCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bindCount;
					bind = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (bodyTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bodyTypeCount;
					bodyType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (buyingRateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buyingRateCount;
					buyingRate = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (buyingRateCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buyingRateCoinCount;
					buyingRateCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (buyingRateGoldCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buyingRateGoldCount;
					buyingRateGold = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (defenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++defenseCount;
					defense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (descriptionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++descriptionCount;
					description = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (dexRequireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dexRequireCount;
					dexRequire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (druabilityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++druabilityCount;
					druability = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (extraAttributeGroupCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extraAttributeGroupCount;
					extraAttributeGroup = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (extraAttributeIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extraAttributeIDCount;
					extraAttributeID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (heightCount != 0) {
						throw new IOError('Bad data format.');
					}
					++heightCount;
					height = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_STRING(input);
					break;
				case 17:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 18:
					if (levelRequireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelRequireCount;
					levelRequire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 19:
					if (maxDamageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxDamageCount;
					maxDamage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (minDamageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++minDamageCount;
					minDamage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 21:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 22:
					if (professionRequireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionRequireCount;
					professionRequire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (qualityLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++qualityLevelCount;
					qualityLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (repaireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++repaireCount;
					repaire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 25:
					if (scriptCount != 0) {
						throw new IOError('Bad data format.');
					}
					++scriptCount;
					script = ReadUtils.read_TYPE_STRING(input);
					break;
				case 26:
					if (stackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stackCount;
					stack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 27:
					if (storeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++storeCount;
					store = ReadUtils.read_TYPE_INT32(input);
					break;
				case 28:
					if (strRequireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++strRequireCount;
					strRequire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 29:
					if (tradeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tradeCount;
					trade = ReadUtils.read_TYPE_INT32(input);
					break;
				case 30:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 31:
					if (vitRequireCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vitRequireCount;
					vitRequire = ReadUtils.read_TYPE_INT32(input);
					break;
				case 32:
					if (widthCount != 0) {
						throw new IOError('Bad data format.');
					}
					++widthCount;
					width = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
