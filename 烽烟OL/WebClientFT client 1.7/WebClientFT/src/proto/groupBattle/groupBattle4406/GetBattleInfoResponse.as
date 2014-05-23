package proto.groupBattle.groupBattle4406 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.groupBattle.groupBattle4406.GroupBattleInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetBattleInfoResponse extends Message implements IExternalizable {
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
		private var groupBattleInfo_:proto.groupBattle.groupBattle4406.GroupBattleInfo;
		public function get hasGroupBattleInfo():Boolean {
			return null != groupBattleInfo_;
		}
		public function set groupBattleInfo(value:proto.groupBattle.groupBattle4406.GroupBattleInfo):void {
			groupBattleInfo_ = value;
		}
		public function get groupBattleInfo():proto.groupBattle.groupBattle4406.GroupBattleInfo {
			return groupBattleInfo_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, message);
			}
			if (hasResult) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, result);
			}
			if (hasGroupBattleInfo) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, groupBattleInfo);
			}
		}
		public function readExternal(input:IDataInput):void {
			var messageCount:uint = 0;
			var resultCount:uint = 0;
			var groupBattleInfoCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (messageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++messageCount;
					message = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 3:
					if (groupBattleInfoCount != 0) {
						throw new IOError('Bad data format.');
					}
					++groupBattleInfoCount;
					groupBattleInfo = new proto.groupBattle.groupBattle4406.GroupBattleInfo;
					ReadUtils.read_TYPE_MESSAGE(input, groupBattleInfo);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
