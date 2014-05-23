package proto.tavern.tavern3503 {
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
		private var page_:int;
		private var hasPage_:Boolean = false;
		public function get hasPage():Boolean {
			return hasPage_;
		}
		public function set page(value:int):void {
			hasPage_ = true;
			page_ = value;
		}
		public function get page():int {
			return page_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, npcId);
			if (hasPage) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, page);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var npcIdCount:uint = 0;
			var pageCount:uint = 0;
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
					if (pageCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pageCount;
					page = ReadUtils.read_TYPE_INT32(input);
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
