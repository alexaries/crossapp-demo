package proto.corps.corps1320 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class UnionInviteReplyResponse extends Message implements IExternalizable {
		public var result:Boolean;
		private var unionId_:int;
		private var hasUnionId_:Boolean = false;
		public function get hasUnionId():Boolean {
			return hasUnionId_;
		}
		public function set unionId(value:int):void {
			hasUnionId_ = true;
			unionId_ = value;
		}
		public function get unionId():int {
			return unionId_;
		}
		private var unionName_:String;
		public function get hasUnionName():Boolean {
			return null != unionName_;
		}
		public function set unionName(value:String):void {
			unionName_ = value;
		}
		public function get unionName():String {
			return unionName_;
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
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			if (hasUnionId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, unionId);
			}
			if (hasUnionName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, unionName);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, message);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var unionIdCount:uint = 0;
			var unionNameCount:uint = 0;
			var messageCount:uint = 0;
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
					if (unionIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionIdCount;
					unionId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (unionNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionNameCount;
					unionName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (resultCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
