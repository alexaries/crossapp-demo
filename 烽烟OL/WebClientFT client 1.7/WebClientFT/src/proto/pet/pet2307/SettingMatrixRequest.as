package proto.pet.pet2307 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SettingMatrixRequest extends Message implements IExternalizable {
		public var id:int;
		public var petId:int;
		public var operationType:int;
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
		public var matrixId:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, petId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, operationType);
			if (hasFromPos) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, fromPos);
			}
			if (hasToPos) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, toPos);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 6);
			WriteUtils.write_TYPE_INT32(output, matrixId);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var petIdCount:uint = 0;
			var operationTypeCount:uint = 0;
			var fromPosCount:uint = 0;
			var toPosCount:uint = 0;
			var matrixIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (petIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petIdCount;
					petId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (operationTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++operationTypeCount;
					operationType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (fromPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fromPosCount;
					fromPos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (toPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++toPosCount;
					toPos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
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
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (petIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (operationTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (matrixIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
