package proto.mail.mail503 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class dataPacket extends Message implements IExternalizable {
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
		private var setTypeResponse_:int;
		private var hasSetTypeResponse_:Boolean = false;
		public function get hasSetTypeResponse():Boolean {
			return hasSetTypeResponse_;
		}
		public function set setTypeResponse(value:int):void {
			hasSetTypeResponse_ = true;
			setTypeResponse_ = value;
		}
		public function get setTypeResponse():int {
			return setTypeResponse_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMaxPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, maxPage);
			}
			if (hasSetTypeResponse) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, setTypeResponse);
			}
		}
		public function readExternal(input:IDataInput):void {
			var maxPageCount:uint = 0;
			var setTypeResponseCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (maxPageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPageCount;
					maxPage = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (setTypeResponseCount != 0) {
						throw new IOError('Bad data format.');
					}
					++setTypeResponseCount;
					setTypeResponse = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
