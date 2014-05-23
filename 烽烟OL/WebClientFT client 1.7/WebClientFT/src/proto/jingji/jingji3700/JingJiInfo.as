package proto.jingji.jingji3700 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.jingji.jingji3700.BattleInfo;
	import proto.jingji.jingji3700.DiRenInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class JingJiInfo extends Message implements IExternalizable {
		private var rankInfo_:String;
		public function get hasRankInfo():Boolean {
			return null != rankInfo_;
		}
		public function set rankInfo(value:String):void {
			rankInfo_ = value;
		}
		public function get rankInfo():String {
			return rankInfo_;
		}
		private var jifen_:int;
		private var hasJifen_:Boolean = false;
		public function get hasJifen():Boolean {
			return hasJifen_;
		}
		public function set jifen(value:int):void {
			hasJifen_ = true;
			jifen_ = value;
		}
		public function get jifen():int {
			return jifen_;
		}
		private var weiwang_:int;
		private var hasWeiwang_:Boolean = false;
		public function get hasWeiwang():Boolean {
			return hasWeiwang_;
		}
		public function set weiwang(value:int):void {
			hasWeiwang_ = true;
			weiwang_ = value;
		}
		public function get weiwang():int {
			return weiwang_;
		}
		private var rank_:int;
		private var hasRank_:Boolean = false;
		public function get hasRank():Boolean {
			return hasRank_;
		}
		public function set rank(value:int):void {
			hasRank_ = true;
			rank_ = value;
		}
		public function get rank():int {
			return rank_;
		}
		private var liansheng_:int;
		private var hasLiansheng_:Boolean = false;
		public function get hasLiansheng():Boolean {
			return hasLiansheng_;
		}
		public function set liansheng(value:int):void {
			hasLiansheng_ = true;
			liansheng_ = value;
		}
		public function get liansheng():int {
			return liansheng_;
		}
		private var tzCount_:int;
		private var hasTzCount_:Boolean = false;
		public function get hasTzCount():Boolean {
			return hasTzCount_;
		}
		public function set tzCount(value:int):void {
			hasTzCount_ = true;
			tzCount_ = value;
		}
		public function get tzCount():int {
			return tzCount_;
		}
		[ArrayElementType("proto.jingji.jingji3700.DiRenInfo")]
		public var drList:Array = [];
		[ArrayElementType("proto.jingji.jingji3700.BattleInfo")]
		public var battleInfoList:Array = [];
		private var addCount_:int;
		private var hasAddCount_:Boolean = false;
		public function get hasAddCount():Boolean {
			return hasAddCount_;
		}
		public function set addCount(value:int):void {
			hasAddCount_ = true;
			addCount_ = value;
		}
		public function get addCount():int {
			return addCount_;
		}
		private var reqCoin_:int;
		private var hasReqCoin_:Boolean = false;
		public function get hasReqCoin():Boolean {
			return hasReqCoin_;
		}
		public function set reqCoin(value:int):void {
			hasReqCoin_ = true;
			reqCoin_ = value;
		}
		public function get reqCoin():int {
			return reqCoin_;
		}
		private var obtainTime_:int;
		private var hasObtainTime_:Boolean = false;
		public function get hasObtainTime():Boolean {
			return hasObtainTime_;
		}
		public function set obtainTime(value:int):void {
			hasObtainTime_ = true;
			obtainTime_ = value;
		}
		public function get obtainTime():int {
			return obtainTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRankInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, rankInfo);
			}
			if (hasJifen) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, jifen);
			}
			if (hasWeiwang) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, weiwang);
			}
			if (hasRank) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, rank);
			}
			if (hasLiansheng) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, liansheng);
			}
			if (hasTzCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, tzCount);
			}
			for (var drListIndex:uint = 0; drListIndex < drList.length; ++drListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_MESSAGE(output, drList[drListIndex]);
			}
			for (var battleInfoListIndex:uint = 0; battleInfoListIndex < battleInfoList.length; ++battleInfoListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_MESSAGE(output, battleInfoList[battleInfoListIndex]);
			}
			if (hasAddCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, addCount);
			}
			if (hasReqCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, reqCoin);
			}
			if (hasObtainTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, obtainTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var rankInfoCount:uint = 0;
			var jifenCount:uint = 0;
			var weiwangCount:uint = 0;
			var rankCount:uint = 0;
			var lianshengCount:uint = 0;
			var tzCountCount:uint = 0;
			var addCountCount:uint = 0;
			var reqCoinCount:uint = 0;
			var obtainTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (rankInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rankInfoCount;
					rankInfo = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (jifenCount != 0) {
						throw new IOError('Bad data format.');
					}
					++jifenCount;
					jifen = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (weiwangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++weiwangCount;
					weiwang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (rankCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rankCount;
					rank = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (lianshengCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lianshengCount;
					liansheng = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (tzCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tzCountCount;
					tzCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					drList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.jingji.jingji3700.DiRenInfo));
					break;
				case 8:
					battleInfoList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.jingji.jingji3700.BattleInfo));
					break;
				case 9:
					if (addCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addCountCount;
					addCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (reqCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reqCoinCount;
					reqCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (obtainTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++obtainTimeCount;
					obtainTime = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
