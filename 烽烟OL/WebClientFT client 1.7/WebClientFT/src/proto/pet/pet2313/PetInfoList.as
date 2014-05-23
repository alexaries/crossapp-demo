package proto.pet.pet2313 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.pet.PetInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class PetInfoList extends Message implements IExternalizable {
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
		public function writeExternal(output:IDataOutput):void {
			if (hasReqCoin) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, reqCoin);
			}
			if (hasInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, info);
			}
		}
		public function readExternal(input:IDataInput):void {
			var reqCoinCount:uint = 0;
			var infoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (reqCoinCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reqCoinCount;
					reqCoin = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (infoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++infoCount;
					info = new proto.pet.PetInfo;
					ReadUtils.read_TYPE_MESSAGE(input, info);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
