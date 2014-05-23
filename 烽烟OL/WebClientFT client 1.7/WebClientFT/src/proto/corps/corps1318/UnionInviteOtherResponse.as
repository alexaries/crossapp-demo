package proto.corps.corps1318 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class UnionInviteOtherResponse extends Message implements IExternalizable {
		public var result:Boolean;
		private var otherid_:int;
		private var hasOtherid_:Boolean = false;
		public function get hasOtherid():Boolean {
			return hasOtherid_;
		}
		public function set otherid(value:int):void {
			hasOtherid_ = true;
			otherid_ = value;
		}
		public function get otherid():int {
			return otherid_;
		}
		private var otername_:String;
		public function get hasOtername():Boolean {
			return null != otername_;
		}
		public function set otername(value:String):void {
			otername_ = value;
		}
		public function get otername():String {
			return otername_;
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
			if (hasOtherid) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, otherid);
			}
			if (hasOtername) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, otername);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, message);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var otheridCount:uint = 0;
			var oternameCount:uint = 0;
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
					if (otheridCount != 0) {
						throw new IOError('Bad data format.');
					}
					++otheridCount;
					otherid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (oternameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++oternameCount;
					otername = ReadUtils.read_TYPE_STRING(input);
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
