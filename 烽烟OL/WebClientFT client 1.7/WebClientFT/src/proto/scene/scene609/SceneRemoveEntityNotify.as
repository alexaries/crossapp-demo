package proto.scene.scene609 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SceneRemoveEntityNotify extends Message implements IExternalizable {
		public var entityid:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, entityid);
		}
		public function readExternal(input:IDataInput):void {
			var entityidCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (entityidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++entityidCount;
					entityid = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (entityidCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
