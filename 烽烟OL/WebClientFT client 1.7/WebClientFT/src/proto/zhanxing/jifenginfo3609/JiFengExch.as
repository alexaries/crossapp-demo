package proto.zhanxing.jifenginfo3609 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanxing.jifenginfo3609.ExchangeInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class JiFengExch extends Message implements IExternalizable {
		[ArrayElementType("proto.zhanxing.jifenginfo3609.ExchangeInfo")]
		public var exchInfo:Array = [];
		private var jiFengTotal_:int;
		private var hasJiFengTotal_:Boolean = false;
		public function get hasJiFengTotal():Boolean {
			return hasJiFengTotal_;
		}
		public function set jiFengTotal(value:int):void {
			hasJiFengTotal_ = true;
			jiFengTotal_ = value;
		}
		public function get jiFengTotal():int {
			return jiFengTotal_;
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
		private var totalpage_:int;
		private var hasTotalpage_:Boolean = false;
		public function get hasTotalpage():Boolean {
			return hasTotalpage_;
		}
		public function set totalpage(value:int):void {
			hasTotalpage_ = true;
			totalpage_ = value;
		}
		public function get totalpage():int {
			return totalpage_;
		}
		public function writeExternal(output:IDataOutput):void {
			for (var exchInfoIndex:uint = 0; exchInfoIndex < exchInfo.length; ++exchInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, exchInfo[exchInfoIndex]);
			}
			if (hasJiFengTotal) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, jiFengTotal);
			}
			if (hasCurpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curpage);
			}
			if (hasTotalpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, totalpage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var jiFengTotalCount:uint = 0;
			var curpageCount:uint = 0;
			var totalpageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					exchInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.zhanxing.jifenginfo3609.ExchangeInfo));
					break;
				case 2:
					if (jiFengTotalCount != 0) {
						throw new IOError('Bad data format.');
					}
					++jiFengTotalCount;
					jiFengTotal = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curpageCount;
					curpage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (totalpageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++totalpageCount;
					totalpage = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
