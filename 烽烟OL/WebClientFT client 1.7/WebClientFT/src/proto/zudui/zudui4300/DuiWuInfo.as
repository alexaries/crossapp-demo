package proto.zudui.zudui4300 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class DuiWuInfo extends Message implements IExternalizable {
		private var dwId_:int;
		private var hasDwId_:Boolean = false;
		public function get hasDwId():Boolean {
			return hasDwId_;
		}
		public function set dwId(value:int):void {
			hasDwId_ = true;
			dwId_ = value;
		}
		public function get dwId():int {
			return dwId_;
		}
		private var dwType_:int;
		private var hasDwType_:Boolean = false;
		public function get hasDwType():Boolean {
			return hasDwType_;
		}
		public function set dwType(value:int):void {
			hasDwType_ = true;
			dwType_ = value;
		}
		public function get dwType():int {
			return dwType_;
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
		public function writeExternal(output:IDataOutput):void {
			if (hasDwId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, dwId);
			}
			if (hasDwType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, dwType);
			}
			if (hasCurNum) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, curNum);
			}
			if (hasLeaderName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, leaderName);
			}
		}
		public function readExternal(input:IDataInput):void {
			var dwIdCount:uint = 0;
			var dwTypeCount:uint = 0;
			var curNumCount:uint = 0;
			var leaderNameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (dwIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dwIdCount;
					dwId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (dwTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++dwTypeCount;
					dwType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (curNumCount != 0) {
						throw new IOError('Bad data format.');
					}
					++curNumCount;
					curNum = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (leaderNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++leaderNameCount;
					leaderName = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
