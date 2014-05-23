package proto.copyScene.copyScene1506 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.copyScene.copyScene1506.FItemInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FMonsterInfo extends Message implements IExternalizable {
		public var lv:int;
		public var name:String;
		[ArrayElementType("proto.copyScene.copyScene1506.FItemInfo")]
		public var items:Array = [];
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, lv);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, name);
			for (var itemsIndex:uint = 0; itemsIndex < items.length; ++itemsIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, items[itemsIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var lvCount:uint = 0;
			var nameCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (lvCount != 0) {
						throw new IOError('Bad data format.');
					}
					++lvCount;
					lv = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					if (nameCount != 0) {
						throw new IOError('Bad data format.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					items.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.copyScene.copyScene1506.FItemInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (lvCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (nameCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
