package proto.calendar {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Bound extends Message implements IExternalizable {
		private var step_:int;
		private var hasStep_:Boolean = false;
		public function get hasStep():Boolean {
			return hasStep_;
		}
		public function set step(value:int):void {
			hasStep_ = true;
			step_ = value;
		}
		public function get step():int {
			return step_;
		}
		private var received_:int;
		private var hasReceived_:Boolean = false;
		public function get hasReceived():Boolean {
			return hasReceived_;
		}
		public function set received(value:int):void {
			hasReceived_ = true;
			received_ = value;
		}
		public function get received():int {
			return received_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasStep) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, step);
			}
			if (hasReceived) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, received);
			}
		}
		public function readExternal(input:IDataInput):void {
			var stepCount:uint = 0;
			var receivedCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (stepCount != 0) {
						throw new IOError('Bad data format.');
					}
					++stepCount;
					step = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (receivedCount != 0) {
						throw new IOError('Bad data format.');
					}
					++receivedCount;
					received = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
