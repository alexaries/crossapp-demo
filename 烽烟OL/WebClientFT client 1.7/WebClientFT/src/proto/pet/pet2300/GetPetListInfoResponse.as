package proto.pet.pet2300 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.pet.pet2300.PetInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetPetListInfoResponse extends Message implements IExternalizable {
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
		[ArrayElementType("proto.pet.pet2300.PetInfo")]
		public var petInfo:Array = [];
		private var curPetNum_:int;
		private var hasCurPetNum_:Boolean = false;
		public function get hasCurPetNum():Boolean {
			return hasCurPetNum_;
		}
		public function set curPetNum(value:int):void {
			hasCurPetNum_ = true;
			curPetNum_ = value;
		}
		public function get curPetNum():int {
			return curPetNum_;
		}
		private var maxPetNum_:int;
		private var hasMaxPetNum_:Boolean = false;
		public function get hasMaxPetNum():Boolean {
			return hasMaxPetNum_;
		}
		public function set maxPetNum(value:int):void {
			hasMaxPetNum_ = true;
			maxPetNum_ = value;
		}
		public function get maxPetNum():int {
			return maxPetNum_;
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
			for (var petInfoIndex:uint = 0; petInfoIndex < petInfo.length; ++petInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, petInfo[petInfoIndex]);
			}
			if (hasCurPetNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, curPetNum);
			}
			if (hasMaxPetNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, maxPetNum);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var curPetNumCount:uint = 0;
			var maxPetNumCount:uint = 0;
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
					petInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.pet.pet2300.PetInfo));
					break;
				case 4:
					if (curPetNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curPetNumCount;
					curPetNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (maxPetNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxPetNumCount;
					maxPetNum = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
