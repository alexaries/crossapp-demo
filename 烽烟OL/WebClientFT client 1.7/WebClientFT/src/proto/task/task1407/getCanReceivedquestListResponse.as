package proto.task.task1407 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.task.task1407.responseData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class getCanReceivedquestListResponse extends Message implements IExternalizable {
		private var data_:proto.task.task1407.responseData;
		public function get hasData():Boolean {
			return null != data_;
		}
		public function set data(value:proto.task.task1407.responseData):void {
			data_ = value;
		}
		public function get data():proto.task.task1407.responseData {
			return data_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasData) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, data);
			}
		}
		public function readExternal(input:IDataInput):void {
			var dataCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (dataCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dataCount;
					data = new proto.task.task1407.responseData;
					ReadUtils.read_TYPE_MESSAGE(input, data);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
