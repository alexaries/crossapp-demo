package proto.zhanyi.GetNowZhanYiInfo4500 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiResponseData;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetNowZhanYiInfoResponse extends Message implements IExternalizable {
		public var result:Boolean;
		public var message:String;
		private var data_:proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiResponseData;
		public function get hasData():Boolean {
			return null != data_;
		}
		public function set data(value:proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiResponseData):void {
			data_ = value;
		}
		public function get data():proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiResponseData {
			return data_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, message);
			if (hasData) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, data);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var dataCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (dataCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dataCount;
					data = new proto.zhanyi.GetNowZhanYiInfo4500.ZhanyiResponseData;
					ReadUtils.read_TYPE_MESSAGE(input, data);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (resultCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (messageCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
