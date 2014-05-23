package proto.colo.colo2902 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ColoFuBenInfo extends Message implements IExternalizable {
		private var fuBenId_:int;
		private var hasFuBenId_:Boolean = false;
		public function get hasFuBenId():Boolean {
			return hasFuBenId_;
		}
		public function set fuBenId(value:int):void {
			hasFuBenId_ = true;
			fuBenId_ = value;
		}
		public function get fuBenId():int {
			return fuBenId_;
		}
		private var fuBenName_:String;
		public function get hasFuBenName():Boolean {
			return null != fuBenName_;
		}
		public function set fuBenName(value:String):void {
			fuBenName_ = value;
		}
		public function get fuBenName():String {
			return fuBenName_;
		}
		private var coloCorpsName_:String;
		public function get hasColoCorpsName():Boolean {
			return null != coloCorpsName_;
		}
		public function set coloCorpsName(value:String):void {
			coloCorpsName_ = value;
		}
		public function get coloCorpsName():String {
			return coloCorpsName_;
		}
		private var lingzhu_:String;
		public function get hasLingzhu():Boolean {
			return null != lingzhu_;
		}
		public function set lingzhu(value:String):void {
			lingzhu_ = value;
		}
		public function get lingzhu():String {
			return lingzhu_;
		}
		private var coloType_:int;
		private var hasColoType_:Boolean = false;
		public function get hasColoType():Boolean {
			return hasColoType_;
		}
		public function set coloType(value:int):void {
			hasColoType_ = true;
			coloType_ = value;
		}
		public function get coloType():int {
			return coloType_;
		}
		private var FuCamp_:int;
		private var has_fuCamp_:Boolean = false;
		public function get has_fuCamp():Boolean {
			return has_fuCamp_;
		}
		public function set FuCamp(value:int):void {
			has_fuCamp_ = true;
			FuCamp_ = value;
		}
		public function get FuCamp():int {
			return FuCamp_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasFuBenId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, fuBenId);
			}
			if (hasFuBenName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, fuBenName);
			}
			if (hasColoCorpsName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, coloCorpsName);
			}
			if (hasLingzhu) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, lingzhu);
			}
			if (hasColoType) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, coloType);
			}
			if (has_fuCamp) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, FuCamp);
			}
		}
		public function readExternal(input:IDataInput):void {
			var fuBenIdCount:uint = 0;
			var fuBenNameCount:uint = 0;
			var coloCorpsNameCount:uint = 0;
			var lingzhuCount:uint = 0;
			var coloTypeCount:uint = 0;
			var FuCampCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (fuBenIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fuBenIdCount;
					fuBenId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (fuBenNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fuBenNameCount;
					fuBenName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (coloCorpsNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coloCorpsNameCount;
					coloCorpsName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (lingzhuCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lingzhuCount;
					lingzhu = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (coloTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++coloTypeCount;
					coloType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (FuCampCount != 0) {
						throw new IOError('Bad data format.');
					}
					++FuCampCount;
					FuCamp = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
