package proto.blacksmith.blacksmith2109 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.blacksmith.blacksmith2109.QhItemInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class StrengthenInfo extends Message implements IExternalizable {
		private var nowPage_:int;
		private var hasNowPage_:Boolean = false;
		public function get hasNowPage():Boolean {
			return hasNowPage_;
		}
		public function set nowPage(value:int):void {
			hasNowPage_ = true;
			nowPage_ = value;
		}
		public function get nowPage():int {
			return nowPage_;
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
		[ArrayElementType("proto.blacksmith.blacksmith2109.QhItemInfo")]
		public var strItemList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasNowPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, nowPage);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
			for (var strItemListIndex:uint = 0; strItemListIndex < strItemList.length; ++strItemListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, strItemList[strItemListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var nowPageCount:uint = 0;
			var maxPageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (nowPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nowPageCount;
					nowPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (maxPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPageCount;
					maxPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					strItemList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.blacksmith.blacksmith2109.QhItemInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
