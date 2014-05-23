package proto.scene.scene603 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class moveInSceneRequest extends Message implements IExternalizable {
		public var id:int;
		public var sceneId:int;
		public var x:int;
		public var y:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, sceneId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, x);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, y);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var sceneIdCount:uint = 0;
			var xCount:uint = 0;
			var yCount:uint = 0;
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
					if (sceneIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sceneIdCount;
					sceneId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (xCount != 0) {
						throw new IOError('Bad data format.');
					}
					++xCount;
					x = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (yCount != 0) {
						throw new IOError('Bad data format.');
					}
					++yCount;
					y = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sceneIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (xCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (yCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
