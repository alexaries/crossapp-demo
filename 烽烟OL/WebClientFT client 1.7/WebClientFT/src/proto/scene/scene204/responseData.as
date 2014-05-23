package proto.scene.scene204 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.scene204.PackageInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		private var packCategory_:int;
		private var hasPackCategory_:Boolean = false;
		public function get hasPackCategory():Boolean {
			return hasPackCategory_;
		}
		public function set packCategory(value:int):void {
			hasPackCategory_ = true;
			packCategory_ = value;
		}
		public function get packCategory():int {
			return packCategory_;
		}
		private var packageSize_:int;
		private var hasPackageSize_:Boolean = false;
		public function get hasPackageSize():Boolean {
			return hasPackageSize_;
		}
		public function set packageSize(value:int):void {
			hasPackageSize_ = true;
			packageSize_ = value;
		}
		public function get packageSize():int {
			return packageSize_;
		}
		private var curpage_:int;
		private var hasCurpage_:Boolean = false;
		public function get hasCurpage():Boolean {
			return hasCurpage_;
		}
		public function set curpage(value:int):void {
			hasCurpage_ = true;
			curpage_ = value;
		}
		public function get curpage():int {
			return curpage_;
		}
		private var maxpage_:int;
		private var hasMaxpage_:Boolean = false;
		public function get hasMaxpage():Boolean {
			return hasMaxpage_;
		}
		public function set maxpage(value:int):void {
			hasMaxpage_ = true;
			maxpage_ = value;
		}
		public function get maxpage():int {
			return maxpage_;
		}
		private var totalsize_:int;
		private var hasTotalsize_:Boolean = false;
		public function get hasTotalsize():Boolean {
			return hasTotalsize_;
		}
		public function set totalsize(value:int):void {
			hasTotalsize_ = true;
			totalsize_ = value;
		}
		public function get totalsize():int {
			return totalsize_;
		}
		[ArrayElementType("proto.scene.scene204.PackageInfo")]
		public var packageItemInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasPackCategory) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, packCategory);
			}
			if (hasPackageSize) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, packageSize);
			}
			if (hasCurpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curpage);
			}
			if (hasMaxpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, maxpage);
			}
			if (hasTotalsize) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, totalsize);
			}
			for (var packageItemInfoIndex:uint = 0; packageItemInfoIndex < packageItemInfo.length; ++packageItemInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, packageItemInfo[packageItemInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var packCategoryCount:uint = 0;
			var packageSizeCount:uint = 0;
			var curpageCount:uint = 0;
			var maxpageCount:uint = 0;
			var totalsizeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (packCategoryCount != 0) {
						throw new IOError('Bad data format.');
					}
					++packCategoryCount;
					packCategory = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (packageSizeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++packageSizeCount;
					packageSize = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (maxpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxpageCount;
					maxpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (totalsizeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++totalsizeCount;
					totalsize = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					packageItemInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.scene204.PackageInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
