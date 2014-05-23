package proto.pratice.getRestRoomInfo {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class List extends Message implements IExternalizable {
		private var nap_:int;
		private var hasNap_:Boolean = false;
		public function get hasNap():Boolean {
			return hasNap_;
		}
		public function set nap(value:int):void {
			hasNap_ = true;
			nap_ = value;
		}
		public function get nap():int {
			return nap_;
		}
		private var lightSleep_:int;
		private var hasLightSleep_:Boolean = false;
		public function get hasLightSleep():Boolean {
			return hasLightSleep_;
		}
		public function set lightSleep(value:int):void {
			hasLightSleep_ = true;
			lightSleep_ = value;
		}
		public function get lightSleep():int {
			return lightSleep_;
		}
		private var peacefulSleep_:int;
		private var hasPeacefulSleep_:Boolean = false;
		public function get hasPeacefulSleep():Boolean {
			return hasPeacefulSleep_;
		}
		public function set peacefulSleep(value:int):void {
			hasPeacefulSleep_ = true;
			peacefulSleep_ = value;
		}
		public function get peacefulSleep():int {
			return peacefulSleep_;
		}
		private var spoor_:int;
		private var hasSpoor_:Boolean = false;
		public function get hasSpoor():Boolean {
			return hasSpoor_;
		}
		public function set spoor(value:int):void {
			hasSpoor_ = true;
			spoor_ = value;
		}
		public function get spoor():int {
			return spoor_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasNap) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, nap);
			}
			if (hasLightSleep) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, lightSleep);
			}
			if (hasPeacefulSleep) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, peacefulSleep);
			}
			if (hasSpoor) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, spoor);
			}
		}
		public function readExternal(input:IDataInput):void {
			var napCount:uint = 0;
			var lightSleepCount:uint = 0;
			var peacefulSleepCount:uint = 0;
			var spoorCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (napCount != 0) {
						throw new IOError('Bad data format.');
					}
					++napCount;
					nap = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (lightSleepCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lightSleepCount;
					lightSleep = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (peacefulSleepCount != 0) {
						throw new IOError('Bad data format.');
					}
					++peacefulSleepCount;
					peacefulSleep = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (spoorCount != 0) {
						throw new IOError('Bad data format.');
					}
					++spoorCount;
					spoor = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
