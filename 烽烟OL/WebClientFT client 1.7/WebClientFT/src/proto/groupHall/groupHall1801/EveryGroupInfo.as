package proto.groupHall.groupHall1801 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class EveryGroupInfo extends Message implements IExternalizable {
		private var groupHallId_:int;
		private var hasGroupHallId_:Boolean = false;
		public function get hasGroupHallId():Boolean {
			return hasGroupHallId_;
		}
		public function set groupHallId(value:int):void {
			hasGroupHallId_ = true;
			groupHallId_ = value;
		}
		public function get groupHallId():int {
			return groupHallId_;
		}
		private var groupHallNumber_:int;
		private var hasGroupHallNumber_:Boolean = false;
		public function get hasGroupHallNumber():Boolean {
			return hasGroupHallNumber_;
		}
		public function set groupHallNumber(value:int):void {
			hasGroupHallNumber_ = true;
			groupHallNumber_ = value;
		}
		public function get groupHallNumber():int {
			return groupHallNumber_;
		}
		public var groupHallClock:Boolean;
		private var copySceneLevel_:int;
		private var hasCopySceneLevel_:Boolean = false;
		public function get hasCopySceneLevel():Boolean {
			return hasCopySceneLevel_;
		}
		public function set copySceneLevel(value:int):void {
			hasCopySceneLevel_ = true;
			copySceneLevel_ = value;
		}
		public function get copySceneLevel():int {
			return copySceneLevel_;
		}
		private var groupName_:String;
		public function get hasGroupName():Boolean {
			return null != groupName_;
		}
		public function set groupName(value:String):void {
			groupName_ = value;
		}
		public function get groupName():String {
			return groupName_;
		}
		private var curRoleNum_:int;
		private var hasCurRoleNum_:Boolean = false;
		public function get hasCurRoleNum():Boolean {
			return hasCurRoleNum_;
		}
		public function set curRoleNum(value:int):void {
			hasCurRoleNum_ = true;
			curRoleNum_ = value;
		}
		public function get curRoleNum():int {
			return curRoleNum_;
		}
		private var copySceneId_:int;
		private var hasCopySceneId_:Boolean = false;
		public function get hasCopySceneId():Boolean {
			return hasCopySceneId_;
		}
		public function set copySceneId(value:int):void {
			hasCopySceneId_ = true;
			copySceneId_ = value;
		}
		public function get copySceneId():int {
			return copySceneId_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasGroupHallId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, groupHallId);
			}
			if (hasGroupHallNumber) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, groupHallNumber);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_BOOL(output, groupHallClock);
			if (hasCopySceneLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, copySceneLevel);
			}
			if (hasGroupName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, groupName);
			}
			if (hasCurRoleNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, curRoleNum);
			}
			if (hasCopySceneId) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, copySceneId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var groupHallIdCount:uint = 0;
			var groupHallNumberCount:uint = 0;
			var groupHallClockCount:uint = 0;
			var copySceneLevelCount:uint = 0;
			var groupNameCount:uint = 0;
			var curRoleNumCount:uint = 0;
			var copySceneIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (groupHallIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupHallIdCount;
					groupHallId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (groupHallNumberCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupHallNumberCount;
					groupHallNumber = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (groupHallClockCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupHallClockCount;
					groupHallClock = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 4:
					if (copySceneLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++copySceneLevelCount;
					copySceneLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (groupNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupNameCount;
					groupName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (curRoleNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curRoleNumCount;
					curRoleNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (copySceneIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++copySceneIdCount;
					copySceneId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (groupHallClockCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
