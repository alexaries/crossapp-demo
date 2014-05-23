package proto.sysOpe.sysOpe2900 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GuaJiInfo extends Message implements IExternalizable {
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
		private var time_:int;
		private var hasTime_:Boolean = false;
		public function get hasTime():Boolean {
			return hasTime_;
		}
		public function set time(value:int):void {
			hasTime_ = true;
			time_ = value;
		}
		public function get time():int {
			return time_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasExp) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, exp);
			}
			if (hasTime) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, time);
			}
		}
		public function readExternal(input:IDataInput):void {
			var expCount:uint = 0;
			var timeCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (expCount != 0) {
						throw new IOError('Bad data format.');
					}
					++expCount;
					exp = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (timeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++timeCount;
					time = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
