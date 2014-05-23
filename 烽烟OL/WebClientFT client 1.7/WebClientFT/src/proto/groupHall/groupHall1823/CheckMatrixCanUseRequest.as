package proto.groupHall.groupHall1823 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class CheckMatrixCanUseRequest extends Message implements IExternalizable {
		public var id:int;
		private var vipMatrix_:int;
		private var hasVipMatrix_:Boolean = false;
		public function get hasVipMatrix():Boolean {
			return hasVipMatrix_;
		}
		public function set vipMatrix(value:int):void {
			hasVipMatrix_ = true;
			vipMatrix_ = value;
		}
		public function get vipMatrix():int {
			return vipMatrix_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasVipMatrix) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, vipMatrix);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var vipMatrixCount:uint = 0;
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
					if (vipMatrixCount != 0) {
						throw new IOError('Bad data format.');
					}
					++vipMatrixCount;
					vipMatrix = ReadUtils.read_TYPE_INT32(input);
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
