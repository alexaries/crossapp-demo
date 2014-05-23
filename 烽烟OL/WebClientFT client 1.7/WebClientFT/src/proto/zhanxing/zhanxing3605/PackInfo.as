package proto.zhanxing.zhanxing3605 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanxing.XingYunBasicInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PackInfo extends Message implements IExternalizable {
		private var postion_:int;
		private var hasPostion_:Boolean = false;
		public function get hasPostion():Boolean {
			return hasPostion_;
		}
		public function set postion(value:int):void {
			hasPostion_ = true;
			postion_ = value;
		}
		public function get postion():int {
			return postion_;
		}
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
		public function writeExternal(output:IDataOutput):void {
			if (hasPostion) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, postion);
			}
			if (hasXyInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, xyInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var postionCount:uint = 0;
			var xyInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (postionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++postionCount;
					postion = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (xyInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xyInfoCount;
					xyInfo = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
