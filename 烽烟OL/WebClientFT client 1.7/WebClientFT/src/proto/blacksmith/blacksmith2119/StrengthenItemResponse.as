package proto.blacksmith.blacksmith2119 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class StrengthenItemResponse extends Message implements IExternalizable {
		public var result:Boolean;
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
		private var qh_:int;
		private var hasQh_:Boolean = false;
		public function get hasQh():Boolean {
			return hasQh_;
		}
		public function set qh(value:int):void {
			hasQh_ = true;
			qh_ = value;
		}
		public function get qh():int {
			return qh_;
		}
		private var coin_:int;
		private var hasCoin_:Boolean = false;
		public function get hasCoin():Boolean {
			return hasCoin_;
		}
		public function set coin(value:int):void {
			hasCoin_ = true;
			coin_ = value;
		}
		public function get coin():int {
			return coin_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasQh) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, qh);
			}
			if (hasCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, coin);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var qhCount:uint = 0;
			var coinCount:uint = 0;
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
					if (qhCount != 0) {
						throw new IOError('Bad data format.');
					}
					++qhCount;
					qh = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (coinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coinCount;
					coin = ReadUtils.read_TYPE_INT32(input);
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
