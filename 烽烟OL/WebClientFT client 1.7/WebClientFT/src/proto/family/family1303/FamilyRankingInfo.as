package proto.family.family1303 {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataOutput;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import proto.family.family1303.FamilyRankingBasicInfo;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class FamilyRankingInfo extends Message implements IExternalizable {
		private var pageCount_:int;
		private var hasPageCount_:Boolean = false;
		public function get hasPageCount():Boolean {
			return hasPageCount_;
		}
		public function set pageCount(value:int):void {
			hasPageCount_ = true;
			pageCount_ = value;
		}
		public function get pageCount():int {
			return pageCount_;
		}
		[ArrayElementType("proto.family.family1303.FamilyRankingBasicInfo")]
		public var familyRankingBasicInfo:Array = [];
		public function writeExternal(output:IDataOutput):void {
			if (hasPageCount) {
				WriteUtils.writeTag(output, WireType.VARINT, 1);
				WriteUtils.write_TYPE_INT32(output, pageCount);
			}
			for (var familyRankingBasicInfoIndex:uint = 0; familyRankingBasicInfoIndex < familyRankingBasicInfo.length; ++familyRankingBasicInfoIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, familyRankingBasicInfo[familyRankingBasicInfoIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			var pageCountCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (pageCountCount != 0) {
						throw new IOError('Bad data format.');
					}
					++pageCountCount;
					pageCount = ReadUtils.read_TYPE_INT32(input);
					break;
				case 2:
					familyRankingBasicInfo.push(ReadUtils.read_TYPE_MESSAGE(input, new proto.family.family1303.FamilyRankingBasicInfo));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
