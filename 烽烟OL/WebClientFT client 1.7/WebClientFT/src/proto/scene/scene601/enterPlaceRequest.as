package proto.scene.scene601 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class enterPlaceRequest extends Message implements IExternalizable {
		public var id:int;
		public var placeId:int;
		private var force_:Boolean;
		private var hasForce_:Boolean = false;
		public function get hasForce():Boolean {
			return hasForce_;
		}
		public function set force(value:Boolean):void {
			hasForce_ = true;
			force_ = value;
		}
		public function get force():Boolean {
			return force_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, placeId);
			if (hasForce) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_BOOL(output, force);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var placeIdCount:uint = 0;
			var forceCount:uint = 0;
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
					if (placeIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++placeIdCount;
					placeId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (forceCount != 0) {
						throw new IOError('Bad data format.');
					}
					++forceCount;
					force = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (placeIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
