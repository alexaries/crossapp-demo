package proto.guaji.guaji3205 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class SaoDangRequest extends Message implements IExternalizable {
		public var id:int;
		public var fubenId:int;
		public var sdType:int;
		private var sdRound_:int;
		private var hasSdRound_:Boolean = false;
		public function get hasSdRound():Boolean {
			return hasSdRound_;
		}
		public function set sdRound(value:int):void {
			hasSdRound_ = true;
			sdRound_ = value;
		}
		public function get sdRound():int {
			return sdRound_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			WriteUtils.writeTag(output, WireType.VARINT, 2);
			WriteUtils.write_TYPE_INT32(output, fubenId);
			WriteUtils.writeTag(output, WireType.VARINT, 3);
			WriteUtils.write_TYPE_INT32(output, sdType);
			if (hasSdRound) {
				WriteUtils.writeTag(output, WireType.VARINT, 4);
				WriteUtils.write_TYPE_INT32(output, sdRound);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var fubenIdCount:uint = 0;
			var sdTypeCount:uint = 0;
			var sdRoundCount:uint = 0;
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
					if (fubenIdCount != 0) {
						throw new IOError('Bad data format.');
					}
					++fubenIdCount;
					fubenId = ReadUtils.read_TYPE_INT32(input);
					break;
				case 3:
					if (sdTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sdTypeCount;
					sdType = ReadUtils.read_TYPE_INT32(input);
					break;
				case 4:
					if (sdRoundCount != 0) {
						throw new IOError('Bad data format.');
					}
					++sdRoundCount;
					sdRound = ReadUtils.read_TYPE_INT32(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (idCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (fubenIdCount != 1) {
				throw new IOError('Bad data format.');
			}
			if (sdTypeCount != 1) {
				throw new IOError('Bad data format.');
			}
		}
	}
}
