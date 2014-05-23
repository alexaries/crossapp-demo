package proto.zhanxing.zhanxing3607 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class OpeXingXunRequest extends Message implements IExternalizable {
		public var id:int;
		private var opeId_:int;
		private var hasOpeId_:Boolean = false;
		public function get hasOpeId():Boolean {
			return hasOpeId_;
		}
		public function set opeId(value:int):void {
			hasOpeId_ = true;
			opeId_ = value;
		}
		public function get opeId():int {
			return opeId_;
		}
		public var opeType:int;
		public var fromPos:int;
		public var toPos:int;
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasOpeId) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, opeId);
			}
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, opeType);
			WriteUtils.writeTag(output, WireType.VARINT, 4);
			WriteUtils.write_TYPE_INT32(output, fromPos);
			WriteUtils.writeTag(output, WireType.VARINT, 5);
			WriteUtils.write_TYPE_INT32(output, toPos);
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var opeIdCount:uint = 0;
			var opeTypeCount:uint = 0;
			var fromPosCount:uint = 0;
			var toPosCount:uint = 0;
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
					if (opeIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++opeIdCount;
					opeId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (opeTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++opeTypeCount;
					opeType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (fromPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fromPosCount;
					fromPos = ReadUtils.read_TYPE_INT32(input);
					break;
				case 5:
					if (toPosCount != 0) {
						throw new IOError('Bad data format.');
					}
					++toPosCount;
					toPos = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (opeTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (fromPosCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (toPosCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
