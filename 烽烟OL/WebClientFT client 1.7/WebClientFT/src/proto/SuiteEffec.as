package proto {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SuiteEffec extends Message implements IExternalizable {
		private var effectstr_:String;
		public function get hasEffectstr():Boolean {
			return null != effectstr_;
		}
		public function set effectstr(value:String):void {
			effectstr_ = value;
		}
		public function get effectstr():String {
			return effectstr_;
		}
		private var enable_:Boolean;
		private var hasEnable_:Boolean = false;
		public function get hasEnable():Boolean {
			return hasEnable_;
		}
		public function set enable(value:Boolean):void {
			hasEnable_ = true;
			enable_ = value;
		}
		public function get enable():Boolean {
			return enable_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasEffectstr) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, effectstr);
			}
			if (hasEnable) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, enable);
			}
		}
		public function readExternal(input:IDataInput):void {
			var effectstrCount:uint = 0;
			var enableCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (effectstrCount != 0) {
						throw new IOError('Bad data format.');
					}
					++effectstrCount;
					effectstr = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (enableCount != 0) {
						throw new IOError('Bad data format.');
					}
					++enableCount;
					enable = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
