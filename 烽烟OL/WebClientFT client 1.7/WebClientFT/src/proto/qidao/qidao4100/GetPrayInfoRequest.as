package proto.qidao.qidao4100 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetPrayInfoRequest extends Message implements IExternalizable {
		public var id:int;
		private var qd_:Boolean;
		private var hasQd_:Boolean = false;
		public function get hasQd():Boolean {
			return hasQd_;
		}
		public function set qd(value:Boolean):void {
			hasQd_ = true;
			qd_ = value;
		}
		public function get qd():Boolean {
			return qd_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasQd) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_BOOL(output, qd);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var qdCount:uint = 0;
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
					if (qdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++qdCount;
					qd = ReadUtils.read_TYPE_BOOL(input);
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
