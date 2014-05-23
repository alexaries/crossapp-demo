package proto.battle.battle703 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FightRequest extends Message implements IExternalizable {
		public var id:int;
		public var tid:int;
		private var type_:int;
		private var hasType_:Boolean = false;
		public function get hasType():Boolean {
			return hasType_;
		}
		public function set type(value:int):void {
			hasType_ = true;
			type_ = value;
		}
		public function get type():int {
			return type_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, tid);
			if (hasType) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, type);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var tidCount:uint = 0;
			var typeCount:uint = 0;
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
					if (tidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++tidCount;
					tid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (typeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (tidCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
