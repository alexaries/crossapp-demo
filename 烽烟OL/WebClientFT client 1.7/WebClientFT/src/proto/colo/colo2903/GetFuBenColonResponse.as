package proto.colo.colo2903 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetFuBenColonResponse extends Message implements IExternalizable {
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
		private var coloNum_:int;
		private var hasColoNum_:Boolean = false;
		public function get hasColoNum():Boolean {
			return hasColoNum_;
		}
		public function set coloNum(value:int):void {
			hasColoNum_ = true;
			coloNum_ = value;
		}
		public function get coloNum():int {
			return coloNum_;
		}
		private var coloDes_:String;
		public function get hasColoDes():Boolean {
			return null != coloDes_;
		}
		public function set coloDes(value:String):void {
			coloDes_ = value;
		}
		public function get coloDes():String {
			return coloDes_;
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
			if (hasColoNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, coloNum);
			}
			if (hasColoDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, coloDes);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var coloNumCount:uint = 0;
			var coloDesCount:uint = 0;
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
					if (coloNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coloNumCount;
					coloNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (coloDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coloDesCount;
					coloDes = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
