package proto.zhanxing.zhanxing3604 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.zhanxing.XingYunBasicInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RoleAndPetInfo extends Message implements IExternalizable {
		private var rpId_:int;
		private var hasRpId_:Boolean = false;
		public function get hasRpId():Boolean {
			return hasRpId_;
		}
		public function set rpId(value:int):void {
			hasRpId_ = true;
			rpId_ = value;
		}
		public function get rpId():int {
			return rpId_;
		}
		private var rpName_:String;
		public function get hasRpName():Boolean {
			return null != rpName_;
		}
		public function set rpName(value:String):void {
			rpName_ = value;
		}
		public function get rpName():String {
			return rpName_;
		}
		private var rpLevel_:int;
		private var hasRpLevel_:Boolean = false;
		public function get hasRpLevel():Boolean {
			return hasRpLevel_;
		}
		public function set rpLevel(value:int):void {
			hasRpLevel_ = true;
			rpLevel_ = value;
		}
		public function get rpLevel():int {
			return rpLevel_;
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
		private var xyBody1_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXyBody1():Boolean {
			return null != xyBody1_;
		}
		public function set xyBody1(value:proto.zhanxing.XingYunBasicInfo):void {
			xyBody1_ = value;
		}
		public function get xyBody1():proto.zhanxing.XingYunBasicInfo {
			return xyBody1_;
		}
		private var xyBody2_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXyBody2():Boolean {
			return null != xyBody2_;
		}
		public function set xyBody2(value:proto.zhanxing.XingYunBasicInfo):void {
			xyBody2_ = value;
		}
		public function get xyBody2():proto.zhanxing.XingYunBasicInfo {
			return xyBody2_;
		}
		private var xyBody3_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXyBody3():Boolean {
			return null != xyBody3_;
		}
		public function set xyBody3(value:proto.zhanxing.XingYunBasicInfo):void {
			xyBody3_ = value;
		}
		public function get xyBody3():proto.zhanxing.XingYunBasicInfo {
			return xyBody3_;
		}
		private var xyBody4_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXyBody4():Boolean {
			return null != xyBody4_;
		}
		public function set xyBody4(value:proto.zhanxing.XingYunBasicInfo):void {
			xyBody4_ = value;
		}
		public function get xyBody4():proto.zhanxing.XingYunBasicInfo {
			return xyBody4_;
		}
		private var xyBody5_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXyBody5():Boolean {
			return null != xyBody5_;
		}
		public function set xyBody5(value:proto.zhanxing.XingYunBasicInfo):void {
			xyBody5_ = value;
		}
		public function get xyBody5():proto.zhanxing.XingYunBasicInfo {
			return xyBody5_;
		}
		private var xyBody6_:proto.zhanxing.XingYunBasicInfo;
		public function get hasXyBody6():Boolean {
			return null != xyBody6_;
		}
		public function set xyBody6(value:proto.zhanxing.XingYunBasicInfo):void {
			xyBody6_ = value;
		}
		public function get xyBody6():proto.zhanxing.XingYunBasicInfo {
			return xyBody6_;
		}
		private var rpType_:int;
		private var hasRpType_:Boolean = false;
		public function get hasRpType():Boolean {
			return hasRpType_;
		}
		public function set rpType(value:int):void {
			hasRpType_ = true;
			rpType_ = value;
		}
		public function get rpType():int {
			return rpType_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRpId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, rpId);
			}
			if (hasRpName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, rpName);
			}
			if (hasRpLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, rpLevel);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasXyBody1) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, xyBody1);
			}
			if (hasXyBody2) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, xyBody2);
			}
			if (hasXyBody3) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_MESSAGE(output, xyBody3);
			}
			if (hasXyBody4) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_MESSAGE(output, xyBody4);
			}
			if (hasXyBody5) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_MESSAGE(output, xyBody5);
			}
			if (hasXyBody6) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_MESSAGE(output, xyBody6);
			}
			if (hasRpType) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, rpType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var rpIdCount:uint = 0;
			var rpNameCount:uint = 0;
			var rpLevelCount:uint = 0;
			var iconCount:uint = 0;
			var xyBody1Count:uint = 0;
			var xyBody2Count:uint = 0;
			var xyBody3Count:uint = 0;
			var xyBody4Count:uint = 0;
			var xyBody5Count:uint = 0;
			var xyBody6Count:uint = 0;
			var rpTypeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (rpIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rpIdCount;
					rpId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (rpNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rpNameCount;
					rpName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (rpLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rpLevelCount;
					rpLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (xyBody1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xyBody1Count;
					xyBody1 = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyBody1);
					break;
				case 6:
					if (xyBody2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xyBody2Count;
					xyBody2 = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyBody2);
					break;
				case 7:
					if (xyBody3Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xyBody3Count;
					xyBody3 = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyBody3);
					break;
				case 8:
					if (xyBody4Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xyBody4Count;
					xyBody4 = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyBody4);
					break;
				case 9:
					if (xyBody5Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xyBody5Count;
					xyBody5 = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyBody5);
					break;
				case 10:
					if (xyBody6Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xyBody6Count;
					xyBody6 = new proto.zhanxing.XingYunBasicInfo;
					ReadUtils.read_TYPE_MESSAGE(input, xyBody6);
					break;
				case 11:
					if (rpTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rpTypeCount;
					rpType = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
