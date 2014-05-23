package proto.scene.scene222 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BuffInfo extends Message implements IExternalizable {
		private var buffId_:int;
		private var hasBuffId_:Boolean = false;
		public function get hasBuffId():Boolean {
			return hasBuffId_;
		}
		public function set buffId(value:int):void {
			hasBuffId_ = true;
			buffId_ = value;
		}
		public function get buffId():int {
			return buffId_;
		}
		private var buffName_:String;
		public function get hasBuffName():Boolean {
			return null != buffName_;
		}
		public function set buffName(value:String):void {
			buffName_ = value;
		}
		public function get buffName():String {
			return buffName_;
		}
		private var buffDes_:String;
		public function get hasBuffDes():Boolean {
			return null != buffDes_;
		}
		public function set buffDes(value:String):void {
			buffDes_ = value;
		}
		public function get buffDes():String {
			return buffDes_;
		}
		private var type_:int;
		private var hasType_:Boolean = false;
		public function get hasType():Boolean {
			return hasType_;
		}
		public function set type(value:int):void {
			hasType_ = true;
			type_ = value;
		}
		public function get type():int {
			return type_;
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
		private var timeAndCountFlag_:int;
		private var hasTimeAndCountFlag_:Boolean = false;
		public function get hasTimeAndCountFlag():Boolean {
			return hasTimeAndCountFlag_;
		}
		public function set timeAndCountFlag(value:int):void {
			hasTimeAndCountFlag_ = true;
			timeAndCountFlag_ = value;
		}
		public function get timeAndCountFlag():int {
			return timeAndCountFlag_;
		}
		private var timeOrCount_:int;
		private var hasTimeOrCount_:Boolean = false;
		public function get hasTimeOrCount():Boolean {
			return hasTimeOrCount_;
		}
		public function set timeOrCount(value:int):void {
			hasTimeOrCount_ = true;
			timeOrCount_ = value;
		}
		public function get timeOrCount():int {
			return timeOrCount_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasBuffId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, buffId);
			}
			if (hasBuffName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, buffName);
			}
			if (hasBuffDes) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, buffDes);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, type);
			}
			if (hasIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, icon);
			}
			if (hasTimeAndCountFlag) {
				WriteUtils.writeTag(output, WireType.VARINT, 6);
				WriteUtils.write_TYPE_INT32(output, timeAndCountFlag);
			}
			if (hasTimeOrCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, timeOrCount);
			}
		}
		public function readExternal(input:IDataInput):void {
			var buffIdCount:uint = 0;
			var buffNameCount:uint = 0;
			var buffDesCount:uint = 0;
			var typeCount:uint = 0;
			var iconCount:uint = 0;
			var timeAndCountFlagCount:uint = 0;
			var timeOrCountCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (buffIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffIdCount;
					buffId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (buffNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffNameCount;
					buffName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (buffDesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++buffDesCount;
					buffDes = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (iconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++iconCount;
					icon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (timeAndCountFlagCount != 0) {
						throw new IOError('Bad data format.');
					}
					++timeAndCountFlagCount;
					timeAndCountFlag = ReadUtils.read_TYPE_INT32(input);
					break;
				case 7:
					if (timeOrCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++timeOrCountCount;
					timeOrCount = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
