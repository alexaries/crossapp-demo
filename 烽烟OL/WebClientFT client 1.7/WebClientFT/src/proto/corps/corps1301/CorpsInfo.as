package proto.corps.corps1301 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CorpsInfo extends Message implements IExternalizable {
		private var corpsId_:int;
		private var hasCorpsId_:Boolean = false;
		public function get hasCorpsId():Boolean {
			return hasCorpsId_;
		}
		public function set corpsId(value:int):void {
			hasCorpsId_ = true;
			corpsId_ = value;
		}
		public function get corpsId():int {
			return corpsId_;
		}
		private var corpsImg_:int;
		private var hasCorpsImg_:Boolean = false;
		public function get hasCorpsImg():Boolean {
			return hasCorpsImg_;
		}
		public function set corpsImg(value:int):void {
			hasCorpsImg_ = true;
			corpsImg_ = value;
		}
		public function get corpsImg():int {
			return corpsImg_;
		}
		private var corpsName_:String;
		public function get hasCorpsName():Boolean {
			return null != corpsName_;
		}
		public function set corpsName(value:String):void {
			corpsName_ = value;
		}
		public function get corpsName():String {
			return corpsName_;
		}
		private var corpsChief_:String;
		public function get hasCorpsChief():Boolean {
			return null != corpsChief_;
		}
		public function set corpsChief(value:String):void {
			corpsChief_ = value;
		}
		public function get corpsChief():String {
			return corpsChief_;
		}
		private var corpsLevel_:int;
		private var hasCorpsLevel_:Boolean = false;
		public function get hasCorpsLevel():Boolean {
			return hasCorpsLevel_;
		}
		public function set corpsLevel(value:int):void {
			hasCorpsLevel_ = true;
			corpsLevel_ = value;
		}
		public function get corpsLevel():int {
			return corpsLevel_;
		}
		private var curNum_:int;
		private var hasCurNum_:Boolean = false;
		public function get hasCurNum():Boolean {
			return hasCurNum_;
		}
		public function set curNum(value:int):void {
			hasCurNum_ = true;
			curNum_ = value;
		}
		public function get curNum():int {
			return curNum_;
		}
		private var maxNum_:int;
		private var hasMaxNum_:Boolean = false;
		public function get hasMaxNum():Boolean {
			return hasMaxNum_;
		}
		public function set maxNum(value:int):void {
			hasMaxNum_ = true;
			maxNum_ = value;
		}
		public function get maxNum():int {
			return maxNum_;
		}
		private var onApplication_:Boolean;
		private var hasOnApplication_:Boolean = false;
		public function get hasOnApplication():Boolean {
			return hasOnApplication_;
		}
		public function set onApplication(value:Boolean):void {
			hasOnApplication_ = true;
			onApplication_ = value;
		}
		public function get onApplication():Boolean {
			return onApplication_;
		}
		private var corpsTitle_:String;
		public function get hasCorpsTitle():Boolean {
			return null != corpsTitle_;
		}
		public function set corpsTitle(value:String):void {
			corpsTitle_ = value;
		}
		public function get corpsTitle():String {
			return corpsTitle_;
		}
		private var corpsAnnouncement_:String;
		public function get hasCorpsAnnouncement():Boolean {
			return null != corpsAnnouncement_;
		}
		public function set corpsAnnouncement(value:String):void {
			corpsAnnouncement_ = value;
		}
		public function get corpsAnnouncement():String {
			return corpsAnnouncement_;
		}
		private var leaderId_:int;
		private var hasLeaderId_:Boolean = false;
		public function get hasLeaderId():Boolean {
			return hasLeaderId_;
		}
		public function set leaderId(value:int):void {
			hasLeaderId_ = true;
			leaderId_ = value;
		}
		public function get leaderId():int {
			return leaderId_;
		}
		private var runningFlag_:Boolean;
		private var hasRunningFlag_:Boolean = false;
		public function get hasRunningFlag():Boolean {
			return hasRunningFlag_;
		}
		public function set runningFlag(value:Boolean):void {
			hasRunningFlag_ = true;
			runningFlag_ = value;
		}
		public function get runningFlag():Boolean {
			return runningFlag_;
		}
		private var levelrequired_:int;
		private var hasLevelrequired_:Boolean = false;
		public function get hasLevelrequired():Boolean {
			return hasLevelrequired_;
		}
		public function set levelrequired(value:int):void {
			hasLevelrequired_ = true;
			levelrequired_ = value;
		}
		public function get levelrequired():int {
			return levelrequired_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasCorpsId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, corpsId);
			}
			if (hasCorpsImg) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, corpsImg);
			}
			if (hasCorpsName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, corpsName);
			}
			if (hasCorpsChief) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, corpsChief);
			}
			if (hasCorpsLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, corpsLevel);
			}
			if (hasCurNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, curNum);
			}
			if (hasMaxNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, maxNum);
			}
			if (hasOnApplication) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_BOOL(output, onApplication);
			}
			if (hasCorpsTitle) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, corpsTitle);
			}
			if (hasCorpsAnnouncement) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, corpsAnnouncement);
			}
			if (hasLeaderId) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, leaderId);
			}
			if (hasRunningFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_BOOL(output, runningFlag);
			}
			if (hasLevelrequired) {
				WriteUtils.writeTag(output, WireType.VARINT, 13);
				WriteUtils.write_TYPE_INT32(output, levelrequired);
			}
		}
		public function readExternal(input:IDataInput):void {
			var corpsIdCount:uint = 0;
			var corpsImgCount:uint = 0;
			var corpsNameCount:uint = 0;
			var corpsChiefCount:uint = 0;
			var corpsLevelCount:uint = 0;
			var curNumCount:uint = 0;
			var maxNumCount:uint = 0;
			var onApplicationCount:uint = 0;
			var corpsTitleCount:uint = 0;
			var corpsAnnouncementCount:uint = 0;
			var leaderIdCount:uint = 0;
			var runningFlagCount:uint = 0;
			var levelrequiredCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (corpsIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsIdCount;
					corpsId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (corpsImgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsImgCount;
					corpsImg = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (corpsNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsNameCount;
					corpsName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (corpsChiefCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsChiefCount;
					corpsChief = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (corpsLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsLevelCount;
					corpsLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (curNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curNumCount;
					curNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (maxNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxNumCount;
					maxNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (onApplicationCount != 0) {
						throw new IOError('Bad data format.');
					}
					++onApplicationCount;
					onApplication = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 9:
					if (corpsTitleCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsTitleCount;
					corpsTitle = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (corpsAnnouncementCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsAnnouncementCount;
					corpsAnnouncement = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (leaderIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++leaderIdCount;
					leaderId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 12:
					if (runningFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++runningFlagCount;
					runningFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 13:
					if (levelrequiredCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelrequiredCount;
					levelrequired = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
