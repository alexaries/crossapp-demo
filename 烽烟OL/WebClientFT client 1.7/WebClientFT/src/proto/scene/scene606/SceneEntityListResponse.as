package proto.scene.scene606 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.scene.SceneEntity;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SceneEntityListResponse extends Message implements IExternalizable {
		public var result:Boolean;
		[ArrayElementType("proto.scene.SceneEntity")]
		public var entitys:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_BOOL(output, result);
			for (var entitysIndex:uint = 0; entitysIndex < entitys.length; ++entitysIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, entitys[entitysIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var resultCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (resultCount != 0) {
						throw new IOError('Bad data format.');
					}
					++resultCount;
					result = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 2:
					entitys.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.scene.SceneEntity));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (resultCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
