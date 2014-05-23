package proto.copyScene.copyScene1506 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FItemInfo extends Message implements IExternalizable {
		public var nowQuality:int;
		public var name:String;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, nowQuality);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, name);
		}
		public function readExternal(input:IDataInput):void {
			var nowQualityCount:uint = 0;
			var nameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (nowQualityCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nowQualityCount;
					nowQuality = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (nowQualityCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
