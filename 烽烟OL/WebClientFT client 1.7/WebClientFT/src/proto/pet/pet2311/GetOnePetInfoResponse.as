package proto.pet.pet2311 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.pet.pet2311.ZiZhiInfo;
	import proto.pet.PetInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetOnePetInfoResponse extends Message implements IExternalizable {
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
		private var extendsExp_:int;
		private var hasExtendsExp_:Boolean = false;
		public function get hasExtendsExp():Boolean {
			return hasExtendsExp_;
		}
		public function set extendsExp(value:int):void {
			hasExtendsExp_ = true;
			extendsExp_ = value;
		}
		public function get extendsExp():int {
			return extendsExp_;
		}
		private var ziZhiInfo_:proto.pet.pet2311.ZiZhiInfo;
		public function get hasZiZhiInfo():Boolean {
			return null != ziZhiInfo_;
		}
		public function set ziZhiInfo(value:proto.pet.pet2311.ZiZhiInfo):void {
			ziZhiInfo_ = value;
		}
		public function get ziZhiInfo():proto.pet.pet2311.ZiZhiInfo {
			return ziZhiInfo_;
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
			if (hasExtendsExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, extendsExp);
			}
			if (hasZiZhiInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, ziZhiInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var infoCount:uint = 0;
			var extendsExpCount:uint = 0;
			var ziZhiInfoCount:uint = 0;
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
					if (extendsExpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++extendsExpCount;
					extendsExp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (ziZhiInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++ziZhiInfoCount;
					ziZhiInfo = new proto.pet.pet2311.ZiZhiInfo;
					ReadUtils.read_TYPE_MESSAGE(input, ziZhiInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
