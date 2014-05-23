package proto.vip.vip3800 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.vip.vip3800.VIPInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class ResponseDate extends Message implements IExternalizable {
		private var viplevel_:int;
		private var hasViplevel_:Boolean = false;
		public function get hasViplevel():Boolean {
			return hasViplevel_;
		}
		public function set viplevel(value:int):void {
			hasViplevel_ = true;
			viplevel_ = value;
		}
		public function get viplevel():int {
			return viplevel_;
		}
		private var exp_:int;
		private var hasExp_:Boolean = false;
		public function get hasExp():Boolean {
			return hasExp_;
		}
		public function set exp(value:int):void {
			hasExp_ = true;
			exp_ = value;
		}
		public function get exp():int {
			return exp_;
		}
		private var maxexp_:int;
		private var hasMaxexp_:Boolean = false;
		public function get hasMaxexp():Boolean {
			return hasMaxexp_;
		}
		public function set maxexp(value:int):void {
			hasMaxexp_ = true;
			maxexp_ = value;
		}
		public function get maxexp():int {
			return maxexp_;
		}
		private var msg_:String;
		public function get hasMsg():Boolean {
			return null != msg_;
		}
		public function set msg(value:String):void {
			msg_ = value;
		}
		public function get msg():String {
			return msg_;
		}
		[ArrayElementType("proto.vip.vip3800.VIPInfo")]
		public var vipinfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasViplevel) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, viplevel);
			}
			if (hasExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, exp);
			}
			if (hasMaxexp) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, maxexp);
			}
			if (hasMsg) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, msg);
			}
			for (var vipinfoIndex:uint = 0; vipinfoIndex < vipinfo.length; ++vipinfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, vipinfo[vipinfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var viplevelCount:uint = 0;
			var expCount:uint = 0;
			var maxexpCount:uint = 0;
			var msgCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (viplevelCount != 0) {
						throw new IOError('Bad data format.');
					}
					++viplevelCount;
					viplevel = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (expCount != 0) {
						throw new IOError('Bad data format.');
					}
					++expCount;
					exp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (maxexpCount != 0) {
						throw new IOError('Bad data format.');
					}
					++maxexpCount;
					maxexp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (msgCount != 0) {
						throw new IOError('Bad data format.');
					}
					++msgCount;
					msg = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					vipinfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.vip.vip3800.VIPInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
