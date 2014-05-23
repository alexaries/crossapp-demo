package proto.pet.pet2315 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.pet.pet2315.sjListInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetTuJianPetListResponse extends Message implements IExternalizable {
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
		private var slInfo_:proto.pet.pet2315.sjListInfo;
		public function get hasSlInfo():Boolean {
			return null != slInfo_;
		}
		public function set slInfo(value:proto.pet.pet2315.sjListInfo):void {
			slInfo_ = value;
		}
		public function get slInfo():proto.pet.pet2315.sjListInfo {
			return slInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasSlInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, slInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var slInfoCount:uint = 0;
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
					if (slInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++slInfoCount;
					slInfo = new proto.pet.pet2315.sjListInfo;
					ReadUtils.read_TYPE_MESSAGE(input, slInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
