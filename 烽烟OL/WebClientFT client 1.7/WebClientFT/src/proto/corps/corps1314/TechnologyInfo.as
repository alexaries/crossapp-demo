package proto.corps.corps1314 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TechnologyInfo extends Message implements IExternalizable {
		private var technologyId_:int;
		private var hasTechnologyId_:Boolean = false;
		public function get hasTechnologyId():Boolean {
			return hasTechnologyId_;
		}
		public function set technologyId(value:int):void {
			hasTechnologyId_ = true;
			technologyId_ = value;
		}
		public function get technologyId():int {
			return technologyId_;
		}
		private var technologyImg_:int;
		private var hasTechnologyImg_:Boolean = false;
		public function get hasTechnologyImg():Boolean {
			return hasTechnologyImg_;
		}
		public function set technologyImg(value:int):void {
			hasTechnologyImg_ = true;
			technologyImg_ = value;
		}
		public function get technologyImg():int {
			return technologyImg_;
		}
		private var technologyName_:String;
		public function get hasTechnologyName():Boolean {
			return null != technologyName_;
		}
		public function set technologyName(value:String):void {
			technologyName_ = value;
		}
		public function get technologyName():String {
			return technologyName_;
		}
		private var technologyLevel_:int;
		private var hasTechnologyLevel_:Boolean = false;
		public function get hasTechnologyLevel():Boolean {
			return hasTechnologyLevel_;
		}
		public function set technologyLevel(value:int):void {
			hasTechnologyLevel_ = true;
			technologyLevel_ = value;
		}
		public function get technologyLevel():int {
			return technologyLevel_;
		}
		private var remainCondition_:String;
		public function get hasRemainCondition():Boolean {
			return null != remainCondition_;
		}
		public function set remainCondition(value:String):void {
			remainCondition_ = value;
		}
		public function get remainCondition():String {
			return remainCondition_;
		}
		private var curSchedule_:int;
		private var hasCurSchedule_:Boolean = false;
		public function get hasCurSchedule():Boolean {
			return hasCurSchedule_;
		}
		public function set curSchedule(value:int):void {
			hasCurSchedule_ = true;
			curSchedule_ = value;
		}
		public function get curSchedule():int {
			return curSchedule_;
		}
		private var maxSchedule_:int;
		private var hasMaxSchedule_:Boolean = false;
		public function get hasMaxSchedule():Boolean {
			return hasMaxSchedule_;
		}
		public function set maxSchedule(value:int):void {
			hasMaxSchedule_ = true;
			maxSchedule_ = value;
		}
		public function get maxSchedule():int {
			return maxSchedule_;
		}
		private var technologyDes_:String;
		public function get hasTechnologyDes():Boolean {
			return null != technologyDes_;
		}
		public function set technologyDes(value:String):void {
			technologyDes_ = value;
		}
		public function get technologyDes():String {
			return technologyDes_;
		}
		private var defaultDonate_:Boolean;
		private var hasDefaultDonate_:Boolean = false;
		public function get hasDefaultDonate():Boolean {
			return hasDefaultDonate_;
		}
		public function set defaultDonate(value:Boolean):void {
			hasDefaultDonate_ = true;
			defaultDonate_ = value;
		}
		public function get defaultDonate():Boolean {
			return defaultDonate_;
		}
		private var isenable_:Boolean;
		private var hasIsenable_:Boolean = false;
		public function get hasIsenable():Boolean {
			return hasIsenable_;
		}
		public function set isenable(value:Boolean):void {
			hasIsenable_ = true;
			isenable_ = value;
		}
		public function get isenable():Boolean {
			return isenable_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasTechnologyId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, technologyId);
			}
			if (hasTechnologyImg) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, technologyImg);
			}
			if (hasTechnologyName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, technologyName);
			}
			if (hasTechnologyLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, technologyLevel);
			}
			if (hasRemainCondition) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, remainCondition);
			}
			if (hasCurSchedule) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, curSchedule);
			}
			if (hasMaxSchedule) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, maxSchedule);
			}
			if (hasTechnologyDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, technologyDes);
			}
			if (hasDefaultDonate) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_BOOL(output, defaultDonate);
			}
			if (hasIsenable) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_BOOL(output, isenable);
			}
		}
		public function readExternal(input:IDataInput):void {
			var technologyIdCount:uint = 0;
			var technologyImgCount:uint = 0;
			var technologyNameCount:uint = 0;
			var technologyLevelCount:uint = 0;
			var remainConditionCount:uint = 0;
			var curScheduleCount:uint = 0;
			var maxScheduleCount:uint = 0;
			var technologyDesCount:uint = 0;
			var defaultDonateCount:uint = 0;
			var isenableCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (technologyIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++technologyIdCount;
					technologyId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (technologyImgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++technologyImgCount;
					technologyImg = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (technologyNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++technologyNameCount;
					technologyName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (technologyLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++technologyLevelCount;
					technologyLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (remainConditionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++remainConditionCount;
					remainCondition = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (curScheduleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curScheduleCount;
					curSchedule = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (maxScheduleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxScheduleCount;
					maxSchedule = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (technologyDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++technologyDesCount;
					technologyDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (defaultDonateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++defaultDonateCount;
					defaultDonate = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 10:
					if (isenableCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isenableCount;
					isenable = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
