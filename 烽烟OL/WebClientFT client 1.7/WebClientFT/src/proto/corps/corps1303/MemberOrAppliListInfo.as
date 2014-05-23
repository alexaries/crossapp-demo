package proto.corps.corps1303 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.corps.corps1303.MemberOrAppliListBaseInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MemberOrAppliListInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.corps.corps1303.MemberOrAppliListBaseInfo")]
		public var memberOrAppliListBaseInfo:Array = [];
		private var setType_:int;
		private var hasSetType_:Boolean = false;
		public function get hasSetType():Boolean {
			return hasSetType_;
		}
		public function set setType(value:int):void {
			hasSetType_ = true;
			setType_ = value;
		}
		public function get setType():int {
			return setType_;
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
		public function writeExternal(output:IDataOutput):void {
			for (var memberOrAppliListBaseInfoIndex:uint = 0; memberOrAppliListBaseInfoIndex < memberOrAppliListBaseInfo.length; ++memberOrAppliListBaseInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, memberOrAppliListBaseInfo[memberOrAppliListBaseInfoIndex]);
			}
			if (hasSetType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, setType);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var setTypeCount:uint = 0;
			var curPageCount:uint = 0;
			var maxPageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					memberOrAppliListBaseInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.corps.corps1303.MemberOrAppliListBaseInfo));
					break;
				case 2:
					if (setTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++setTypeCount;
					setType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPageCount;
					curPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (maxPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPageCount;
					maxPage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
