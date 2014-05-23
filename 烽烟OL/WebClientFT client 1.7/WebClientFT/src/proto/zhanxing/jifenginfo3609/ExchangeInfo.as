package proto.zhanxing.jifenginfo3609 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanxing.XingYunBasicInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ExchangeInfo extends Message implements IExternalizable {
		private var xingYun_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXingYun():Boolean {
			return null != xingYun_;
		}
		public function set xingYun(value:proto.zhanxing.XingYunBasicInfo):void {
			xingYun_ = value;
		}
		public function get xingYun():proto.zhanxing.XingYunBasicInfo {
			return xingYun_;
		}
		private var jifengValue_:int;
		private var hasJifengValue_:Boolean = false;
		public function get hasJifengValue():Boolean {
			return hasJifengValue_;
		}
		public function set jifengValue(value:int):void {
			hasJifengValue_ = true;
			jifengValue_ = value;
		}
		public function get jifengValue():int {
			return jifengValue_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasXingYun) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, xingYun);
			}
			if (hasJifengValue) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, jifengValue);
			}
		}
		public function readExternal(input:IDataInput):void {
			var xingYunCount:uint = 0;
			var jifengValueCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (xingYunCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xingYunCount;
					xingYun = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xingYun);
					break;
				case 2:
					if (jifengValueCount != 0) {
						throw new IOError('Bad data format.');
					}
					++jifengValueCount;
					jifengValue = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
