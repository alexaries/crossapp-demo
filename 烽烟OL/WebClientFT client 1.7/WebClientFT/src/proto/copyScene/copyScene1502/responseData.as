package proto.copyScene.copyScene1502 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		private var placeId_:int;
		private var hasPlaceId_:Boolean = false;
		public function get hasPlaceId():Boolean {
			return hasPlaceId_;
		}
		public function set placeId(value:int):void {
			hasPlaceId_ = true;
			placeId_ = value;
		}
		public function get placeId():int {
			return placeId_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasPlaceId) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, placeId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var placeIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (placeIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++placeIdCount;
					placeId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
