package proto.pet.pet2316 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.pet.PetInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetOnePetTuJianInfoResponse extends Message implements IExternalizable {
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
		private var info_:proto.pet.PetInfo;
		public function get hasInfo():Boolean {
			return null != info_;
		}
		public function set info(value:proto.pet.PetInfo):void {
			info_ = value;
		}
		public function get info():proto.pet.PetInfo {
			return info_;
		}
		private var curHun_:int;
		private var hasCurHun_:Boolean = false;
		public function get hasCurHun():Boolean {
			return hasCurHun_;
		}
		public function set curHun(value:int):void {
			hasCurHun_ = true;
			curHun_ = value;
		}
		public function get curHun():int {
			return curHun_;
		}
		private var maxHun_:int;
		private var hasMaxHun_:Boolean = false;
		public function get hasMaxHun():Boolean {
			return hasMaxHun_;
		}
		public function set maxHun(value:int):void {
			hasMaxHun_ = true;
			maxHun_ = value;
		}
		public function get maxHun():int {
			return maxHun_;
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
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, info);
			}
			if (hasCurHun) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, curHun);
			}
			if (hasMaxHun) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, maxHun);
			}
			if (hasReqCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, reqCoin);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var infoCount:uint = 0;
			var curHunCount:uint = 0;
			var maxHunCount:uint = 0;
			var reqCoinCount:uint = 0;
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
					if (infoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++infoCount;
					info = new proto.pet.PetInfo;
					ReadUtils.read_TYPE_MESSAGE(input, info);
					break;
				case 4:
					if (curHunCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curHunCount;
					curHun = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (maxHunCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxHunCount;
					maxHun = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
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
