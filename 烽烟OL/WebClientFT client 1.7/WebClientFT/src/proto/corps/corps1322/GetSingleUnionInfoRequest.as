package proto.corps.corps1322 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetSingleUnionInfoRequest extends Message implements IExternalizable {
		public var id:int;
		private var unionId_:int;
		private var hasUnionId_:Boolean = false;
		public function get hasUnionId():Boolean {
			return hasUnionId_;
		}
		public function set unionId(value:int):void {
			hasUnionId_ = true;
			unionId_ = value;
		}
		public function get unionId():int {
			return unionId_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasUnionId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, unionId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var unionIdCount:uint = 0;
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
					if (unionIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++unionIdCount;
					unionId = ReadUtils.read_TYPE_INT32(input);
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
