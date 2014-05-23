package proto {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.XQ_Info;
	import proto.Suite;
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
		private var extBlockAdditional_:int;
		private var hasExtBlockAdditional_:Boolean = false;
		public function get hasExtBlockAdditional():Boolean {
			return hasExtBlockAdditional_;
		}
		public function set extBlockAdditional(value:int):void {
			hasExtBlockAdditional_ = true;
			extBlockAdditional_ = value;
		}
		public function get extBlockAdditional():int {
			return extBlockAdditional_;
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
		private var xqInfo_:proto.XQ_Info;
		public function get hasXqInfo():Boolean {
			return null != xqInfo_;
		}
		public function set xqInfo(value:proto.XQ_Info):void {
			xqInfo_ = value;
		}
		public function get xqInfo():proto.XQ_Info {
			return xqInfo_;
		}
		private var suiteInfo_:proto.Suite;
		public function get hasSuiteInfo():Boolean {
			return null != suiteInfo_;
		}
		public function set suiteInfo(value:proto.Suite):void {
			suiteInfo_ = value;
		}
		public function get suiteInfo():proto.Suite {
			return suiteInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasPrefixNmae) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, prefixNmae);
			}
			if (hasSuffixName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, suffixName);
			}
			if (hasIsBound) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, isBound);
			}
			if (hasExtAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, extAttack);
			}
			if (hasExtStr) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, extStr);
			}
			if (hasExtVit) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, extVit);
			}
			if (hasExtDex) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, extDex);
			}
			if (hasExtWis) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, extWis);
			}
			if (hasExtPhysicalAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, extPhysicalAttack);
			}
			if (hasExtMagicAttack) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, extMagicAttack);
			}
			if (hasExtPhysicalDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, extPhysicalDefense);
			}
			if (hasExtMagicDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, extMagicDefense);
			}
			if (hasExtHpAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, extHpAdditional);
			}
			if (hasExtMpAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, extMpAdditional);
			}
			if (hasExtHitAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, extHitAdditional);
			}
			if (hasExtCritAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, extCritAdditional);
			}
			if (hasExtBlockAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, extBlockAdditional);
			}
			if (hasExtDodgeAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, extDodgeAdditional);
			}
			if (hasExtSpeedAdditional) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, extSpeedAdditional);
			}
			if (hasBuyingRateCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 21);
				WriteUtils.write_TYPE_INT32(output, buyingRateCoin);
			}
			if (hasExtDefense) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, extDefense);
			}
			if (hasStack) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, stack);
			}
			if (hasStarLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_INT32(output, starLevel);
			}
			if (hasTemplateId) {
				WriteUtils.writeTag(output, WireType.VARINT, 25);
				WriteUtils.write_TYPE_INT32(output, templateId);
			}
			if (hasXqInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 26);
				WriteUtils.write_TYPE_MESSAGE(output, xqInfo);
			}
			if (hasSuiteInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 27);
				WriteUtils.write_TYPE_MESSAGE(output, suiteInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var prefixNmaeCount:uint = 0;
			var suffixNameCount:uint = 0;
			var isBoundCount:uint = 0;
			var extAttackCount:uint = 0;
			var extStrCount:uint = 0;
			var extVitCount:uint = 0;
			var extDexCount:uint = 0;
			var extWisCount:uint = 0;
			var extPhysicalAttackCount:uint = 0;
			var extMagicAttackCount:uint = 0;
			var extPhysicalDefenseCount:uint = 0;
			var extMagicDefenseCount:uint = 0;
			var extHpAdditionalCount:uint = 0;
			var extMpAdditionalCount:uint = 0;
			var extHitAdditionalCount:uint = 0;
			var extCritAdditionalCount:uint = 0;
			var extBlockAdditionalCount:uint = 0;
			var extDodgeAdditionalCount:uint = 0;
			var extSpeedAdditionalCount:uint = 0;
			var buyingRateCoinCount:uint = 0;
			var extDefenseCount:uint = 0;
			var stackCount:uint = 0;
			var starLevelCount:uint = 0;
			var templateIdCount:uint = 0;
			var xqInfoCount:uint = 0;
			var suiteInfoCount:uint = 0;
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
					if (prefixNmaeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++prefixNmaeCount;
					prefixNmae = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (suffixNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++suffixNameCount;
					suffixName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (isBoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isBoundCount;
					isBound = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (extAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extAttackCount;
					extAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (extStrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extStrCount;
					extStr = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (extVitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extVitCount;
					extVit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (extDexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extDexCount;
					extDex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (extWisCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extWisCount;
					extWis = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (extPhysicalAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extPhysicalAttackCount;
					extPhysicalAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (extMagicAttackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extMagicAttackCount;
					extMagicAttack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (extPhysicalDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extPhysicalDefenseCount;
					extPhysicalDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (extMagicDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extMagicDefenseCount;
					extMagicDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (extHpAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extHpAdditionalCount;
					extHpAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (extMpAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extMpAdditionalCount;
					extMpAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (extHitAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extHitAdditionalCount;
					extHitAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (extCritAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extCritAdditionalCount;
					extCritAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 18:
					if (extBlockAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extBlockAdditionalCount;
					extBlockAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 19:
					if (extDodgeAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extDodgeAdditionalCount;
					extDodgeAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (extSpeedAdditionalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extSpeedAdditionalCount;
					extSpeedAdditional = ReadUtils.read_TYPE_INT32(input);
					break;
				case 21:
					if (buyingRateCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buyingRateCoinCount;
					buyingRateCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 22:
					if (extDefenseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extDefenseCount;
					extDefense = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (stackCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stackCount;
					stack = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (starLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++starLevelCount;
					starLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 25:
					if (templateIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++templateIdCount;
					templateId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 26:
					if (xqInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xqInfoCount;
					xqInfo = new proto.XQ_Info;
					ReadUtils.read_TYPE_MESSAGE(input, xqInfo);
					break;
				case 27:
					if (suiteInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++suiteInfoCount;
					suiteInfo = new proto.Suite;
					ReadUtils.read_TYPE_MESSAGE(input, suiteInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
