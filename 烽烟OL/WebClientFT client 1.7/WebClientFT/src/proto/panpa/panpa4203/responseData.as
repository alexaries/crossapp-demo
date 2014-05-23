package proto.panpa.panpa4203 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.panpa.panpa4203.initBattleData;
	import proto.panpa.panpa4203.FightData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		public var battleResult:int;
		[ArrayElementType("proto.panpa.panpa4203.initBattleData")]
		public var startData:Array = [];
		[ArrayElementType("proto.panpa.panpa4203.FightData")]
		public var stepData:Array = [];
		public var centerX:int;
		public var centerY:int;
		[ArrayElementType("int")]
		public var rResArr:Array = [];
		private var fightmsg_:String;
		public function get hasFightmsg():Boolean {
			return null != fightmsg_;
		}
		public function set fightmsg(value:String):void {
			fightmsg_ = value;
		}
		public function get fightmsg():String {
			return fightmsg_;
		}
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
			if (hasFightmsg) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, fightmsg);
			}
		}
		public function readExternal(input:IDataInput):void {
			var battleResultCount:uint = 0;
			var centerXCount:uint = 0;
			var centerYCount:uint = 0;
			var fightmsgCount:uint = 0;
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
					startData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.panpa.panpa4203.initBattleData));
					break;
				case 3:
					stepData.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.panpa.panpa4203.FightData));
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
					if (fightmsgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fightmsgCount;
					fightmsg = ReadUtils.read_TYPE_STRING(input);
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
		}
	}
}
