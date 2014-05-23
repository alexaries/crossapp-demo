package proto.copyScene.copyScene1506 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.copyScene.copyScene1506.FMonsterInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class item extends Message implements IExternalizable {
		private var id_:int;
		private var hasId_:Boolean = false;
		public function get hasId():Boolean {
			return hasId_;
		}
		public function set id(value:int):void {
			hasId_ = true;
			id_ = value;
		}
		public function get id():int {
			return id_;
		}
		private var state_:int;
		private var hasState_:Boolean = false;
		public function get hasState():Boolean {
			return hasState_;
		}
		public function set state(value:int):void {
			hasState_ = true;
			state_ = value;
		}
		public function get state():int {
			return state_;
		}
		[ArrayElementType("int")]
		public var instanceList:Array = [];
		[ArrayElementType("proto.copyScene.copyScene1506.FMonsterInfo")]
		public var monsterinfos:Array = [];
		private var score_:int;
		private var hasScore_:Boolean = false;
		public function get hasScore():Boolean {
			return hasScore_;
		}
		public function set score(value:int):void {
			hasScore_ = true;
			score_ = value;
		}
		public function get score():int {
			return score_;
		}
		private var unionId_:int;
		private var hasUnionId_:Boolean = false;
		public function get hasUnionId():Boolean {
			return hasUnionId_;
		}
		public function set unionId(value:int):void {
			hasUnionId_ = true;
			unionId_ = value;
		}
		public function get unionId():int {
			return unionId_;
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
		private var unionName_:String;
		public function get hasUnionName():Boolean {
			return null != unionName_;
		}
		public function set unionName(value:String):void {
			unionName_ = value;
		}
		public function get unionName():String {
			return unionName_;
		}
		private var leaderName_:String;
		public function get hasLeaderName():Boolean {
			return null != leaderName_;
		}
		public function set leaderName(value:String):void {
			leaderName_ = value;
		}
		public function get leaderName():String {
			return leaderName_;
		}
		private var camp_:int;
		private var hasCamp_:Boolean = false;
		public function get hasCamp():Boolean {
			return hasCamp_;
		}
		public function set camp(value:int):void {
			hasCamp_ = true;
			camp_ = value;
		}
		public function get camp():int {
			return camp_;
		}
		[ArrayElementType("int")]
		public var stateList:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasState) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, state);
			}
			for (var instanceListIndex:uint = 0; instanceListIndex < instanceList.length; ++instanceListIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, instanceList[instanceListIndex]);
			}
			for (var monsterinfosIndex:uint = 0; monsterinfosIndex < monsterinfos.length; ++monsterinfosIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, monsterinfos[monsterinfosIndex]);
			}
			if (hasScore) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, score);
			}
			if (hasUnionId) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, unionId);
			}
			if (hasLeaderId) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, leaderId);
			}
			if (hasUnionName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, unionName);
			}
			if (hasLeaderName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, leaderName);
			}
			if (hasCamp) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_INT32(output, camp);
			}
			for (var stateListIndex:uint = 0; stateListIndex < stateList.length; ++stateListIndex) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_INT32(output, stateList[stateListIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var stateCount:uint = 0;
			var scoreCount:uint = 0;
			var unionIdCount:uint = 0;
			var leaderIdCount:uint = 0;
			var unionNameCount:uint = 0;
			var leaderNameCount:uint = 0;
			var campCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (stateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stateCount;
					state = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, instanceList);
					break;
					}
					instanceList.push(ReadUtils.read_TYPE_INT32(input));
					break;
				case 4:
					monsterinfos.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.copyScene.copyScene1506.FMonsterInfo));
					break;
				case 5:
					if (scoreCount != 0) {
						throw new IOError('Bad data format.');
					}
					++scoreCount;
					score = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (unionIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionIdCount;
					unionId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (leaderIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++leaderIdCount;
					leaderId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (unionNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionNameCount;
					unionName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (leaderNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++leaderNameCount;
					leaderName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (campCount != 0) {
						throw new IOError('Bad data format.');
					}
					++campCount;
					camp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 11:
					if (tag.wireType == WireType.LENGTH_DELIMITED) {
						ReadUtils.readPackedRepeated(input, ReadUtils.read_TYPE_INT32, stateList);
					break;
					}
					stateList.push(ReadUtils.read_TYPE_INT32(input));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
