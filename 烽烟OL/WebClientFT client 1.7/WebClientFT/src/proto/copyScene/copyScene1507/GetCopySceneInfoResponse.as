package proto.copyScene.copyScene1507 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetCopySceneInfoResponse extends Message implements IExternalizable {
		private var result_:Boolean;
		private var hasResult_:Boolean = false;
		public function get hasResult():Boolean {
			return hasResult_;
		}
		public function set result(value:Boolean):void {
			hasResult_ = true;
			result_ = value;
		}
		public function get result():Boolean {
			return result_;
		}
		private var message_:String;
		public function get hasMessage():Boolean {
			return null != message_;
		}
		public function set message(value:String):void {
			message_ = value;
		}
		public function get message():String {
			return message_;
		}
		private var monsterNum_:int;
		private var hasMonsterNum_:Boolean = false;
		public function get hasMonsterNum():Boolean {
			return hasMonsterNum_;
		}
		public function set monsterNum(value:int):void {
			hasMonsterNum_ = true;
			monsterNum_ = value;
		}
		public function get monsterNum():int {
			return monsterNum_;
		}
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
		private var rewardId_:int;
		private var hasRewardId_:Boolean = false;
		public function get hasRewardId():Boolean {
			return hasRewardId_;
		}
		public function set rewardId(value:int):void {
			hasRewardId_ = true;
			rewardId_ = value;
		}
		public function get rewardId():int {
			return rewardId_;
		}
		private var rewardName_:String;
		public function get hasRewardName():Boolean {
			return null != rewardName_;
		}
		public function set rewardName(value:String):void {
			rewardName_ = value;
		}
		public function get rewardName():String {
			return rewardName_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasMonsterNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, monsterNum);
			}
			if (hasCorpsId) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, corpsId);
			}
			if (hasCorpsName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, corpsName);
			}
			if (hasRewardId) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, rewardId);
			}
			if (hasRewardName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, rewardName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			var messageCount:uint = 0;
			var monsterNumCount:uint = 0;
			var corpsIdCount:uint = 0;
			var corpsNameCount:uint = 0;
			var rewardIdCount:uint = 0;
			var rewardNameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (monsterNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++monsterNumCount;
					monsterNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (corpsIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsIdCount;
					corpsId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (corpsNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsNameCount;
					corpsName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (rewardIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rewardIdCount;
					rewardId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (rewardNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rewardNameCount;
					rewardName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
