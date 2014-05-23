package proto.zudui.zudui4308 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class initBattleData extends Message implements IExternalizable {
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
		[ArrayElementType("int")]
		public var chaPos:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasChaId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, chaId);
			}
			if (hasChaBattleId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, chaBattleId);
			}
			if (hasChaName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, chaName);
			}
			if (hasChaLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, chaLevel);
			}
			if (hasChaProfessionType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, chaProfessionType);
			}
			if (hasChaDirection) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, chaDirection);
			}
			if (hasChaCurrentHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, chaCurrentHp);
			}
			if (hasChaCurrentPower) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, chaCurrentPower);
			}
			if (hasChaTotalHp) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, chaTotalHp);
			}
			if (hasChaTotalPower) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, chaTotalPower);
			}
			for (var chaPosIndex:uint = 0; chaPosIndex < chaPos.length; ++chaPosIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, chaPos[chaPosIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var chaIdCount:uint = 0;
			var chaBattleIdCount:uint = 0;
			var chaNameCount:uint = 0;
			var chaLevelCount:uint = 0;
			var chaProfessionTypeCount:uint = 0;
			var chaDirectionCount:uint = 0;
			var chaCurrentHpCount:uint = 0;
			var chaCurrentPowerCount:uint = 0;
			var chaTotalHpCount:uint = 0;
			var chaTotalPowerCount:uint = 0;
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
					if (chaNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaNameCount;
					chaName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (chaLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaLevelCount;
					chaLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (chaProfessionTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaProfessionTypeCount;
					chaProfessionType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (chaDirectionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaDirectionCount;
					chaDirection = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (chaCurrentHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaCurrentHpCount;
					chaCurrentHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (chaCurrentPowerCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaCurrentPowerCount;
					chaCurrentPower = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (chaTotalHpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaTotalHpCount;
					chaTotalHp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (chaTotalPowerCount != 0) {
						throw new IOError('Bad data format.');
					}
					++chaTotalPowerCount;
					chaTotalPower = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, chaPos);
					break;
					}
					chaPos.push(ReadUtils.read_TYPE_INT32(input));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
