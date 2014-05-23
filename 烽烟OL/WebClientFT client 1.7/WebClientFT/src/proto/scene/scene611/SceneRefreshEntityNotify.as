package proto.scene.scene611 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.SceneEntity;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SceneRefreshEntityNotify extends Message implements IExternalizable {
		public var entity:proto.scene.SceneEntity;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_MESSAGE(output, entity);
		}
		public function readExternal(input:IDataInput):void {
			var entityCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (entityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++entityCount;
					entity = new proto.scene.SceneEntity;
					ReadUtils.read_TYPE_MESSAGE(input, entity);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (entityCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
