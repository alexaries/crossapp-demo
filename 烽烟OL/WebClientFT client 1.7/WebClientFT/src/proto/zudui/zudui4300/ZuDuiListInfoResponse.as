package proto.zudui.zudui4300 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zudui.zudui4300.ZuDuiInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ZuDuiListInfoResponse extends Message implements IExternalizable {
		private var message_:String;
		public function get hasMessage():Boolean {
			return null != message_;
		}
		public function set message(value:String):void {
			message_ = value;
		}
		public function get message():String {
			return message_;
		}
		private var result_:Boolean;
		private var hasResult_:Boolean = false;
		public function get hasResult():Boolean {
			return hasResult_;
		}
		public function set result(value:Boolean):void {
			hasResult_ = true;
			result_ = value;
		}
		public function get result():Boolean {
			return result_;
		}
		private var zuDuiInfo_:proto.zudui.zudui4300.ZuDuiInfo;
		public function get hasZuDuiInfo():Boolean {
			return null != zuDuiInfo_;
		}
		public function set zuDuiInfo(value:proto.zudui.zudui4300.ZuDuiInfo):void {
			zuDuiInfo_ = value;
		}
		public function get zuDuiInfo():proto.zudui.zudui4300.ZuDuiInfo {
			return zuDuiInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasZuDuiInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, zuDuiInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var messageCount:uint = 0;
			var resultCount:uint = 0;
			var zuDuiInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (zuDuiInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++zuDuiInfoCount;
					zuDuiInfo = new proto.zudui.zudui4300.ZuDuiInfo;
					ReadUtils.read_TYPE_MESSAGE(input, zuDuiInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
