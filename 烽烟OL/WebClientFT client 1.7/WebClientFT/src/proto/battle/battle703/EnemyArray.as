package proto.battle.battle703 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.battle.battle703.BuffInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class EnemyArray extends Message implements IExternalizable {
		private var enemyChaId_:int;
		private var hasEnemyChaId_:Boolean = false;
		public function get hasEnemyChaId():Boolean {
			return hasEnemyChaId_;
		}
		public function set enemyChaId(value:int):void {
			hasEnemyChaId_ = true;
			enemyChaId_ = value;
		}
		public function get enemyChaId():int {
			return enemyChaId_;
		}
		private var enemyBattleId_:int;
		private var hasEnemyBattleId_:Boolean = false;
		public function get hasEnemyBattleId():Boolean {
			return hasEnemyBattleId_;
		}
		public function set enemyBattleId(value:int):void {
			hasEnemyBattleId_ = true;
			enemyBattleId_ = value;
		}
		public function get enemyBattleId():int {
			return enemyBattleId_;
		}
		private var enemyActionId_:int;
		private var hasEnemyActionId_:Boolean = false;
		public function get hasEnemyActionId():Boolean {
			return hasEnemyActionId_;
		}
		public function set enemyActionId(value:int):void {
			hasEnemyActionId_ = true;
			enemyActionId_ = value;
		}
		public function get enemyActionId():int {
			return enemyActionId_;
		}
		private var enemyCounterHitActionId_:int;
		private var hasEnemyCounterHitActionId_:Boolean = false;
		public function get hasEnemyCounterHitActionId():Boolean {
			return hasEnemyCounterHitActionId_;
		}
		public function set enemyCounterHitActionId(value:int):void {
			hasEnemyCounterHitActionId_ = true;
			enemyCounterHitActionId_ = value;
		}
		public function get enemyCounterHitActionId():int {
			return enemyCounterHitActionId_;
		}
		private var enemyTxtEffectId_:int;
		private var hasEnemyTxtEffectId_:Boolean = false;
		public function get hasEnemyTxtEffectId():Boolean {
			return hasEnemyTxtEffectId_;
		}
		public function set enemyTxtEffectId(value:int):void {
			hasEnemyTxtEffectId_ = true;
			enemyTxtEffectId_ = value;
		}
		public function get enemyTxtEffectId():int {
			return enemyTxtEffectId_;
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
		private var chaEnemyAoeEffectId_:int;
		private var hasChaEnemyAoeEffectId_:Boolean = false;
		public function get hasChaEnemyAoeEffectId():Boolean {
			return hasChaEnemyAoeEffectId_;
		}
		public function set chaEnemyAoeEffectId(value:int):void {
			hasChaEnemyAoeEffectId_ = true;
			chaEnemyAoeEffectId_ = value;
		}
		public function get chaEnemyAoeEffectId():int {
			return chaEnemyAoeEffectId_;
		}
		[ArrayElementType("int")]
		public var enemyBuffArr:Array = [];
		[ArrayElementType("proto.battle.battle703.BuffInfo")]
		public var enemyBuffShowList:Array = [];
		private var enemyPowerUp_:int;
		private var hasEnemyPowerUp_:Boolean = false;
		public function get hasEnemyPowerUp():Boolean {
			return hasEnemyPowerUp_;
		}
		public function set enemyPowerUp(value:int):void {
			hasEnemyPowerUp_ = true;
			enemyPowerUp_ = value;
		}
		public function get enemyPowerUp():int {
			return enemyPowerUp_;
		}
		private var enemyCurrentPower_:int;
		private var hasEnemyCurrentPower_:Boolean = false;
		public function get hasEnemyCurrentPower():Boolean {
			return hasEnemyCurrentPower_;
		}
		public function set enemyCurrentPower(value:int):void {
			hasEnemyCurrentPower_ = true;
			enemyCurrentPower_ = value;
		}
		public function get enemyCurrentPower():int {
			return enemyCurrentPower_;
		}
		private var enemyChangeHp_:int;
		private var hasEnemyChangeHp_:Boolean = false;
		public function get hasEnemyChangeHp():Boolean {
			return hasEnemyChangeHp_;
		}
		public function set enemyChangeHp(value:int):void {
			hasEnemyChangeHp_ = true;
			enemyChangeHp_ = value;
		}
		public function get enemyChangeHp():int {
			return enemyChangeHp_;
		}
		private var enemyCurrentHp_:int;
		private var hasEnemyCurrentHp_:Boolean = false;
		public function get hasEnemyCurrentHp():Boolean {
			return hasEnemyCurrentHp_;
		}
		public function set enemyCurrentHp(value:int):void {
			hasEnemyCurrentHp_ = true;
			enemyCurrentHp_ = value;
		}
		public function get enemyCurrentHp():int {
			return enemyCurrentHp_;
		}
		private var enemyCounterHit_:int;
		private var hasEnemyCounterHit_:Boolean = false;
		public function get hasEnemyCounterHit():Boolean {
			return hasEnemyCounterHit_;
		}
		public function set enemyCounterHit(value:int):void {
			hasEnemyCounterHit_ = true;
			enemyCounterHit_ = value;
		}
		public function get enemyCounterHit():int {
			return enemyCounterHit_;
		}
		[ArrayElementType("int")]
		public var enemyStartPos:Array = [];
		[ArrayElementType("int")]
		public var enemyTargetPos:Array = [];
		private var enemyDirection_:int;
		private var hasEnemyDirection_:Boolean = false;
		public function get hasEnemyDirection():Boolean {
			return hasEnemyDirection_;
		}
		public function set enemyDirection(value:int):void {
			hasEnemyDirection_ = true;
			enemyDirection_ = value;
		}
		public function get enemyDirection():int {
			return enemyDirection_;
		}
		private var enemyProfessionType_:int;
		private var hasEnemyProfessionType_:Boolean = false;
		public function get hasEnemyProfessionType():Boolean {
			return hasEnemyProfessionType_;
		}
		public function set enemyProfessionType(value:int):void {
			hasEnemyProfessionType_ = true;
			enemyProfessionType_ = value;
		}
		public function get enemyProfessionType():int {
			return enemyProfessionType_;
		}
		private var enemyTotalHp_:int;
		private var hasEnemyTotalHp_:Boolean = false;
		public function get hasEnemyTotalHp():Boolean {
			return hasEnemyTotalHp_;
		}
		public function set enemyTotalHp(value:int):void {
			hasEnemyTotalHp_ = true;
			enemyTotalHp_ = value;
		}
		public function get enemyTotalHp():int {
			return enemyTotalHp_;
		}
		private var enemyTotalPower_:int;
		private var hasEnemyTotalPower_:Boolean = false;
		public function get hasEnemyTotalPower():Boolean {
			return hasEnemyTotalPower_;
		}
		public function set enemyTotalPower(value:int):void {
			hasEnemyTotalPower_ = true;
			enemyTotalPower_ = value;
		}
		public function get enemyTotalPower():int {
			return enemyTotalPower_;
		}
		private var enemyPowerEffectId_:int;
		private var hasEnemyPowerEffectId_:Boolean = false;
		public function get hasEnemyPowerEffectId():Boolean {
			return hasEnemyPowerEffectId_;
		}
		public function set enemyPowerEffectId(value:int):void {
			hasEnemyPowerEffectId_ = true;
			enemyPowerEffectId_ = value;
		}
		public function get enemyPowerEffectId():int {
			return enemyPowerEffectId_;
		}
		private var enemyChaName_:String;
		public function get hasEnemyChaName():Boolean {
			return null != enemyChaName_;
		}
		public function set enemyChaName(value:String):void {
			enemyChaName_ = value;
		}
		public function get enemyChaName():String {
			return enemyChaName_;
		}
		private var enemychaLevel_:int;
		private var hasEnemychaLevel_:Boolean = false;
		public function get hasEnemychaLevel():Boolean {
			return hasEnemychaLevel_;
		}
		public function set enemychaLevel(value:int):void {
			hasEnemychaLevel_ = true;
			enemychaLevel_ = value;
		}
		public function get enemychaLevel():int {
			return enemychaLevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasEnemyChaId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, enemyChaId);
			}
			if (hasEnemyBattleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, enemyBattleId);
			}
			if (hasEnemyActionId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, enemyActionId);
			}
			if (hasEnemyCounterHitActionId) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, enemyCounterHitActionId);
			}
			if (hasEnemyTxtEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, enemyTxtEffectId);
			}
			if (hasChaEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, chaEffectId);
			}
			if (hasChaEnemyEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, chaEnemyEffectId);
			}
			if (hasChaThrowEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, chaThrowEffectId);
			}
			if (hasChaEnemyAoeEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, chaEnemyAoeEffectId);
			}
			for (var enemyBuffArrIndex:uint = 0; enemyBuffArrIndex < enemyBuffArr.length; ++enemyBuffArrIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, enemyBuffArr[enemyBuffArrIndex]);
			}
			for (var enemyBuffShowListIndex:uint = 0; enemyBuffShowListIndex < enemyBuffShowList.length; ++enemyBuffShowListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_MESSAGE(output, enemyBuffShowList[enemyBuffShowListIndex]);
			}
			if (hasEnemyPowerUp) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, enemyPowerUp);
			}
			if (hasEnemyCurrentPower) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, enemyCurrentPower);
			}
			if (hasEnemyChangeHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 14);
				WriteUtils.write_TYPE_INT32(output, enemyChangeHp);
			}
			if (hasEnemyCurrentHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 15);
				WriteUtils.write_TYPE_INT32(output, enemyCurrentHp);
			}
			if (hasEnemyCounterHit) {
				WriteUtils.writeTag(output, WireType.VARINT, 16);
				WriteUtils.write_TYPE_INT32(output, enemyCounterHit);
			}
			for (var enemyStartPosIndex:uint = 0; enemyStartPosIndex < enemyStartPos.length; ++enemyStartPosIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 17);
				WriteUtils.write_TYPE_INT32(output, enemyStartPos[enemyStartPosIndex]);
			}
			for (var enemyTargetPosIndex:uint = 0; enemyTargetPosIndex < enemyTargetPos.length; ++enemyTargetPosIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 18);
				WriteUtils.write_TYPE_INT32(output, enemyTargetPos[enemyTargetPosIndex]);
			}
			if (hasEnemyDirection) {
				WriteUtils.writeTag(output, WireType.VARINT, 19);
				WriteUtils.write_TYPE_INT32(output, enemyDirection);
			}
			if (hasEnemyProfessionType) {
				WriteUtils.writeTag(output, WireType.VARINT, 20);
				WriteUtils.write_TYPE_INT32(output, enemyProfessionType);
			}
			if (hasEnemyTotalHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 21);
				WriteUtils.write_TYPE_INT32(output, enemyTotalHp);
			}
			if (hasEnemyTotalPower) {
				WriteUtils.writeTag(output, WireType.VARINT, 22);
				WriteUtils.write_TYPE_INT32(output, enemyTotalPower);
			}
			if (hasEnemyPowerEffectId) {
				WriteUtils.writeTag(output, WireType.VARINT, 23);
				WriteUtils.write_TYPE_INT32(output, enemyPowerEffectId);
			}
			if (hasEnemyChaName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 29);
				WriteUtils.write_TYPE_STRING(output, enemyChaName);
			}
			if (hasEnemychaLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 30);
				WriteUtils.write_TYPE_INT32(output, enemychaLevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var enemyChaIdCount:uint = 0;
			var enemyBattleIdCount:uint = 0;
			var enemyActionIdCount:uint = 0;
			var enemyCounterHitActionIdCount:uint = 0;
			var enemyTxtEffectIdCount:uint = 0;
			var chaEffectIdCount:uint = 0;
			var chaEnemyEffectIdCount:uint = 0;
			var chaThrowEffectIdCount:uint = 0;
			var chaEnemyAoeEffectIdCount:uint = 0;
			var enemyPowerUpCount:uint = 0;
			var enemyCurrentPowerCount:uint = 0;
			var enemyChangeHpCount:uint = 0;
			var enemyCurrentHpCount:uint = 0;
			var enemyCounterHitCount:uint = 0;
			var enemyDirectionCount:uint = 0;
			var enemyProfessionTypeCount:uint = 0;
			var enemyTotalHpCount:uint = 0;
			var enemyTotalPowerCount:uint = 0;
			var enemyPowerEffectIdCount:uint = 0;
			var enemyChaNameCount:uint = 0;
			var enemychaLevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (enemyChaIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyChaIdCount;
					enemyChaId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (enemyBattleIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyBattleIdCount;
					enemyBattleId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (enemyActionIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyActionIdCount;
					enemyActionId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (enemyCounterHitActionIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyCounterHitActionIdCount;
					enemyCounterHitActionId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (enemyTxtEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyTxtEffectIdCount;
					enemyTxtEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (chaEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaEffectIdCount;
					chaEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (chaEnemyEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaEnemyEffectIdCount;
					chaEnemyEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (chaThrowEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaThrowEffectIdCount;
					chaThrowEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (chaEnemyAoeEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaEnemyAoeEffectIdCount;
					chaEnemyAoeEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, enemyBuffArr);
					break;
					}
					enemyBuffArr.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 11:
					enemyBuffShowList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.battle.battle703.BuffInfo));
					break;
				case 12:
					if (enemyPowerUpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyPowerUpCount;
					enemyPowerUp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 13:
					if (enemyCurrentPowerCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyCurrentPowerCount;
					enemyCurrentPower = ReadUtils.read_TYPE_INT32(input);
					break;
				case 14:
					if (enemyChangeHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyChangeHpCount;
					enemyChangeHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 15:
					if (enemyCurrentHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyCurrentHpCount;
					enemyCurrentHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 16:
					if (enemyCounterHitCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyCounterHitCount;
					enemyCounterHit = ReadUtils.read_TYPE_INT32(input);
					break;
				case 17:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, enemyStartPos);
					break;
					}
					enemyStartPos.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 18:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, enemyTargetPos);
					break;
					}
					enemyTargetPos.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 19:
					if (enemyDirectionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyDirectionCount;
					enemyDirection = ReadUtils.read_TYPE_INT32(input);
					break;
				case 20:
					if (enemyProfessionTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyProfessionTypeCount;
					enemyProfessionType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 21:
					if (enemyTotalHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyTotalHpCount;
					enemyTotalHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 22:
					if (enemyTotalPowerCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyTotalPowerCount;
					enemyTotalPower = ReadUtils.read_TYPE_INT32(input);
					break;
				case 23:
					if (enemyPowerEffectIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyPowerEffectIdCount;
					enemyPowerEffectId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 29:
					if (enemyChaNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemyChaNameCount;
					enemyChaName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 30:
					if (enemychaLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enemychaLevelCount;
					enemychaLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
