package proto.groupHall.groupHall1801 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupHall.groupHall1801.EveryGroupInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GroupInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.groupHall.groupHall1801.EveryGroupInfo")]
		public var everyGroupInfo:Array = [];
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
		public function writeExternal(output:IDataOutput):void {
			for (var everyGroupInfoIndex:uint = 0; everyGroupInfoIndex < everyGroupInfo.length; ++everyGroupInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, everyGroupInfo[everyGroupInfoIndex]);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var maxPageCount:uint = 0;
			var curPageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					everyGroupInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.groupHall.groupHall1801.EveryGroupInfo));
					break;
				case 2:
					if (maxPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPageCount;
					maxPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
