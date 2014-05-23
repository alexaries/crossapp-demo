package proto.groupBattle.groupBattle4400 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GroupInfo extends Message implements IExternalizable {
		private var ldType_:int;
		private var hasLdType_:Boolean = false;
		public function get hasLdType():Boolean {
			return hasLdType_;
		}
		public function set ldType(value:int):void {
			hasLdType_ = true;
			ldType_ = value;
		}
		public function get ldType():int {
			return ldType_;
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
		private var groupLevel_:int;
		private var hasGroupLevel_:Boolean = false;
		public function get hasGroupLevel():Boolean {
			return hasGroupLevel_;
		}
		public function set groupLevel(value:int):void {
			hasGroupLevel_ = true;
			groupLevel_ = value;
		}
		public function get groupLevel():int {
			return groupLevel_;
		}
		private var groupLeader_:String;
		public function get hasGroupLeader():Boolean {
			return null != groupLeader_;
		}
		public function set groupLeader(value:String):void {
			groupLeader_ = value;
		}
		public function get groupLeader():String {
			return groupLeader_;
		}
		private var obtainJL_:Boolean;
		private var hasObtainJL_:Boolean = false;
		public function get hasObtainJL():Boolean {
			return hasObtainJL_;
		}
		public function set obtainJL(value:Boolean):void {
			hasObtainJL_ = true;
			obtainJL_ = value;
		}
		public function get obtainJL():Boolean {
			return obtainJL_;
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
		[ArrayElementType("String")]
		public var battleInfo:Array = [];
		private var battleTime_:int;
		private var hasBattleTime_:Boolean = false;
		public function get hasBattleTime():Boolean {
			return hasBattleTime_;
		}
		public function set battleTime(value:int):void {
			hasBattleTime_ = true;
			battleTime_ = value;
		}
		public function get battleTime():int {
			return battleTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasLdType) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, ldType);
			}
			if (hasGroupName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, groupName);
			}
			if (hasGroupLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, groupLevel);
			}
			if (hasGroupLeader) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, groupLeader);
			}
			if (hasObtainJL) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_BOOL(output, obtainJL);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			for (var battleInfoIndex:uint = 0; battleInfoIndex < battleInfo.length; ++battleInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, battleInfo[battleInfoIndex]);
			}
			if (hasBattleTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_INT32(output, battleTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var ldTypeCount:uint = 0;
			var groupNameCount:uint = 0;
			var groupLevelCount:uint = 0;
			var groupLeaderCount:uint = 0;
			var obtainJLCount:uint = 0;
			var iconCount:uint = 0;
			var battleTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (ldTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++ldTypeCount;
					ldType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (groupNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupNameCount;
					groupName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (groupLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupLevelCount;
					groupLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (groupLeaderCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupLeaderCount;
					groupLeader = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (obtainJLCount != 0) {
						throw new IOError('Bad data format.');
					}
					++obtainJLCount;
					obtainJL = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 6:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					battleInfo.push(ReadUtils.read_TYPE_STRING(input));
					break;
				case 8:
					if (battleTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++battleTimeCount;
					battleTime = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
