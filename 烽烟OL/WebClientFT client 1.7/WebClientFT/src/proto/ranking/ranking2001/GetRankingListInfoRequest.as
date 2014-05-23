package proto.ranking.ranking2001 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class GetRankingListInfoRequest extends Message implements IExternalizable {
		public var id:int;
		private var rankingType_:int;
		private var hasRankingType_:Boolean = false;
		public function get hasRankingType():Boolean {
			return hasRankingType_;
		}
		public function set rankingType(value:int):void {
			hasRankingType_ = true;
			rankingType_ = value;
		}
		public function get rankingType():int {
			return rankingType_;
		}
		public function writeExternal(output:IDataOutput):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_INT32(output, id);
			if (hasRankingType) {
				WriteUtils.writeTag(output, WireType.VARINT, 2);
				WriteUtils.write_TYPE_INT32(output, rankingType);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var rankingTypeCount:uint = 0;
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
					if (rankingTypeCount != 0) {
						throw new IOError('Bad data format.');
					}
					++rankingTypeCount;
					rankingType = ReadUtils.read_TYPE_INT32(input);
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
