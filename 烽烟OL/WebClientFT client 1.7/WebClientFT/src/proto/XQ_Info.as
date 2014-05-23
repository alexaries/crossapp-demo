package proto {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class XQ_Info extends Message implements IExternalizable {
		private var xqItemId1_:int;
		private var hasXqItemId1_:Boolean = false;
		public function get hasXqItemId1():Boolean {
			return hasXqItemId1_;
		}
		public function set xqItemId1(value:int):void {
			hasXqItemId1_ = true;
			xqItemId1_ = value;
		}
		public function get xqItemId1():int {
			return xqItemId1_;
		}
		private var xqDes1_:String;
		public function get hasXqDes1():Boolean {
			return null != xqDes1_;
		}
		public function set xqDes1(value:String):void {
			xqDes1_ = value;
		}
		public function get xqDes1():String {
			return xqDes1_;
		}
		private var xqItemId2_:int;
		private var hasXqItemId2_:Boolean = false;
		public function get hasXqItemId2():Boolean {
			return hasXqItemId2_;
		}
		public function set xqItemId2(value:int):void {
			hasXqItemId2_ = true;
			xqItemId2_ = value;
		}
		public function get xqItemId2():int {
			return xqItemId2_;
		}
		private var xqDes2_:String;
		public function get hasXqDes2():Boolean {
			return null != xqDes2_;
		}
		public function set xqDes2(value:String):void {
			xqDes2_ = value;
		}
		public function get xqDes2():String {
			return xqDes2_;
		}
		private var xqItemId3_:int;
		private var hasXqItemId3_:Boolean = false;
		public function get hasXqItemId3():Boolean {
			return hasXqItemId3_;
		}
		public function set xqItemId3(value:int):void {
			hasXqItemId3_ = true;
			xqItemId3_ = value;
		}
		public function get xqItemId3():int {
			return xqItemId3_;
		}
		private var xqDes3_:String;
		public function get hasXqDes3():Boolean {
			return null != xqDes3_;
		}
		public function set xqDes3(value:String):void {
			xqDes3_ = value;
		}
		public function get xqDes3():String {
			return xqDes3_;
		}
		private var xqItemId4_:int;
		private var hasXqItemId4_:Boolean = false;
		public function get hasXqItemId4():Boolean {
			return hasXqItemId4_;
		}
		public function set xqItemId4(value:int):void {
			hasXqItemId4_ = true;
			xqItemId4_ = value;
		}
		public function get xqItemId4():int {
			return xqItemId4_;
		}
		private var xqDes4_:String;
		public function get hasXqDes4():Boolean {
			return null != xqDes4_;
		}
		public function set xqDes4(value:String):void {
			xqDes4_ = value;
		}
		public function get xqDes4():String {
			return xqDes4_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasXqItemId1) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, xqItemId1);
			}
			if (hasXqDes1) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, xqDes1);
			}
			if (hasXqItemId2) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, xqItemId2);
			}
			if (hasXqDes2) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, xqDes2);
			}
			if (hasXqItemId3) {
				WriteUtils.writeTag(output, WireType.VARINT, 5);
				WriteUtils.write_TYPE_INT32(output, xqItemId3);
			}
			if (hasXqDes3) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, xqDes3);
			}
			if (hasXqItemId4) {
				WriteUtils.writeTag(output, WireType.VARINT, 7);
				WriteUtils.write_TYPE_INT32(output, xqItemId4);
			}
			if (hasXqDes4) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, xqDes4);
			}
		}
		public function readExternal(input:IDataInput):void {
			var xqItemId1Count:uint = 0;
			var xqDes1Count:uint = 0;
			var xqItemId2Count:uint = 0;
			var xqDes2Count:uint = 0;
			var xqItemId3Count:uint = 0;
			var xqDes3Count:uint = 0;
			var xqItemId4Count:uint = 0;
			var xqDes4Count:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (xqItemId1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqItemId1Count;
					xqItemId1 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (xqDes1Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqDes1Count;
					xqDes1 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (xqItemId2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqItemId2Count;
					xqItemId2 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (xqDes2Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqDes2Count;
					xqDes2 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (xqItemId3Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqItemId3Count;
					xqItemId3 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 6:
					if (xqDes3Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqDes3Count;
					xqDes3 = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (xqItemId4Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqItemId4Count;
					xqItemId4 = ReadUtils.read_TYPE_INT32(input);
					break;
				case 8:
					if (xqDes4Count != 0) {
						throw new IOError('Bad data format.');
					}
					++xqDes4Count;
					xqDes4 = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
