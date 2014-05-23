package proto.zhanxing.zhanxing3603 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanxing.XingYunBasicInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class YJXingYunInfo extends Message implements IExternalizable {
		private var xyInfo_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXyInfo():Boolean {
			return null != xyInfo_;
		}
		public function set xyInfo(value:proto.zhanxing.XingYunBasicInfo):void {
			xyInfo_ = value;
		}
		public function get xyInfo():proto.zhanxing.XingYunBasicInfo {
			return xyInfo_;
		}
		private var showIndex_:int;
		private var hasShowIndex_:Boolean = false;
		public function get hasShowIndex():Boolean {
			return hasShowIndex_;
		}
		public function set showIndex(value:int):void {
			hasShowIndex_ = true;
			showIndex_ = value;
		}
		public function get showIndex():int {
			return showIndex_;
		}
		private var maxCount_:int;
		private var hasMaxCount_:Boolean = false;
		public function get hasMaxCount():Boolean {
			return hasMaxCount_;
		}
		public function set maxCount(value:int):void {
			hasMaxCount_ = true;
			maxCount_ = value;
		}
		public function get maxCount():int {
			return maxCount_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasXyInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, xyInfo);
			}
			if (hasShowIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, showIndex);
			}
			if (hasMaxCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, maxCount);
			}
		}
		public function readExternal(input:IDataInput):void {
			var xyInfoCount:uint = 0;
			var showIndexCount:uint = 0;
			var maxCountCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (xyInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xyInfoCount;
					xyInfo = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyInfo);
					break;
				case 2:
					if (showIndexCount != 0) {
						throw new IOError('Bad data format.');
					}
					++showIndexCount;
					showIndex = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (maxCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxCountCount;
					maxCount = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
