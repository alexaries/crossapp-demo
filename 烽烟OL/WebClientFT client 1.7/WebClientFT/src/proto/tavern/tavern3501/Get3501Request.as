package proto.tavern.tavern3501 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Get3501Request extends Message implements IExternalizable {
		public var id:int;
		public var petid:int;
		private var typeid_:int;
		private var hasTypeid_:Boolean = false;
		public function get hasTypeid():Boolean {
			return hasTypeid_;
		}
		public function set typeid(value:int):void {
			hasTypeid_ = true;
			typeid_ = value;
		}
		public function get typeid():int {
			return typeid_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, petid);
			if (hasTypeid) {
				WriteUtils.writeTag(output, WireType.VARINT, 3);
				WriteUtils.write_TYPE_INT32(output, typeid);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var petidCount:uint = 0;
			var typeidCount:uint = 0;
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
					if (petidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++petidCount;
					petid = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (typeidCount != 0) {
						throw new IOError('Bad data format.');
					}
					++typeidCount;
					typeid = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (petidCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
