package proto.vip.vip3800 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class VIPInfo extends Message implements IExternalizable {
		private var funcname_:String;
		public function get hasFuncname():Boolean {
			return null != funcname_;
		}
		public function set funcname(value:String):void {
			funcname_ = value;
		}
		public function get funcname():String {
			return funcname_;
		}
		private var vip1cnt_:String;
		public function get hasVip1cnt():Boolean {
			return null != vip1cnt_;
		}
		public function set vip1cnt(value:String):void {
			vip1cnt_ = value;
		}
		public function get vip1cnt():String {
			return vip1cnt_;
		}
		private var vip2cnt_:String;
		public function get hasVip2cnt():Boolean {
			return null != vip2cnt_;
		}
		public function set vip2cnt(value:String):void {
			vip2cnt_ = value;
		}
		public function get vip2cnt():String {
			return vip2cnt_;
		}
		private var vip3cnt_:String;
		public function get hasVip3cnt():Boolean {
			return null != vip3cnt_;
		}
		public function set vip3cnt(value:String):void {
			vip3cnt_ = value;
		}
		public function get vip3cnt():String {
			return vip3cnt_;
		}
		private var vip4cnt_:String;
		public function get hasVip4cnt():Boolean {
			return null != vip4cnt_;
		}
		public function set vip4cnt(value:String):void {
			vip4cnt_ = value;
		}
		public function get vip4cnt():String {
			return vip4cnt_;
		}
		private var vip5cnt_:String;
		public function get hasVip5cnt():Boolean {
			return null != vip5cnt_;
		}
		public function set vip5cnt(value:String):void {
			vip5cnt_ = value;
		}
		public function get vip5cnt():String {
			return vip5cnt_;
		}
		private var vip6cnt_:String;
		public function get hasVip6cnt():Boolean {
			return null != vip6cnt_;
		}
		public function set vip6cnt(value:String):void {
			vip6cnt_ = value;
		}
		public function get vip6cnt():String {
			return vip6cnt_;
		}
		private var vip7cnt_:String;
		public function get hasVip7cnt():Boolean {
			return null != vip7cnt_;
		}
		public function set vip7cnt(value:String):void {
			vip7cnt_ = value;
		}
		public function get vip7cnt():String {
			return vip7cnt_;
		}
		private var vip8cnt_:String;
		public function get hasVip8cnt():Boolean {
			return null != vip8cnt_;
		}
		public function set vip8cnt(value:String):void {
			vip8cnt_ = value;
		}
		public function get vip8cnt():String {
			return vip8cnt_;
		}
		private var vip9cnt_:String;
		public function get hasVip9cnt():Boolean {
			return null != vip9cnt_;
		}
		public function set vip9cnt(value:String):void {
			vip9cnt_ = value;
		}
		public function get vip9cnt():String {
			return vip9cnt_;
		}
		private var vip10cnt_:String;
		public function get hasVip10cnt():Boolean {
			return null != vip10cnt_;
		}
		public function set vip10cnt(value:String):void {
			vip10cnt_ = value;
		}
		public function get vip10cnt():String {
			return vip10cnt_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasFuncname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, funcname);
			}
			if (hasVip1cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, vip1cnt);
			}
			if (hasVip2cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, vip2cnt);
			}
			if (hasVip3cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, vip3cnt);
			}
			if (hasVip4cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, vip4cnt);
			}
			if (hasVip5cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, vip5cnt);
			}
			if (hasVip6cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, vip6cnt);
			}
			if (hasVip7cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_STRING(output, vip7cnt);
			}
			if (hasVip8cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_STRING(output, vip8cnt);
			}
			if (hasVip9cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_STRING(output, vip9cnt);
			}
			if (hasVip10cnt) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 11);
				WriteUtils.write_TYPE_STRING(output, vip10cnt);
			}
		}
		public function readExternal(input:IDataInput):void {
			var funcnameCount:uint = 0;
			var vip1cntCount:uint = 0;
			var vip2cntCount:uint = 0;
			var vip3cntCount:uint = 0;
			var vip4cntCount:uint = 0;
			var vip5cntCount:uint = 0;
			var vip6cntCount:uint = 0;
			var vip7cntCount:uint = 0;
			var vip8cntCount:uint = 0;
			var vip9cntCount:uint = 0;
			var vip10cntCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (funcnameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++funcnameCount;
					funcname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (vip1cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip1cntCount;
					vip1cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (vip2cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip2cntCount;
					vip2cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (vip3cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip3cntCount;
					vip3cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (vip4cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip4cntCount;
					vip4cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (vip5cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip5cntCount;
					vip5cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (vip6cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip6cntCount;
					vip6cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (vip7cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip7cntCount;
					vip7cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 9:
					if (vip8cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip8cntCount;
					vip8cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 10:
					if (vip9cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip9cntCount;
					vip9cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				case 11:
					if (vip10cntCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vip10cntCount;
					vip10cnt = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
