package proto.copyScene.copyScene1506 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.copyScene.copyScene1506.item;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class responseData extends Message implements IExternalizable {
		public var levelState:int;
		[ArrayElementType("proto.copyScene.copyScene1506.item")]
		public var info:Array = [];
		private var csz_:int;
		private var hasCsz_:Boolean = false;
		public function get hasCsz():Boolean {
			return hasCsz_;
		}
		public function set csz(value:int):void {
			hasCsz_ = true;
			csz_ = value;
		}
		public function get csz():int {
			return csz_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, levelState);
			for (var infoIndex:uint = 0; infoIndex < info.length; ++infoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, info[infoIndex]);
			}
			if (hasCsz) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, csz);
			}
		}
		public function readExternal(input:IDataInput):void {
			var levelStateCount:uint = 0;
			var cszCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (levelStateCount != 0) {
						throw new IOError('Bad data format.');
					}
					++levelStateCount;
					levelState = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					info.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.copyScene.copyScene1506.item));
					break;
				case 3:
					if (cszCount != 0) {
						throw new IOError('Bad data format.');
					}
					++cszCount;
					csz = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (levelStateCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
