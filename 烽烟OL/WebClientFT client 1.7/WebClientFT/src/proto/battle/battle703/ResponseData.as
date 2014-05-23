package proto.battle.battle703 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.battle.battle703.FightData;
	import proto.battle.battle703.SettlementData;
	import proto.battle.battle703.InitBattleData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ResponseData extends Message implements IExternalizable {
		public var fightType:int;
		public var battleResult:int;
		[ArrayElementType("proto.battle.battle703.InitBattleData")]
		public var startData:Array = [];
		[ArrayElementType("proto.battle.battle703.FightData")]
		public var stepData:Array = [];
		[ArrayElementType("proto.battle.battle703.SettlementData")]
		public var setData:Array = [];
		public var centerX:int;
		public var centerY:int;
		[ArrayElementType("int")]
		public var rResArr:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, fightType);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, battleResult);
			for (var startDataIndex:uint = 0; startDataIndex < startData.length; ++startDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, startData[startDataIndex]);
			}
			for (var stepDataIndex:uint = 0; stepDataIndex < stepData.length; ++stepDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, stepData[stepDataIndex]);
			}
			for (var setDataIndex:uint = 0; setDataIndex < setData.length; ++setDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, setData[setDataIndex]);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 6);
			WriteUtils.write_TYPE_INT32(output, centerX);
			WriteUtils.writeTag(output, WireType.VARINT, 7);
			WriteUtils.write_TYPE_INT32(output, centerY);
			for (var rResArrIndex:uint = 0; rResArrIndex < rResArr.length; ++rResArrIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, rResArr[rResArrIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var fightTypeCount:uint = 0;
			var battleResultCount:uint = 0;
			var centerXCount:uint = 0;
			var centerYCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (fightTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fightTypeCount;
					fightType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (battleResultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++battleResultCount;
					battleResult = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					startData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.battle.battle703.InitBattleData));
					break;
				case 4:
					stepData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.battle.battle703.FightData));
					break;
				case 5:
					setData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.battle.battle703.SettlementData));
					break;
				case 6:
					if (centerXCount != 0) {
						throw new IOError('Bad data format.');
					}
					++centerXCount;
					centerX = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (centerYCount != 0) {
						throw new IOError('Bad data format.');
					}
					++centerYCount;
					centerY = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, rResArr);
					break;
					}
					rResArr.push(ReadUtils.read_TYPE_INT32(input));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (fightTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (battleResultCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (centerXCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (centerYCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
