package proto.scene {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CorpsInfo extends Message implements IExternalizable {
		private var joinCorpsFlag_:Boolean;
		private var hasJoinCorpsFlag_:Boolean = false;
		public function get hasJoinCorpsFlag():Boolean {
			return hasJoinCorpsFlag_;
		}
		public function set joinCorpsFlag(value:Boolean):void {
			hasJoinCorpsFlag_ = true;
			joinCorpsFlag_ = value;
		}
		public function get joinCorpsFlag():Boolean {
			return joinCorpsFlag_;
		}
		private var corpsPosition_:int;
		private var hasCorpsPosition_:Boolean = false;
		public function get hasCorpsPosition():Boolean {
			return hasCorpsPosition_;
		}
		public function set corpsPosition(value:int):void {
			hasCorpsPosition_ = true;
			corpsPosition_ = value;
		}
		public function get corpsPosition():int {
			return corpsPosition_;
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
		public function writeExternal(output:IDataOutput):void {
			if (hasJoinCorpsFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_BOOL(output, joinCorpsFlag);
			}
			if (hasCorpsPosition) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, corpsPosition);
			}
			if (hasCorpsName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, corpsName);
			}
			if (hasCorpsLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, corpsLevel);
			}
		}
		public function readExternal(input:IDataInput):void {
			var joinCorpsFlagCount:uint = 0;
			var corpsPositionCount:uint = 0;
			var corpsNameCount:uint = 0;
			var corpsLevelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (joinCorpsFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++joinCorpsFlagCount;
					joinCorpsFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					if (corpsPositionCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsPositionCount;
					corpsPosition = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (corpsNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsNameCount;
					corpsName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (corpsLevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++corpsLevelCount;
					corpsLevel = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
