package proto.zudui.zudui4308 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zudui.zudui4308.EnemyArray;
	import proto.zudui.zudui4308.BuffInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FightData extends Message implements IExternalizable {
		private var chaId_:int;
		private var hasChaId_:Boolean = false;
		public function get hasChaId():Boolean {
			return hasChaId_;
		}
		public function set chaId(value:int):void {
			hasChaId_ = true;
			chaId_ = value;
		}
		public function get chaId():int {
			return chaId_;
		}
		private var chaBattleId_:int;
		private var hasChaBattleId_:Boolean = false;
		public function get hasChaBattleId():Boolean {
			return hasChaBattleId_;
		}
		public function set chaBattleId(value:int):void {
			hasChaBattleId_ = true;
			chaBattleId_ = value;
		}
		public function get chaBattleId():int {
			return chaBattleId_;
		}
		private var chaProfessionType_:int;
		private var hasChaProfessionType_:Boolean = false;
		public function get hasChaProfessionType():Boolean {
			return hasChaProfessionType_;
		}
		public function set chaProfessionType(value:int):void {
			hasChaProfessionType_ = true;
			chaProfessionType_ = value;
		}
		public function get chaProfessionType():int {
			return chaProfessionType_;
		}
		private var actionId_:int;
		private var hasActionId_:Boolean = false;
		public function get hasActionId():Boolean {
			return hasActionId_;
		}
		public function set actionId(value:int):void {
			hasActionId_ = true;
			actionId_ = value;
		}
		public function get actionId():int {
			return actionId_;
		}
		private var counterHitActionId_:int;
		private var hasCounterHitActionId_:Boolean = false;
		public function get hasCounterHitActionId():Boolean {
			return hasCounterHitActionId_;
		}
		public function set counterHitActionId(value:int):void {
			hasCounterHitActionId_ = true;
			counterHitActionId_ = value;
		}
		public function get counterHitActionId():int {
			return counterHitActionId_;
		}
		private var isDeathOfCounterHit_:int;
		private var hasIsDeathOfCounterHit_:Boolean = false;
		public function get hasIsDeathOfCounterHit():Boolean {
			return hasIsDeathOfCounterHit_;
		}
		public function set isDeathOfCounterHit(value:int):void {
			hasIsDeathOfCounterHit_ = true;
			isDeathOfCounterHit_ = value;
		}
		public function get isDeathOfCounterHit():int {
			return isDeathOfCounterHit_;
		}
		private var txtEffectId_:int;
		private var hasTxtEffectId_:Boolean = false;
		public function get hasTxtEffectId():Boolean {
			return hasTxtEffectId_;
		}
		public function set txtEffectId(value:int):void {
			hasTxtEffectId_ = true;
			txtEffectId_ = value;
		}
		public function get txtEffectId():int {
			return txtEffectId_;
		}
		private var chaEffectId_:int;
		private var hasChaEffectId_:Boolean = false;
		public function get hasChaEffectId():Boolean {
			return hasChaEffectId_;
		}
		public function set chaEffectId(value:int):void {
			hasChaEffectId_ = true;
			chaEffectId_ = value;
		}
		public function get chaEffectId():int {
			return chaEffectId_;
		}
		private var chaEnemyEffectId_:int;
		private var hasChaEnemyEffectId_:Boolean = false;
		public function get hasChaEnemyEffectId():Boolean {
			return hasChaEnemyEffectId_;
		}
		public function set chaEnemyEffectId(value:int):void {
			hasChaEnemyEffectId_ = true;
			chaEnemyEffectId_ = value;
		}
		public function get chaEnemyEffectId():int {
			return chaEnemyEffectId_;
		}
		private var chaThrowEffectId_:int;
		private var hasChaThrowEffectId_:Boolean = false;
		public function get hasChaThrowEffectId():Boolean {
			return hasChaThrowEffectId_;
		}
		public function set chaThrowEffectId(value:int):void {
			hasChaThrowEffectId_ = true;
			chaThrowEffectId_ = value;
		}
		public function get chaThrowEffectId():int {
			return chaThrowEffectId_;
		}
		private var chaAoeEffectId_:int;
		private var hasChaAoeEffectId_:Boolean = false;
		public function get hasChaAoeEffectId():Boolean {
			return hasChaAoeEffectId_;
		}
		public function set chaAoeEffectId(value:int):void {
			hasChaAoeEffectId_ = true;
			chaAoeEffectId_ = value;
		}
		public function get chaAoeEffectId():int {
			return chaAoeEffectId_;
		}
		[ArrayElementType("int")]
		public var chaBuffArr:Array = [];
		[ArrayElementType("proto.zudui.zudui4308.BuffInfo")]
		public var chaBuffShowList:Array = [];
		private var chaPowerUp_:int;
		private var hasChaPowerUp_:Boolean = false;
		public function get hasChaPowerUp():Boolean {
			return hasChaPowerUp_;
		}
		public function set chaPowerUp(value:int):void {
			hasChaPowerUp_ = true;
			chaPowerUp_ = value;
		}
		public function get chaPowerUp():int {
			return chaPowerUp_;
		}
		private var chaPowerDown_:int;
		private var hasChaPowerDown_:Boolean = false;
		public function get hasChaPowerDown():Boolean {
			return hasChaPowerDown_;
		}
		public function set chaPowerDown(value:int):void {
			hasChaPowerDown_ = true;
			chaPowerDown_ = value;
		}
		public function get chaPowerDown():int {
			return chaPowerDown_;
		}
		private var chaCurrentPower_:int;
		private var hasChaCurrentPower_:Boolean = false;
		public function get hasChaCurrentPower():Boolean {
			return hasChaCurrentPower_;
		}
		public function set chaCurrentPower(value:int):void {
			hasChaCurrentPower_ = true;
			chaCurrentPower_ = value;
		}
		public function get chaCurrentPower():int {
			return chaCurrentPower_;
		}
		private var chaChangeHp_:int;
		private var hasChaChangeHp_:Boolean = false;
		public function get hasChaChangeHp():Boolean {
			return hasChaChangeHp_;
		}
		public function set chaChangeHp(value:int):void {
			hasChaChangeHp_ = true;
			chaChangeHp_ = value;
		}
		public function get chaChangeHp():int {
			return chaChangeHp_;
		}
		private var chaCurrentHp_:int;
		private var hasChaCurrentHp_:Boolean = false;
		public function get hasChaCurrentHp():Boolean {
			return hasChaCurrentHp_;
		}
		public function set chaCurrentHp(value:int):void {
			hasChaCurrentHp_ = true;
			chaCurrentHp_ = value;
		}
		public function get chaCurrentHp():int {
			return chaCurrentHp_;
		}
		private var chaExpendHp_:int;
		private var hasChaExpendHp_:Boolean = false;
		public function get hasChaExpendHp():Boolean {
			return hasChaExpendHp_;
		}
		public function set chaExpendHp(value:int):void {
			hasChaExpendHp_ = true;
			chaExpendHp_ = value;
		}
		public function get chaExpendHp():int {
			return chaExpendHp_;
		}
		[ArrayElementType("int")]
		public var chaStartPos:Array = [];
		[ArrayElementType("int")]
		public var chaTargetPos:Array = [];
		private var chaAttackType_:int;
		private var hasChaAttackType_:Boolean = false;
		public function get hasChaAttackType():Boolean {
			return hasChaAttackType_;
		}
		public function set chaAttackType(value:int):void {
			hasChaAttackType_ = true;
			chaAttackType_ = value;
		}
		public function get chaAttackType():int {
			return chaAttackType_;
		}
		private var chaDirection_:int;
		private var hasChaDirection_:Boolean = false;
		public function get hasChaDirection():Boolean {
			return hasChaDirection_;
		}
		public function set chaDirection(value:int):void {
			hasChaDirection_ = true;
			chaDirection_ = value;
		}
		public function get chaDirection():int {
			return chaDirection_;
		}
		private var isCriticalBlow_:Boolean;
		private var hasIsCriticalBlow_:Boolean = false;
		public function get hasIsCriticalBlow():Boolean {
			return hasIsCriticalBlow_;
		}
		public function set isCriticalBlow(value:Boolean):void {
			hasIsCriticalBlow_ = true;
			isCriticalBlow_ = value;
		}
		public function get isCriticalBlow():Boolean {
			return isCriticalBlow_;
		}
		[ArrayElementType("proto.zudui.zudui4308.EnemyArray")]
		public var enemyChaArr:Array = [];
		private var chaTotalHp_:int;
		private var hasChaTotalHp_:Boolean = false;
		public function get hasChaTotalHp():Boolean {
			return hasChaTotalHp_;
		}
		public function set chaTotalHp(value:int):void {
			hasChaTotalHp_ = true;
			chaTotalHp_ = value;
		}
		public function get chaTotalHp():int {
			return chaTotalHp_;
		}
		private var chaTotalPower_:int;
		private var hasChaTotalPower_:Boolean = false;
		public function get hasChaTotalPower():Boolean {
			return hasChaTotalPower_;
		}
		public function set chaTotalPower(value:int):void {
			hasChaTotalPower_ = true;
			chaTotalPower_ = value;
		}
		public function get chaTotalPower():int {
			return chaTotalPower_;
		}
		private var powerEffectId_:int;
		private var hasPowerEffectId_:Boolean = false;
		public function get hasPowerEffectId():Boolean {
			return hasPowerEffectId_;
		}
		public function set powerEffectId(value:int):void {
			hasPowerEffectId_ = true;
			powerEffectId_ = value;
		}
		public function get powerEffectId():int {
			return powerEffectId_;
		}
		private var chaName_:String;
		public function get hasChaName():Boolean {
			return null != chaName_;
		}
		public function set chaName(value:String):void {
			chaName_ = value;
		}
		public function get chaName():String {
			return chaName_;
		}
		private var chaLevel_:int;
		private var hasChaLevel_:Boolean = false;
		public function get hasChaLevel():Boolean {
			return hasChaLevel_;
		}
		public function set chaLevel(value:int):void {
			hasChaLevel_ = true;
			chaLevel_ = value;
		}
		public function get chaLevel():int {
			return chaLevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasChaId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, chaId);
			}
			if (hasChaBattleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, chaBattleId);
			}
			if (hasChaProfessionType) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, chaProfessionType);
			}
			if (hasActionId) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, actionId);
			}
			if (hasCounterHitActionId) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, counterHitActionId);
			}
			if (hasIsDeathOfCounterHit) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, isDeathOfCounterHit);
			}
			if (hasTxtEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, txtEffectId);
			}
			if (hasChaEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, chaEffectId);
			}
			if (hasChaEnemyEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, chaEnemyEffectId);
			}
			if (hasChaThrowEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, chaThrowEffectId);
			}
			if (hasChaAoeEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, chaAoeEffectId);
			}
			for (var chaBuffArrIndex:uint = 0; chaBuffArrIndex < chaBuffArr.length; ++chaBuffArrIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, chaBuffArr[chaBuffArrIndex]);
			}
			for (var chaBuffShowListIndex:uint = 0; chaBuffShowListIndex < chaBuffShowList.length; ++chaBuffShowListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 13);
				WriteUtils.write_TYPE_MESSAGE(output, chaBuffShowList[chaBuffShowListIndex]);
			}
			if (hasChaPowerUp) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, chaPowerUp);
			}
			if (hasChaPowerDown) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, chaPowerDown);
			}
			if (hasChaCurrentPower) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, chaCurrentPower);
			}
			if (hasChaChangeHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, chaChangeHp);
			}
			if (hasChaCurrentHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, chaCurrentHp);
			}
			if (hasChaExpendHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, chaExpendHp);
			}
			for (var chaStartPosIndex:uint = 0; chaStartPosIndex < chaStartPos.length; ++chaStartPosIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, chaStartPos[chaStartPosIndex]);
			}
			for (var chaTargetPosIndex:uint = 0; chaTargetPosIndex < chaTargetPos.length; ++chaTargetPosIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 21);
				WriteUtils.write_TYPE_INT32(output, chaTargetPos[chaTargetPosIndex]);
			}
			if (hasChaAttackType) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, chaAttackType);
			}
			if (hasChaDirection) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, chaDirection);
			}
			if (hasIsCriticalBlow) {
				WriteUtils.writeTag(output, WireType.VARINT, 24);
				WriteUtils.write_TYPE_BOOL(output, isCriticalBlow);
			}
			for (var enemyChaArrIndex:uint = 0; enemyChaArrIndex < enemyChaArr.length; ++enemyChaArrIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 25);
				WriteUtils.write_TYPE_MESSAGE(output, enemyChaArr[enemyChaArrIndex]);
			}
			if (hasChaTotalHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 26);
				WriteUtils.write_TYPE_INT32(output, chaTotalHp);
			}
			if (hasChaTotalPower) {
				WriteUtils.writeTag(output, WireType.VARINT, 27);
				WriteUtils.write_TYPE_INT32(output, chaTotalPower);
			}
			if (hasPowerEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 28);
				WriteUtils.write_TYPE_INT32(output, powerEffectId);
			}
			if (hasChaName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 29);
				WriteUtils.write_TYPE_STRING(output, chaName);
			}
			if (hasChaLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 30);
				WriteUtils.write_TYPE_INT32(output, chaLevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var chaIdCount:uint = 0;
			var chaBattleIdCount:uint = 0;
			var chaProfessionTypeCount:uint = 0;
			var actionIdCount:uint = 0;
			var counterHitActionIdCount:uint = 0;
			var isDeathOfCounterHitCount:uint = 0;
			var txtEffectIdCount:uint = 0;
			var chaEffectIdCount:uint = 0;
			var chaEnemyEffectIdCount:uint = 0;
			var chaThrowEffectIdCount:uint = 0;
			var chaAoeEffectIdCount:uint = 0;
			var chaPowerUpCount:uint = 0;
			var chaPowerDownCount:uint = 0;
			var chaCurrentPowerCount:uint = 0;
			var chaChangeHpCount:uint = 0;
			var chaCurrentHpCount:uint = 0;
			var chaExpendHpCount:uint = 0;
			var chaAttackTypeCount:uint = 0;
			var chaDirectionCount:uint = 0;
			var isCriticalBlowCount:uint = 0;
			var chaTotalHpCount:uint = 0;
			var chaTotalPowerCount:uint = 0;
			var powerEffectIdCount:uint = 0;
			var chaNameCount:uint = 0;
			var chaLevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (chaIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaIdCount;
					chaId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (chaBattleIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaBattleIdCount;
					chaBattleId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (chaProfessionTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaProfessionTypeCount;
					chaProfessionType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (actionIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++actionIdCount;
					actionId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (counterHitActionIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++counterHitActionIdCount;
					counterHitActionId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (isDeathOfCounterHitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isDeathOfCounterHitCount;
					isDeathOfCounterHit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (txtEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++txtEffectIdCount;
					txtEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (chaEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaEffectIdCount;
					chaEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (chaEnemyEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaEnemyEffectIdCount;
					chaEnemyEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (chaThrowEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaThrowEffectIdCount;
					chaThrowEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (chaAoeEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaAoeEffectIdCount;
					chaAoeEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, chaBuffArr);
					break;
					}
					chaBuffArr.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 13:
					chaBuffShowList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.zudui.zudui4308.BuffInfo));
					break;
				case 14:
					if (chaPowerUpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaPowerUpCount;
					chaPowerUp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (chaPowerDownCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaPowerDownCount;
					chaPowerDown = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (chaCurrentPowerCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaCurrentPowerCount;
					chaCurrentPower = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (chaChangeHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaChangeHpCount;
					chaChangeHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 18:
					if (chaCurrentHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaCurrentHpCount;
					chaCurrentHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 19:
					if (chaExpendHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaExpendHpCount;
					chaExpendHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, chaStartPos);
					break;
					}
					chaStartPos.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 21:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, chaTargetPos);
					break;
					}
					chaTargetPos.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 22:
					if (chaAttackTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaAttackTypeCount;
					chaAttackType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (chaDirectionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaDirectionCount;
					chaDirection = ReadUtils.read_TYPE_INT32(input);
					break;
				case 24:
					if (isCriticalBlowCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isCriticalBlowCount;
					isCriticalBlow = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 25:
					enemyChaArr.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.zudui.zudui4308.EnemyArray));
					break;
				case 26:
					if (chaTotalHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaTotalHpCount;
					chaTotalHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 27:
					if (chaTotalPowerCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaTotalPowerCount;
					chaTotalPower = ReadUtils.read_TYPE_INT32(input);
					break;
				case 28:
					if (powerEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++powerEffectIdCount;
					powerEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 29:
					if (chaNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaNameCount;
					chaName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 30:
					if (chaLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaLevelCount;
					chaLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
