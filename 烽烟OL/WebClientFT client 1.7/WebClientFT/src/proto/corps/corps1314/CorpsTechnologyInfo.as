package proto.corps.corps1314 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.corps.corps1314.TechnologyInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CorpsTechnologyInfo extends Message implements IExternalizable {
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
		[ArrayElementType("proto.corps.corps1314.TechnologyInfo")]
		public var technologyInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
			for (var technologyInfoIndex:uint = 0; technologyInfoIndex < technologyInfo.length; ++technologyInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, technologyInfo[technologyInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var curPageCount:uint = 0;
			var maxPageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (maxPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPageCount;
					maxPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					technologyInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.corps.corps1314.TechnologyInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
