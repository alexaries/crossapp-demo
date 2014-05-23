package proto.shenchi.shenchi3400 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.shenchi.shenchi3400.ShenGeInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ShenChiInfo extends Message implements IExternalizable {
		private var douqi_:int;
		private var hasDouqi_:Boolean = false;
		public function get hasDouqi():Boolean {
			return hasDouqi_;
		}
		public function set douqi(value:int):void {
			hasDouqi_ = true;
			douqi_ = value;
		}
		public function get douqi():int {
			return douqi_;
		}
		private var des_:String;
		public function get hasDes():Boolean {
			return null != des_;
		}
		public function set des(value:String):void {
			des_ = value;
		}
		public function get des():String {
			return des_;
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
		private var nextBtnFlag_:Boolean;
		private var hasNextBtnFlag_:Boolean = false;
		public function get hasNextBtnFlag():Boolean {
			return hasNextBtnFlag_;
		}
		public function set nextBtnFlag(value:Boolean):void {
			hasNextBtnFlag_ = true;
			nextBtnFlag_ = value;
		}
		public function get nextBtnFlag():Boolean {
			return nextBtnFlag_;
		}
		[ArrayElementType("proto.shenchi.shenchi3400.ShenGeInfo")]
		public var shenGeList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasDouqi) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, douqi);
			}
			if (hasDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, des);
			}
			if (hasCurPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curPage);
			}
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
			if (hasNextBtnFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_BOOL(output, nextBtnFlag);
			}
			for (var shenGeListIndex:uint = 0; shenGeListIndex < shenGeList.length; ++shenGeListIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, shenGeList[shenGeListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var douqiCount:uint = 0;
			var desCount:uint = 0;
			var curPageCount:uint = 0;
			var maxPageCount:uint = 0;
			var nextBtnFlagCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (douqiCount != 0) {
						throw new IOError('Bad data format.');
					}
					++douqiCount;
					douqi = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (desCount != 0) {
						throw new IOError('Bad data format.');
					}
					++desCount;
					des = ReadUtils.read_TYPE_STRING(input);
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
				case 5:
					if (nextBtnFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nextBtnFlagCount;
					nextBtnFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 6:
					shenGeList.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.shenchi.shenchi3400.ShenGeInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
