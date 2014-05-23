package proto.battle.battle712 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.battle.battle712.initBattleData;
	import proto.battle.battle712.FightData;
	import proto.battle.battle712.SettlementData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		public var battleResult:int;
		[ArrayElementType("proto.battle.battle712.initBattleData")]
		public var startData:Array = [];
		[ArrayElementType("proto.battle.battle712.FightData")]
		public var stepData:Array = [];
		public var centerX:int;
		public var centerY:int;
		[ArrayElementType("int")]
		public var rResArr:Array = [];
		public var setData:proto.battle.battle712.SettlementData;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, battleResult);
			for (var startDataIndex:uint = 0; startDataIndex < startData.length; ++startDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, startData[startDataIndex]);
			}
			for (var stepDataIndex:uint = 0; stepDataIndex < stepData.length; ++stepDataIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, stepData[stepDataIndex]);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, centerX);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, centerY);
			for (var rResArrIndex:uint = 0; rResArrIndex < rResArr.length; ++rResArrIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, rResArr[rResArrIndex]);
			}
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
			WriteUtils.write_TYPE_MESSAGE(output, setData);
		}
		public function readExternal(input:IDataInput):void {
			var battleResultCount:uint = 0;
			var centerXCount:uint = 0;
			var centerYCount:uint = 0;
			var setDataCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (battleResultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++battleResultCount;
					battleResult = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					startData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.battle.battle712.initBattleData));
					break;
				case 3:
					stepData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.battle.battle712.FightData));
					break;
				case 4:
					if (centerXCount != 0) {
						throw new IOError('Bad data format.');
					}
					++centerXCount;
					centerX = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (centerYCount != 0) {
						throw new IOError('Bad data format.');
					}
					++centerYCount;
					centerY = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, rResArr);
					break;
					}
					rResArr.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 7:
					if (setDataCount != 0) {
						throw new IOError('Bad data format.');
					}
					++setDataCount;
					setData = new proto.battle.battle712.SettlementData;
					ReadUtils.read_TYPE_MESSAGE(input, setData);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
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
			if (setDataCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
