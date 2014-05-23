package proto.pet.pet2306 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MatrixTitleInfo extends Message implements IExternalizable {
		private var titlePos_:int;
		private var hasTitlePos_:Boolean = false;
		public function get hasTitlePos():Boolean {
			return hasTitlePos_;
		}
		public function set titlePos(value:int):void {
			hasTitlePos_ = true;
			titlePos_ = value;
		}
		public function get titlePos():int {
			return titlePos_;
		}
		private var hasPet_:Boolean;
		private var hasHasPet_:Boolean = false;
		public function get hasHasPet():Boolean {
			return hasHasPet_;
		}
		public function set hasPet(value:Boolean):void {
			hasHasPet_ = true;
			hasPet_ = value;
		}
		public function get hasPet():Boolean {
			return hasPet_;
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
		private var type_:int;
		private var hasType_:Boolean = false;
		public function get hasType():Boolean {
			return hasType_;
		}
		public function set type(value:int):void {
			hasType_ = true;
			type_ = value;
		}
		public function get type():int {
			return type_;
		}
		private var icon_:int;
		private var hasIcon_:Boolean = false;
		public function get hasIcon():Boolean {
			return hasIcon_;
		}
		public function set icon(value:int):void {
			hasIcon_ = true;
			icon_ = value;
		}
		public function get icon():int {
			return icon_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasTitlePos) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, titlePos);
			}
			if (hasHasPet) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, hasPet);
			}
			if (hasPetId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, petId);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
		}
		public function readExternal(input:IDataInput):void {
			var titlePosCount:uint = 0;
			var hasPetCount:uint = 0;
			var petIdCount:uint = 0;
			var typeCount:uint = 0;
			var iconCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (titlePosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++titlePosCount;
					titlePos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (hasPetCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hasPetCount;
					hasPet = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (petIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petIdCount;
					petId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
