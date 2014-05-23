package proto.jingji.jingji3703 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class AddJingJiCountResponse extends Message implements IExternalizable {
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
		private var bCount_:int;
		private var hasBCount_:Boolean = false;
		public function get hasBCount():Boolean {
			return hasBCount_;
		}
		public function set bCount(value:int):void {
			hasBCount_ = true;
			bCount_ = value;
		}
		public function get bCount():int {
			return bCount_;
		}
		private var addCount_:int;
		private var hasAddCount_:Boolean = false;
		public function get hasAddCount():Boolean {
			return hasAddCount_;
		}
		public function set addCount(value:int):void {
			hasAddCount_ = true;
			addCount_ = value;
		}
		public function get addCount():int {
			return addCount_;
		}
		private var reqCoin_:int;
		private var hasReqCoin_:Boolean = false;
		public function get hasReqCoin():Boolean {
			return hasReqCoin_;
		}
		public function set reqCoin(value:int):void {
			hasReqCoin_ = true;
			reqCoin_ = value;
		}
		public function get reqCoin():int {
			return reqCoin_;
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
			if (hasBCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, bCount);
			}
			if (hasAddCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, addCount);
			}
			if (hasReqCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, reqCoin);
			}
		}
		public function readExternal(input:IDataInput):void {
			var messageCount:uint = 0;
			var resultCount:uint = 0;
			var bCountCount:uint = 0;
			var addCountCount:uint = 0;
			var reqCoinCount:uint = 0;
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
					if (bCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++bCountCount;
					bCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (addCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addCountCount;
					addCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (reqCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reqCoinCount;
					reqCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
