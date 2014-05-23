package proto.reward.reward2404 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.reward.reward2404.BattleRoleInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BattleInfo extends Message implements IExternalizable {
		private var battleName_:String;
		public function get hasBattleName():Boolean {
			return null != battleName_;
		}
		public function set battleName(value:String):void {
			battleName_ = value;
		}
		public function get battleName():String {
			return battleName_;
		}
		private var battleResult_:Boolean;
		private var hasBattleResult_:Boolean = false;
		public function get hasBattleResult():Boolean {
			return hasBattleResult_;
		}
		public function set battleResult(value:Boolean):void {
			hasBattleResult_ = true;
			battleResult_ = value;
		}
		public function get battleResult():Boolean {
			return battleResult_;
		}
		[ArrayElementType("proto.reward.reward2404.BattleRoleInfo")]
		public var sucRoleInfo:Array = [];
		[ArrayElementType("proto.reward.reward2404.BattleRoleInfo")]
		public var failRoleInfo:Array = [];
		private var refreshTime_:String;
		public function get hasRefreshTime():Boolean {
			return null != refreshTime_;
		}
		public function set refreshTime(value:String):void {
			refreshTime_ = value;
		}
		public function get refreshTime():String {
			return refreshTime_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBattleName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, battleName);
			}
			if (hasBattleResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, battleResult);
			}
			for (var sucRoleInfoIndex:uint = 0; sucRoleInfoIndex < sucRoleInfo.length; ++sucRoleInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, sucRoleInfo[sucRoleInfoIndex]);
			}
			for (var failRoleInfoIndex:uint = 0; failRoleInfoIndex < failRoleInfo.length; ++failRoleInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, failRoleInfo[failRoleInfoIndex]);
			}
			if (hasRefreshTime) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, refreshTime);
			}
		}
		public function readExternal(input:IDataInput):void {
			var battleNameCount:uint = 0;
			var battleResultCount:uint = 0;
			var refreshTimeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (battleNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++battleNameCount;
					battleName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (battleResultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++battleResultCount;
					battleResult = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					sucRoleInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.reward.reward2404.BattleRoleInfo));
					break;
				case 4:
					failRoleInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.reward.reward2404.BattleRoleInfo));
					break;
				case 5:
					if (refreshTimeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++refreshTimeCount;
					refreshTime = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
