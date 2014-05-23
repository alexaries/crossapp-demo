package proto.blacksmith.blacksmith2103 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BlacksmithCastingInfoRequest extends Message implements IExternalizable {
		public var id:int;
		private var castingId_:int;
		private var hasCastingId_:Boolean = false;
		public function get hasCastingId():Boolean {
			return hasCastingId_;
		}
		public function set castingId(value:int):void {
			hasCastingId_ = true;
			castingId_ = value;
		}
		public function get castingId():int {
			return castingId_;
		}
		private var consumeId_:int;
		private var hasConsumeId_:Boolean = false;
		public function get hasConsumeId():Boolean {
			return hasConsumeId_;
		}
		public function set consumeId(value:int):void {
			hasConsumeId_ = true;
			consumeId_ = value;
		}
		public function get consumeId():int {
			return consumeId_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasCastingId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, castingId);
			}
			if (hasConsumeId) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, consumeId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var castingIdCount:uint = 0;
			var consumeIdCount:uint = 0;
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
					if (castingIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++castingIdCount;
					castingId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (consumeIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++consumeIdCount;
					consumeId = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
