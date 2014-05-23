package proto.shenchi.shenchi3400 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ShenGeInfo extends Message implements IExternalizable {
		private var sgID_:int;
		private var hasSgID_:Boolean = false;
		public function get hasSgID():Boolean {
			return hasSgID_;
		}
		public function set sgID(value:int):void {
			hasSgID_ = true;
			sgID_ = value;
		}
		public function get sgID():int {
			return sgID_;
		}
		private var sgType_:int;
		private var hasSgType_:Boolean = false;
		public function get hasSgType():Boolean {
			return hasSgType_;
		}
		public function set sgType(value:int):void {
			hasSgType_ = true;
			sgType_ = value;
		}
		public function get sgType():int {
			return sgType_;
		}
		private var sgName_:String;
		public function get hasSgName():Boolean {
			return null != sgName_;
		}
		public function set sgName(value:String):void {
			sgName_ = value;
		}
		public function get sgName():String {
			return sgName_;
		}
		private var activateFlag_:Boolean;
		private var hasActivateFlag_:Boolean = false;
		public function get hasActivateFlag():Boolean {
			return hasActivateFlag_;
		}
		public function set activateFlag(value:Boolean):void {
			hasActivateFlag_ = true;
			activateFlag_ = value;
		}
		public function get activateFlag():Boolean {
			return activateFlag_;
		}
		private var reqDQ_:int;
		private var hasReqDQ_:Boolean = false;
		public function get hasReqDQ():Boolean {
			return hasReqDQ_;
		}
		public function set reqDQ(value:int):void {
			hasReqDQ_ = true;
			reqDQ_ = value;
		}
		public function get reqDQ():int {
			return reqDQ_;
		}
		private var sgDes_:String;
		public function get hasSgDes():Boolean {
			return null != sgDes_;
		}
		public function set sgDes(value:String):void {
			sgDes_ = value;
		}
		public function get sgDes():String {
			return sgDes_;
		}
		private var level_:int;
		private var hasLevel_:Boolean = false;
		public function get hasLevel():Boolean {
			return hasLevel_;
		}
		public function set level(value:int):void {
			hasLevel_ = true;
			level_ = value;
		}
		public function get level():int {
			return level_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasSgID) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, sgID);
			}
			if (hasSgType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, sgType);
			}
			if (hasSgName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, sgName);
			}
			if (hasActivateFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_BOOL(output, activateFlag);
			}
			if (hasReqDQ) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, reqDQ);
			}
			if (hasSgDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, sgDes);
			}
			if (hasLevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, level);
			}
		}
		public function readExternal(input:IDataInput):void {
			var sgIDCount:uint = 0;
			var sgTypeCount:uint = 0;
			var sgNameCount:uint = 0;
			var activateFlagCount:uint = 0;
			var reqDQCount:uint = 0;
			var sgDesCount:uint = 0;
			var levelCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (sgIDCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sgIDCount;
					sgID = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (sgTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sgTypeCount;
					sgType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (sgNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sgNameCount;
					sgName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (activateFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++activateFlagCount;
					activateFlag = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 5:
					if (reqDQCount != 0) {
						throw new IOError('Bad data format.');
					}
					++reqDQCount;
					reqDQ = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (sgDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sgDesCount;
					sgDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (levelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelCount;
					level = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
