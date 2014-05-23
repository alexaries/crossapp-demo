package proto.guanjue.guanjue3300 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetGuanJueInfoRequest extends Message implements IExternalizable {
		public var id:int;
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
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasCurpage) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, curpage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var curpageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
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
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
