package proto.ranking.ranking2001 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ranking.ranking2001.RankingInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RankingListInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.ranking.ranking2001.RankingInfo")]
		public var rankingInfo:Array = [];
		private var myRanking_:String;
		public function get hasMyRanking():Boolean {
			return null != myRanking_;
		}
		public function set myRanking(value:String):void {
			myRanking_ = value;
		}
		public function get myRanking():String {
			return myRanking_;
		}
		private var refreshTime_:String;
		public function get hasRefreshTime():Boolean {
			return null != refreshTime_;
		}
		public function set refreshTime(value:String):void {
			refreshTime_ = value;
		}
		public function get refreshTime():String {
			return refreshTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var rankingInfoIndex:uint = 0; rankingInfoIndex < rankingInfo.length; ++rankingInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, rankingInfo[rankingInfoIndex]);
			}
			if (hasMyRanking) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, myRanking);
			}
			if (hasRefreshTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, refreshTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var myRankingCount:uint = 0;
			var refreshTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					rankingInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.ranking.ranking2001.RankingInfo));
					break;
				case 2:
					if (myRankingCount != 0) {
						throw new IOError('Bad data format.');
					}
					++myRankingCount;
					myRanking = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (refreshTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++refreshTimeCount;
					refreshTime = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
