package proto.tavern.tavern3500 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetTavernListInfoRequest extends Message implements IExternalizable {
		public var id:int;
		public var npcId:int;
		private var istrue_:Boolean;
		private var hasIstrue_:Boolean = false;
		public function get hasIstrue():Boolean {
			return hasIstrue_;
		}
		public function set istrue(value:Boolean):void {
			hasIstrue_ = true;
			istrue_ = value;
		}
		public function get istrue():Boolean {
			return istrue_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, npcId);
			if (hasIstrue) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_BOOL(output, istrue);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var npcIdCount:uint = 0;
			var istrueCount:uint = 0;
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
					if (npcIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++npcIdCount;
					npcId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (istrueCount != 0) {
						throw new IOError('Bad data format.');
					}
					++istrueCount;
					istrue = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (npcIdCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
