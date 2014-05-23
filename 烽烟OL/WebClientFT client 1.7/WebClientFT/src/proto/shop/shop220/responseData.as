package proto.shop.shop220 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		private var packageType_:int;
		private var hasPackageType_:Boolean = false;
		public function get hasPackageType():Boolean {
			return hasPackageType_;
		}
		public function set packageType(value:int):void {
			hasPackageType_ = true;
			packageType_ = value;
		}
		public function get packageType():int {
			return packageType_;
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
		public function writeExternal(output:IDataOutput):void {
			if (hasPackageType) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, packageType);
			}
			if (hasCurpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, curpage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var packageTypeCount:uint = 0;
			var curpageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (packageTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++packageTypeCount;
					packageType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
