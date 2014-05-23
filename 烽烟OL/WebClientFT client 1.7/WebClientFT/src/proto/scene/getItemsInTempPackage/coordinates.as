package proto.scene.getItemsInTempPackage {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class coordinates extends Message implements IExternalizable {
		private var p_:int;
		private var hasP_:Boolean = false;
		public function get hasP():Boolean {
			return hasP_;
		}
		public function set p(value:int):void {
			hasP_ = true;
			p_ = value;
		}
		public function get p():int {
			return p_;
		}
		public function writeExternal(output:IDataOutput):void {
			if (hasP) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, p);
			}
		}
		public function readExternal(input:IDataInput):void {
			var pCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (pCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pCount;
					p = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
