package proto.corps.corps1317 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.corps.corps1317.AppliListBaseInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class AppliListInfo extends Message implements IExternalizable {
		[ArrayElementType("proto.corps.corps1317.AppliListBaseInfo")]
		public var appliListBaseInfo:Array = [];
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
		private var levelrequired_:int;
		private var hasLevelrequired_:Boolean = false;
		public function get hasLevelrequired():Boolean {
			return hasLevelrequired_;
		}
		public function set levelrequired(value:int):void {
			hasLevelrequired_ = true;
			levelrequired_ = value;
		}
		public function get levelrequired():int {
			return levelrequired_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var appliListBaseInfoIndex:uint = 0; appliListBaseInfoIndex < appliListBaseInfo.length; ++appliListBaseInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, appliListBaseInfo[appliListBaseInfoIndex]);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
			if (hasLevelrequired) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, levelrequired);
			}
		}
		public function readExternal(input:IDataInput):void {
			var curPageCount:uint = 0;
			var maxPageCount:uint = 0;
			var levelrequiredCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					appliListBaseInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.corps.corps1317.AppliListBaseInfo));
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
					if (levelrequiredCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelrequiredCount;
					levelrequired = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
