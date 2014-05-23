package proto.ranking.ranking2002 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ranking.ranking2002.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MyScoreListInfo extends Message implements IExternalizable {
		private var score_:int;
		private var hasScore_:Boolean = false;
		public function get hasScore():Boolean {
			return hasScore_;
		}
		public function set score(value:int):void {
			hasScore_ = true;
			score_ = value;
		}
		public function get score():int {
			return score_;
		}
		private var itemsInfo_:proto.ranking.ranking2002.ItemsInfo;
		public function get hasItemsInfo():Boolean {
			return null != itemsInfo_;
		}
		public function set itemsInfo(value:proto.ranking.ranking2002.ItemsInfo):void {
			itemsInfo_ = value;
		}
		public function get itemsInfo():proto.ranking.ranking2002.ItemsInfo {
			return itemsInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasScore) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, score);
			}
			if (hasItemsInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, itemsInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var scoreCount:uint = 0;
			var itemsInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (scoreCount != 0) {
						throw new IOError('Bad data format.');
					}
					++scoreCount;
					score = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (itemsInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemsInfoCount;
					itemsInfo = new proto.ranking.ranking2002.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemsInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
