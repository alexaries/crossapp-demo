package proto.reward.reward2400 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class AnouInfo extends Message implements IExternalizable {
		private var anouType_:int;
		private var hasAnouType_:Boolean = false;
		public function get hasAnouType():Boolean {
			return hasAnouType_;
		}
		public function set anouType(value:int):void {
			hasAnouType_ = true;
			anouType_ = value;
		}
		public function get anouType():int {
			return anouType_;
		}
		private var surplusTimes_:int;
		private var hasSurplusTimes_:Boolean = false;
		public function get hasSurplusTimes():Boolean {
			return hasSurplusTimes_;
		}
		public function set surplusTimes(value:int):void {
			hasSurplusTimes_ = true;
			surplusTimes_ = value;
		}
		public function get surplusTimes():int {
			return surplusTimes_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasAnouType) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, anouType);
			}
			if (hasSurplusTimes) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, surplusTimes);
			}
		}
		public function readExternal(input:IDataInput):void {
			var anouTypeCount:uint = 0;
			var surplusTimesCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (anouTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++anouTypeCount;
					anouType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (surplusTimesCount != 0) {
						throw new IOError('Bad data format.');
					}
					++surplusTimesCount;
					surplusTimes = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
