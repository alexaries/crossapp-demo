package proto.guanjue.guanjue3303 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	[Bindable]
	public final class Wupin extends Message implements IExternalizable {
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
		private var name_:String;
		public function get hasName():Boolean {
			return null != name_;
		}
		public function set name(value:String):void {
			name_ = value;
		}
		public function get name():String {
			return name_;
		}
		private var count_:int;
		private var hasCount_:Boolean = false;
		public function get hasCount():Boolean {
			return hasCount_;
		}
		public function set count(value:int):void {
			hasCount_ = true;
			count_ = value;
		}
		public function get count():int {
			return count_;
		}
		private var weiwang_:int;
		private var hasWeiwang_:Boolean = false;
		public function get hasWeiwang():Boolean {
			return hasWeiwang_;
		}
		public function set weiwang(value:int):void {
			hasWeiwang_ = true;
			weiwang_ = value;
		}
		public function get weiwang():int {
			return weiwang_;
		}
		private var adddq_:Boolean;
		private var hasAdddq_:Boolean = false;
		public function get hasAdddq():Boolean {
			return hasAdddq_;
		}
		public function set adddq(value:Boolean):void {
			hasAdddq_ = true;
			adddq_ = value;
		}
		public function get adddq():Boolean {
			return adddq_;
		}
		private var wy_:String;
		public function get hasWy():Boolean {
			return null != wy_;
		}
		public function set wy(value:String):void {
			wy_ = value;
		}
		public function get wy():String {
			return wy_;
		}
		private var addzuan_:Boolean;
		private var hasAddzuan_:Boolean = false;
		public function get hasAddzuan():Boolean {
			return hasAddzuan_;
		}
		public function set addzuan(value:Boolean):void {
			hasAddzuan_ = true;
			addzuan_ = value;
		}
		public function get addzuan():Boolean {
			return addzuan_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, id);
			}
			if (hasName) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, name);
			}
			if (hasCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, count);
			}
			if (hasWeiwang) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, weiwang);
			}
			if (hasAdddq) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_BOOL(output, adddq);
			}
			if (hasWy) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, wy);
			}
			if (hasAddzuan) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_BOOL(output, addzuan);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var nameCount:uint = 0;
			var countCount:uint = 0;
			var weiwangCount:uint = 0;
			var adddqCount:uint = 0;
			var wyCount:uint = 0;
			var addzuanCount:uint = 0;
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
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (countCount != 0) {
						throw new IOError('Bad data format.');
					}
					++countCount;
					count = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (weiwangCount != 0) {
						throw new IOError('Bad data format.');
					}
					++weiwangCount;
					weiwang = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (adddqCount != 0) {
						throw new IOError('Bad data format.');
					}
					++adddqCount;
					adddq = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 6:
					if (wyCount != 0) {
						throw new IOError('Bad data format.');
					}
					++wyCount;
					wy = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (addzuanCount != 0) {
						throw new IOError('Bad data format.');
					}
					++addzuanCount;
					addzuan = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
