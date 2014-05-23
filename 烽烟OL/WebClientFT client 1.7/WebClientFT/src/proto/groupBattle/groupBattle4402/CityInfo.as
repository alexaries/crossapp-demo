package proto.groupBattle.groupBattle4402 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CityInfo extends Message implements IExternalizable {
		private var lzName_:String;
		public function get hasLzName():Boolean {
			return null != lzName_;
		}
		public function set lzName(value:String):void {
			lzName_ = value;
		}
		public function get lzName():String {
			return lzName_;
		}
		private var lzIcon_:int;
		private var hasLzIcon_:Boolean = false;
		public function get hasLzIcon():Boolean {
			return hasLzIcon_;
		}
		public function set lzIcon(value:int):void {
			hasLzIcon_ = true;
			lzIcon_ = value;
		}
		public function get lzIcon():int {
			return lzIcon_;
		}
		private var tzName_:String;
		public function get hasTzName():Boolean {
			return null != tzName_;
		}
		public function set tzName(value:String):void {
			tzName_ = value;
		}
		public function get tzName():String {
			return tzName_;
		}
		private var tzIcon_:int;
		private var hasTzIcon_:Boolean = false;
		public function get hasTzIcon():Boolean {
			return hasTzIcon_;
		}
		public function set tzIcon(value:int):void {
			hasTzIcon_ = true;
			tzIcon_ = value;
		}
		public function get tzIcon():int {
			return tzIcon_;
		}
		private var btnState_:int;
		private var hasBtnState_:Boolean = false;
		public function get hasBtnState():Boolean {
			return hasBtnState_;
		}
		public function set btnState(value:int):void {
			hasBtnState_ = true;
			btnState_ = value;
		}
		public function get btnState():int {
			return btnState_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasLzName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, lzName);
			}
			if (hasLzIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, lzIcon);
			}
			if (hasTzName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, tzName);
			}
			if (hasTzIcon) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, tzIcon);
			}
			if (hasBtnState) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, btnState);
			}
		}
		public function readExternal(input:IDataInput):void {
			var lzNameCount:uint = 0;
			var lzIconCount:uint = 0;
			var tzNameCount:uint = 0;
			var tzIconCount:uint = 0;
			var btnStateCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (lzNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lzNameCount;
					lzName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (lzIconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lzIconCount;
					lzIcon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (tzNameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tzNameCount;
					tzName = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (tzIconCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tzIconCount;
					tzIcon = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (btnStateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++btnStateCount;
					btnState = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
