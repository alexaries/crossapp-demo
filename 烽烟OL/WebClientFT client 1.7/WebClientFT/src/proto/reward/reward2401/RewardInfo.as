package proto.reward.reward2401 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RewardInfo extends Message implements IExternalizable {
		private var rId_:int;
		private var hasRId_:Boolean = false;
		public function get hasRId():Boolean {
			return hasRId_;
		}
		public function set rId(value:int):void {
			hasRId_ = true;
			rId_ = value;
		}
		public function get rId():int {
			return rId_;
		}
		private var rType_:int;
		private var hasRType_:Boolean = false;
		public function get hasRType():Boolean {
			return hasRType_;
		}
		public function set rType(value:int):void {
			hasRType_ = true;
			rType_ = value;
		}
		public function get rType():int {
			return rType_;
		}
		private var tName_:String;
		public function get hasTName():Boolean {
			return null != tName_;
		}
		public function set tName(value:String):void {
			tName_ = value;
		}
		public function get tName():String {
			return tName_;
		}
		private var tE1_:String;
		public function get hasTE1():Boolean {
			return null != tE1_;
		}
		public function set tE1(value:String):void {
			tE1_ = value;
		}
		public function get tE1():String {
			return tE1_;
		}
		private var tE2_:String;
		public function get hasTE2():Boolean {
			return null != tE2_;
		}
		public function set tE2(value:String):void {
			tE2_ = value;
		}
		public function get tE2():String {
			return tE2_;
		}
		private var tE3_:String;
		public function get hasTE3():Boolean {
			return null != tE3_;
		}
		public function set tE3(value:String):void {
			tE3_ = value;
		}
		public function get tE3():String {
			return tE3_;
		}
		private var tE4_:Boolean;
		private var hasTE4_:Boolean = false;
		public function get hasTE4():Boolean {
			return hasTE4_;
		}
		public function set tE4(value:Boolean):void {
			hasTE4_ = true;
			tE4_ = value;
		}
		public function get tE4():Boolean {
			return tE4_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasRId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, rId);
			}
			if (hasRType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, rType);
			}
			if (hasTName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, tName);
			}
			if (hasTE1) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, tE1);
			}
			if (hasTE2) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, tE2);
			}
			if (hasTE3) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, tE3);
			}
			if (hasTE4) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_BOOL(output, tE4);
			}
		}
		public function readExternal(input:IDataInput):void {
			var rIdCount:uint = 0;
			var rTypeCount:uint = 0;
			var tNameCount:uint = 0;
			var tE1Count:uint = 0;
			var tE2Count:uint = 0;
			var tE3Count:uint = 0;
			var tE4Count:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (rIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rIdCount;
					rId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (rTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rTypeCount;
					rType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (tNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tNameCount;
					tName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (tE1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++tE1Count;
					tE1 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (tE2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++tE2Count;
					tE2 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (tE3Count != 0) {
						throw new IOError('Bad data format.');
					}
					++tE3Count;
					tE3 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (tE4Count != 0) {
						throw new IOError('Bad data format.');
					}
					++tE4Count;
					tE4 = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
