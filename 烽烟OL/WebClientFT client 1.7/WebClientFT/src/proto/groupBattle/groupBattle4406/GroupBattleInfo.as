package proto.groupBattle.groupBattle4406 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupBattle.groupBattle4406.BattleInfo;
	import proto.groupBattle.groupBattle4406.GroupInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GroupBattleInfo extends Message implements IExternalizable {
		private var roundCount_:int;
		private var hasRoundCount_:Boolean = false;
		public function get hasRoundCount():Boolean {
			return hasRoundCount_;
		}
		public function set roundCount(value:int):void {
			hasRoundCount_ = true;
			roundCount_ = value;
		}
		public function get roundCount():int {
			return roundCount_;
		}
		private var remainTime_:int;
		private var hasRemainTime_:Boolean = false;
		public function get hasRemainTime():Boolean {
			return hasRemainTime_;
		}
		public function set remainTime(value:int):void {
			hasRemainTime_ = true;
			remainTime_ = value;
		}
		public function get remainTime():int {
			return remainTime_;
		}
		private var jishaCount_:int;
		private var hasJishaCount_:Boolean = false;
		public function get hasJishaCount():Boolean {
			return hasJishaCount_;
		}
		public function set jishaCount(value:int):void {
			hasJishaCount_ = true;
			jishaCount_ = value;
		}
		public function get jishaCount():int {
			return jishaCount_;
		}
		private var obtainCoin_:int;
		private var hasObtainCoin_:Boolean = false;
		public function get hasObtainCoin():Boolean {
			return hasObtainCoin_;
		}
		public function set obtainCoin(value:int):void {
			hasObtainCoin_ = true;
			obtainCoin_ = value;
		}
		public function get obtainCoin():int {
			return obtainCoin_;
		}
		private var failCount_:int;
		private var hasFailCount_:Boolean = false;
		public function get hasFailCount():Boolean {
			return hasFailCount_;
		}
		public function set failCount(value:int):void {
			hasFailCount_ = true;
			failCount_ = value;
		}
		public function get failCount():int {
			return failCount_;
		}
		private var obtainSw_:int;
		private var hasObtainSw_:Boolean = false;
		public function get hasObtainSw():Boolean {
			return hasObtainSw_;
		}
		public function set obtainSw(value:int):void {
			hasObtainSw_ = true;
			obtainSw_ = value;
		}
		public function get obtainSw():int {
			return obtainSw_;
		}
		[ArrayElementType("proto.groupBattle.groupBattle4406.BattleInfo")]
		public var battleInfoList:Array = [];
		private var group1Info_:proto.groupBattle.groupBattle4406.GroupInfo;
		public function get hasGroup1Info():Boolean {
			return null != group1Info_;
		}
		public function set group1Info(value:proto.groupBattle.groupBattle4406.GroupInfo):void {
			group1Info_ = value;
		}
		public function get group1Info():proto.groupBattle.groupBattle4406.GroupInfo {
			return group1Info_;
		}
		private var group2Info_:proto.groupBattle.groupBattle4406.GroupInfo;
		public function get hasGroup2Info():Boolean {
			return null != group2Info_;
		}
		public function set group2Info(value:proto.groupBattle.groupBattle4406.GroupInfo):void {
			group2Info_ = value;
		}
		public function get group2Info():proto.groupBattle.groupBattle4406.GroupInfo {
			return group2Info_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRoundCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, roundCount);
			}
			if (hasRemainTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, remainTime);
			}
			if (hasJishaCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, jishaCount);
			}
			if (hasObtainCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, obtainCoin);
			}
			if (hasFailCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, failCount);
			}
			if (hasObtainSw) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, obtainSw);
			}
			for (var battleInfoListIndex:uint = 0; battleInfoListIndex < battleInfoList.length; ++battleInfoListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_MESSAGE(output, battleInfoList[battleInfoListIndex]);
			}
			if (hasGroup1Info) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_MESSAGE(output, group1Info);
			}
			if (hasGroup2Info) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_MESSAGE(output, group2Info);
			}
		}
		public function readExternal(input:IDataInput):void {
			var roundCountCount:uint = 0;
			var remainTimeCount:uint = 0;
			var jishaCountCount:uint = 0;
			var obtainCoinCount:uint = 0;
			var failCountCount:uint = 0;
			var obtainSwCount:uint = 0;
			var group1InfoCount:uint = 0;
			var group2InfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (roundCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++roundCountCount;
					roundCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (remainTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainTimeCount;
					remainTime = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (jishaCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++jishaCountCount;
					jishaCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (obtainCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++obtainCoinCount;
					obtainCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (failCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++failCountCount;
					failCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (obtainSwCount != 0) {
						throw new IOError('Bad data format.');
					}
					++obtainSwCount;
					obtainSw = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					battleInfoList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupBattle.groupBattle4406.BattleInfo));
					break;
				case 8:
					if (group1InfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++group1InfoCount;
					group1Info = new proto.groupBattle.groupBattle4406.GroupInfo;
					ReadUtils.read_TYPE_MESSAGE(input, group1Info);
					break;
				case 9:
					if (group2InfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++group2InfoCount;
					group2Info = new proto.groupBattle.groupBattle4406.GroupInfo;
					ReadUtils.read_TYPE_MESSAGE(input, group2Info);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
