package proto.shop.shop206 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.ItemsInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PackageInfo extends Message implements IExternalizable {
		private var itemInfo_:proto.ItemsInfo;
		public function get hasItemInfo():Boolean {
			return null != itemInfo_;
		}
		public function set itemInfo(value:proto.ItemsInfo):void {
			itemInfo_ = value;
		}
		public function get itemInfo():proto.ItemsInfo {
			return itemInfo_;
		}
		private var remainTime_:Int64;
		public function get hasRemainTime():Boolean {
			return null != remainTime_;
		}
		public function set remainTime(value:Int64):void {
			remainTime_ = value;
		}
		public function get remainTime():Int64 {
			return remainTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasItemInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, itemInfo);
			}
			if (hasRemainTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT64(output, remainTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var itemInfoCount:uint = 0;
			var remainTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (itemInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++itemInfoCount;
					itemInfo = new proto.ItemsInfo;
					ReadUtils.read_TYPE_MESSAGE(input, itemInfo);
					break;
				case 2:
					if (remainTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainTimeCount;
					remainTime = ReadUtils.read_TYPE_INT64(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
