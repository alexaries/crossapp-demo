package proto.zhanxing {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class XingYunBasicInfo extends Message implements IExternalizable {
		private var xyId_:int;
		private var hasXyId_:Boolean = false;
		public function get hasXyId():Boolean {
			return hasXyId_;
		}
		public function set xyId(value:int):void {
			hasXyId_ = true;
			xyId_ = value;
		}
		public function get xyId():int {
			return xyId_;
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
		private var xyName_:String;
		public function get hasXyName():Boolean {
			return null != xyName_;
		}
		public function set xyName(value:String):void {
			xyName_ = value;
		}
		public function get xyName():String {
			return xyName_;
		}
		private var xyDes_:String;
		public function get hasXyDes():Boolean {
			return null != xyDes_;
		}
		public function set xyDes(value:String):void {
			xyDes_ = value;
		}
		public function get xyDes():String {
			return xyDes_;
		}
		private var xytemId_:int;
		private var hasXytemId_:Boolean = false;
		public function get hasXytemId():Boolean {
			return hasXytemId_;
		}
		public function set xytemId(value:int):void {
			hasXytemId_ = true;
			xytemId_ = value;
		}
		public function get xytemId():int {
			return xytemId_;
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
		private var level_:int;
		private var hasLevel_:Boolean = false;
		public function get hasLevel():Boolean {
			return hasLevel_;
		}
		public function set level(value:int):void {
			hasLevel_ = true;
			level_ = value;
		}
		public function get level():int {
			return level_;
		}
		private var exp_:int;
		private var hasExp_:Boolean = false;
		public function get hasExp():Boolean {
			return hasExp_;
		}
		public function set exp(value:int):void {
			hasExp_ = true;
			exp_ = value;
		}
		public function get exp():int {
			return exp_;
		}
		private var maxexp_:int;
		private var hasMaxexp_:Boolean = false;
		public function get hasMaxexp():Boolean {
			return hasMaxexp_;
		}
		public function set maxexp(value:int):void {
			hasMaxexp_ = true;
			maxexp_ = value;
		}
		public function get maxexp():int {
			return maxexp_;
		}
		private var price_:int;
		private var hasPrice_:Boolean = false;
		public function get hasPrice():Boolean {
			return hasPrice_;
		}
		public function set price(value:int):void {
			hasPrice_ = true;
			price_ = value;
		}
		public function get price():int {
			return price_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasXyId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, xyId);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasXyName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, xyName);
			}
			if (hasXyDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, xyDes);
			}
			if (hasXytemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, xytemId);
			}
			if (hasQuality) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, quality);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, level);
			}
			if (hasExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_INT32(output, exp);
			}
			if (hasMaxexp) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, maxexp);
			}
			if (hasPrice) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, price);
			}
		}
		public function readExternal(input:IDataInput):void {
			var xyIdCount:uint = 0;
			var typeCount:uint = 0;
			var iconCount:uint = 0;
			var xyNameCount:uint = 0;
			var xyDesCount:uint = 0;
			var xytemIdCount:uint = 0;
			var qualityCount:uint = 0;
			var levelCount:uint = 0;
			var expCount:uint = 0;
			var maxexpCount:uint = 0;
			var priceCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (xyIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xyIdCount;
					xyId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (xyNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xyNameCount;
					xyName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (xyDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xyDesCount;
					xyDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (xytemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xytemIdCount;
					xytemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (qualityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++qualityCount;
					quality = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				case 9:
					if (expCount != 0) {
						throw new IOError('Bad data format.');
					}
					++expCount;
					exp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 10:
					if (maxexpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxexpCount;
					maxexp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (priceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++priceCount;
					price = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
