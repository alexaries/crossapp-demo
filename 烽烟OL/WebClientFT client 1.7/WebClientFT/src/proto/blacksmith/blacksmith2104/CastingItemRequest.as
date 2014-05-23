package proto.blacksmith.blacksmith2104 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CastingItemRequest extends Message implements IExternalizable {
		public var id:int;
		public var castingItemId:int;
		private var consumeItemId_:int;
		private var hasConsumeItemId_:Boolean = false;
		public function get hasConsumeItemId():Boolean {
			return hasConsumeItemId_;
		}
		public function set consumeItemId(value:int):void {
			hasConsumeItemId_ = true;
			consumeItemId_ = value;
		}
		public function get consumeItemId():int {
			return consumeItemId_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, castingItemId);
			if (hasConsumeItemId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, consumeItemId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var castingItemIdCount:uint = 0;
			var consumeItemIdCount:uint = 0;
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
					if (castingItemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++castingItemIdCount;
					castingItemId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (consumeItemIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++consumeItemIdCount;
					consumeItemId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (castingItemIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
