package proto.reward.reward2404 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.reward.reward2404.BattleInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BattleListInfo extends Message implements IExternalizable {
		private var rId_:int;
		private var hasRId_:Boolean = false;
		public function get hasRId():Boolean {
			return hasRId_;
		}
		public function set rId(value:int):void {
			hasRId_ = true;
			rId_ = value;
		}
		public function get rId():int {
			return rId_;
		}
		private var curPage_:int;
		private var hasCurPage_:Boolean = false;
		public function get hasCurPage():Boolean {
			return hasCurPage_;
		}
		public function set curPage(value:int):void {
			hasCurPage_ = true;
			curPage_ = value;
		}
		public function get curPage():int {
			return curPage_;
		}
		private var maxPage_:int;
		private var hasMaxPage_:Boolean = false;
		public function get hasMaxPage():Boolean {
			return hasMaxPage_;
		}
		public function set maxPage(value:int):void {
			hasMaxPage_ = true;
			maxPage_ = value;
		}
		public function get maxPage():int {
			return maxPage_;
		}
		[ArrayElementType("proto.reward.reward2404.BattleInfo")]
		public var battleInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasRId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, rId);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
			for (var battleInfoIndex:uint = 0; battleInfoIndex < battleInfo.length; ++battleInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, battleInfo[battleInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var rIdCount:uint = 0;
			var curPageCount:uint = 0;
			var maxPageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (rIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rIdCount;
					rId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (maxPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPageCount;
					maxPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					battleInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.reward.reward2404.BattleInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
