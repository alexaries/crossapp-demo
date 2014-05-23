package proto.battle.battle703 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.battle.battle703.Item;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SettlementData extends Message implements IExternalizable {
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
		private var expBonus_:int;
		private var hasExpBonus_:Boolean = false;
		public function get hasExpBonus():Boolean {
			return hasExpBonus_;
		}
		public function set expBonus(value:int):void {
			hasExpBonus_ = true;
			expBonus_ = value;
		}
		public function get expBonus():int {
			return expBonus_;
		}
		private var coinBonus_:int;
		private var hasCoinBonus_:Boolean = false;
		public function get hasCoinBonus():Boolean {
			return hasCoinBonus_;
		}
		public function set coinBonus(value:int):void {
			hasCoinBonus_ = true;
			coinBonus_ = value;
		}
		public function get coinBonus():int {
			return coinBonus_;
		}
		private var goldBonus_:int;
		private var hasGoldBonus_:Boolean = false;
		public function get hasGoldBonus():Boolean {
			return hasGoldBonus_;
		}
		public function set goldBonus(value:int):void {
			hasGoldBonus_ = true;
			goldBonus_ = value;
		}
		public function get goldBonus():int {
			return goldBonus_;
		}
		private var itemsBonus_:proto.battle.battle703.Item;
		public function get hasItemsBonus():Boolean {
			return null != itemsBonus_;
		}
		public function set itemsBonus(value:proto.battle.battle703.Item):void {
			itemsBonus_ = value;
		}
		public function get itemsBonus():proto.battle.battle703.Item {
			return itemsBonus_;
		}
		private var popularity_:int;
		private var hasPopularity_:Boolean = false;
		public function get hasPopularity():Boolean {
			return hasPopularity_;
		}
		public function set popularity(value:int):void {
			hasPopularity_ = true;
			popularity_ = value;
		}
		public function get popularity():int {
			return popularity_;
		}
		private var attackGoal_:int;
		private var hasAttackGoal_:Boolean = false;
		public function get hasAttackGoal():Boolean {
			return hasAttackGoal_;
		}
		public function set attackGoal(value:int):void {
			hasAttackGoal_ = true;
			attackGoal_ = value;
		}
		public function get attackGoal():int {
			return attackGoal_;
		}
		private var defenseGoal_:int;
		private var hasDefenseGoal_:Boolean = false;
		public function get hasDefenseGoal():Boolean {
			return hasDefenseGoal_;
		}
		public function set defenseGoal(value:int):void {
			hasDefenseGoal_ = true;
			defenseGoal_ = value;
		}
		public function get defenseGoal():int {
			return defenseGoal_;
		}
		private var slayGoal_:int;
		private var hasSlayGoal_:Boolean = false;
		public function get hasSlayGoal():Boolean {
			return hasSlayGoal_;
		}
		public function set slayGoal(value:int):void {
			hasSlayGoal_ = true;
			slayGoal_ = value;
		}
		public function get slayGoal():int {
			return slayGoal_;
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
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasExpBonus) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, expBonus);
			}
			if (hasCoinBonus) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, coinBonus);
			}
			if (hasGoldBonus) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, goldBonus);
			}
			if (hasItemsBonus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, itemsBonus);
			}
			if (hasPopularity) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, popularity);
			}
			if (hasAttackGoal) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, attackGoal);
			}
			if (hasDefenseGoal) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, defenseGoal);
			}
			if (hasSlayGoal) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, slayGoal);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasProfession) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, profession);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var expBonusCount:uint = 0;
			var coinBonusCount:uint = 0;
			var goldBonusCount:uint = 0;
			var itemsBonusCount:uint = 0;
			var popularityCount:uint = 0;
			var attackGoalCount:uint = 0;
			var defenseGoalCount:uint = 0;
			var slayGoalCount:uint = 0;
			var nameCount:uint = 0;
			var professionCount:uint = 0;
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
					if (expBonusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++expBonusCount;
					expBonus = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (coinBonusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinBonusCount;
					coinBonus = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (goldBonusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++goldBonusCount;
					goldBonus = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (itemsBonusCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemsBonusCount;
					itemsBonus = new proto.battle.battle703.Item;
					ReadUtils.read_TYPE_MESSAGE(input, itemsBonus);
					break;
				case 6:
					if (popularityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++popularityCount;
					popularity = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (attackGoalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++attackGoalCount;
					attackGoal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (defenseGoalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++defenseGoalCount;
					defenseGoal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (slayGoalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++slayGoalCount;
					slayGoal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (professionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++professionCount;
					profession = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
