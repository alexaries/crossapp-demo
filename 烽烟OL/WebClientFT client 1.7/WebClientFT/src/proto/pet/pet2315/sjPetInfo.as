package proto.pet.pet2315 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class sjPetInfo extends Message implements IExternalizable {
		private var petName_:String;
		public function get hasPetName():Boolean {
			return null != petName_;
		}
		public function set petName(value:String):void {
			petName_ = value;
		}
		public function get petName():String {
			return petName_;
		}
		private var petLevel_:int;
		private var hasPetLevel_:Boolean = false;
		public function get hasPetLevel():Boolean {
			return hasPetLevel_;
		}
		public function set petLevel(value:int):void {
			hasPetLevel_ = true;
			petLevel_ = value;
		}
		public function get petLevel():int {
			return petLevel_;
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
		private var viewFlag_:Boolean;
		private var hasViewFlag_:Boolean = false;
		public function get hasViewFlag():Boolean {
			return hasViewFlag_;
		}
		public function set viewFlag(value:Boolean):void {
			hasViewFlag_ = true;
			viewFlag_ = value;
		}
		public function get viewFlag():Boolean {
			return viewFlag_;
		}
		private var quality_:int;
		private var hasQuality_:Boolean = false;
		public function get hasQuality():Boolean {
			return hasQuality_;
		}
		public function set quality(value:int):void {
			hasQuality_ = true;
			quality_ = value;
		}
		public function get quality():int {
			return quality_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasPetName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, petName);
			}
			if (hasPetLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, petLevel);
			}
			if (hasPetId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, petId);
			}
			if (hasViewFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_BOOL(output, viewFlag);
			}
			if (hasQuality) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, quality);
			}
		}
		public function readExternal(input:IDataInput):void {
			var petNameCount:uint = 0;
			var petLevelCount:uint = 0;
			var petIdCount:uint = 0;
			var viewFlagCount:uint = 0;
			var qualityCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (petNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petNameCount;
					petName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (petLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petLevelCount;
					petLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (petIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petIdCount;
					petId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (viewFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++viewFlagCount;
					viewFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 5:
					if (qualityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++qualityCount;
					quality = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
