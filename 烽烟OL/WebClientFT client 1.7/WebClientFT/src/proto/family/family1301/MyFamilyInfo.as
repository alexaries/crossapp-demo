package proto.family.family1301 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.family.family1301.FamilyInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class MyFamilyInfo extends Message implements IExternalizable {
		private var myFamilyInfo_:proto.family.family1301.FamilyInfo;
		public function get hasMyFamilyInfo():Boolean {
			return null != myFamilyInfo_;
		}
		public function set myFamilyInfo(value:proto.family.family1301.FamilyInfo):void {
			myFamilyInfo_ = value;
		}
		public function get myFamilyInfo():proto.family.family1301.FamilyInfo {
			return myFamilyInfo_;
		}
		private var allianceFamilyInfo_:proto.family.family1301.FamilyInfo;
		public function get hasAllianceFamilyInfo():Boolean {
			return null != allianceFamilyInfo_;
		}
		public function set allianceFamilyInfo(value:proto.family.family1301.FamilyInfo):void {
			allianceFamilyInfo_ = value;
		}
		public function get allianceFamilyInfo():proto.family.family1301.FamilyInfo {
			return allianceFamilyInfo_;
		}
		private var hostilityFamilyInfo_:proto.family.family1301.FamilyInfo;
		public function get hasHostilityFamilyInfo():Boolean {
			return null != hostilityFamilyInfo_;
		}
		public function set hostilityFamilyInfo(value:proto.family.family1301.FamilyInfo):void {
			hostilityFamilyInfo_ = value;
		}
		public function get hostilityFamilyInfo():proto.family.family1301.FamilyInfo {
			return hostilityFamilyInfo_;
		}
		private var familyMoney_:int;
		private var hasFamilyMoney_:Boolean = false;
		public function get hasFamilyMoney():Boolean {
			return hasFamilyMoney_;
		}
		public function set familyMoney(value:int):void {
			hasFamilyMoney_ = true;
			familyMoney_ = value;
		}
		public function get familyMoney():int {
			return familyMoney_;
		}
		private var familyState_:int;
		private var hasFamilyState_:Boolean = false;
		public function get hasFamilyState():Boolean {
			return hasFamilyState_;
		}
		public function set familyState(value:int):void {
			hasFamilyState_ = true;
			familyState_ = value;
		}
		public function get familyState():int {
			return familyState_;
		}
		private var familyStrategierLeft_:String;
		public function get hasFamilyStrategierLeft():Boolean {
			return null != familyStrategierLeft_;
		}
		public function set familyStrategierLeft(value:String):void {
			familyStrategierLeft_ = value;
		}
		public function get familyStrategierLeft():String {
			return familyStrategierLeft_;
		}
		private var familyStrategierRight_:String;
		public function get hasFamilyStrategierRight():Boolean {
			return null != familyStrategierRight_;
		}
		public function set familyStrategierRight(value:String):void {
			familyStrategierRight_ = value;
		}
		public function get familyStrategierRight():String {
			return familyStrategierRight_;
		}
		private var familyMonitorLeft_:String;
		public function get hasFamilyMonitorLeft():Boolean {
			return null != familyMonitorLeft_;
		}
		public function set familyMonitorLeft(value:String):void {
			familyMonitorLeft_ = value;
		}
		public function get familyMonitorLeft():String {
			return familyMonitorLeft_;
		}
		private var familyMonitorCenter_:String;
		public function get hasFamilyMonitorCenter():Boolean {
			return null != familyMonitorCenter_;
		}
		public function set familyMonitorCenter(value:String):void {
			familyMonitorCenter_ = value;
		}
		public function get familyMonitorCenter():String {
			return familyMonitorCenter_;
		}
		private var familyMonitorRight_:String;
		public function get hasFamilyMonitorRight():Boolean {
			return null != familyMonitorRight_;
		}
		public function set familyMonitorRight(value:String):void {
			familyMonitorRight_ = value;
		}
		public function get familyMonitorRight():String {
			return familyMonitorRight_;
		}
		private var myContribution_:int;
		private var hasMyContribution_:Boolean = false;
		public function get hasMyContribution():Boolean {
			return hasMyContribution_;
		}
		public function set myContribution(value:int):void {
			hasMyContribution_ = true;
			myContribution_ = value;
		}
		public function get myContribution():int {
			return myContribution_;
		}
		private var isCanUpLevel_:int;
		private var hasIsCanUpLevel_:Boolean = false;
		public function get hasIsCanUpLevel():Boolean {
			return hasIsCanUpLevel_;
		}
		public function set isCanUpLevel(value:int):void {
			hasIsCanUpLevel_ = true;
			isCanUpLevel_ = value;
		}
		public function get isCanUpLevel():int {
			return isCanUpLevel_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMyFamilyInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, myFamilyInfo);
			}
			if (hasAllianceFamilyInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, allianceFamilyInfo);
			}
			if (hasHostilityFamilyInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, hostilityFamilyInfo);
			}
			if (hasFamilyMoney) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, familyMoney);
			}
			if (hasFamilyState) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, familyState);
			}
			if (hasFamilyStrategierLeft) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, familyStrategierLeft);
			}
			if (hasFamilyStrategierRight) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, familyStrategierRight);
			}
			if (hasFamilyMonitorLeft) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, familyMonitorLeft);
			}
			if (hasFamilyMonitorCenter) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, familyMonitorCenter);
			}
			if (hasFamilyMonitorRight) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, familyMonitorRight);
			}
			if (hasMyContribution) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, myContribution);
			}
			if (hasIsCanUpLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_INT32(output, isCanUpLevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var myFamilyInfoCount:uint = 0;
			var allianceFamilyInfoCount:uint = 0;
			var hostilityFamilyInfoCount:uint = 0;
			var familyMoneyCount:uint = 0;
			var familyStateCount:uint = 0;
			var familyStrategierLeftCount:uint = 0;
			var familyStrategierRightCount:uint = 0;
			var familyMonitorLeftCount:uint = 0;
			var familyMonitorCenterCount:uint = 0;
			var familyMonitorRightCount:uint = 0;
			var myContributionCount:uint = 0;
			var isCanUpLevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (myFamilyInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++myFamilyInfoCount;
					myFamilyInfo = new proto.family.family1301.FamilyInfo;
					ReadUtils.read_TYPE_MESSAGE(input, myFamilyInfo);
					break;
				case 2:
					if (allianceFamilyInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++allianceFamilyInfoCount;
					allianceFamilyInfo = new proto.family.family1301.FamilyInfo;
					ReadUtils.read_TYPE_MESSAGE(input, allianceFamilyInfo);
					break;
				case 3:
					if (hostilityFamilyInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++hostilityFamilyInfoCount;
					hostilityFamilyInfo = new proto.family.family1301.FamilyInfo;
					ReadUtils.read_TYPE_MESSAGE(input, hostilityFamilyInfo);
					break;
				case 4:
					if (familyMoneyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyMoneyCount;
					familyMoney = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (familyStateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyStateCount;
					familyState = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (familyStrategierLeftCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyStrategierLeftCount;
					familyStrategierLeft = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (familyStrategierRightCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyStrategierRightCount;
					familyStrategierRight = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (familyMonitorLeftCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyMonitorLeftCount;
					familyMonitorLeft = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (familyMonitorCenterCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyMonitorCenterCount;
					familyMonitorCenter = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (familyMonitorRightCount != 0) {
						throw new IOError('Bad data format.');
					}
					++familyMonitorRightCount;
					familyMonitorRight = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (myContributionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++myContributionCount;
					myContribution = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (isCanUpLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++isCanUpLevelCount;
					isCanUpLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
