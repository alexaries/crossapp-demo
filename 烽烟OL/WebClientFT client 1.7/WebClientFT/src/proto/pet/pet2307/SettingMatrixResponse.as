package proto.pet.pet2307 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SettingMatrixResponse extends Message implements IExternalizable {
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
		private var petId_:int;
		private var hasPetId_:Boolean = false;
		public function get hasPetId():Boolean {
			return hasPetId_;
		}
		public function set petId(value:int):void {
			hasPetId_ = true;
			petId_ = value;
		}
		public function get petId():int {
			return petId_;
		}
		private var operationType_:int;
		private var hasOperationType_:Boolean = false;
		public function get hasOperationType():Boolean {
			return hasOperationType_;
		}
		public function set operationType(value:int):void {
			hasOperationType_ = true;
			operationType_ = value;
		}
		public function get operationType():int {
			return operationType_;
		}
		private var fromPos_:int;
		private var hasFromPos_:Boolean = false;
		public function get hasFromPos():Boolean {
			return hasFromPos_;
		}
		public function set fromPos(value:int):void {
			hasFromPos_ = true;
			fromPos_ = value;
		}
		public function get fromPos():int {
			return fromPos_;
		}
		private var toPos_:int;
		private var hasToPos_:Boolean = false;
		public function get hasToPos():Boolean {
			return hasToPos_;
		}
		public function set toPos(value:int):void {
			hasToPos_ = true;
			toPos_ = value;
		}
		public function get toPos():int {
			return toPos_;
		}
		private var matrixId_:int;
		private var hasMatrixId_:Boolean = false;
		public function get hasMatrixId():Boolean {
			return hasMatrixId_;
		}
		public function set matrixId(value:int):void {
			hasMatrixId_ = true;
			matrixId_ = value;
		}
		public function get matrixId():int {
			return matrixId_;
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
			if (hasPetId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, petId);
			}
			if (hasOperationType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, operationType);
			}
			if (hasFromPos) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, fromPos);
			}
			if (hasToPos) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, toPos);
			}
			if (hasMatrixId) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, matrixId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var petIdCount:uint = 0;
			var operationTypeCount:uint = 0;
			var fromPosCount:uint = 0;
			var toPosCount:uint = 0;
			var matrixIdCount:uint = 0;
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
					if (petIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petIdCount;
					petId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (operationTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++operationTypeCount;
					operationType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (fromPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fromPosCount;
					fromPos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (toPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++toPosCount;
					toPos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (matrixIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++matrixIdCount;
					matrixId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
